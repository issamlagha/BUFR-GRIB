#!/bin/bash

# Function to check if a directory exists and create it if necessary
create_directory() {
  if [ ! -d "$1" ]; then
    mkdir -p "$1"
  fi
}

# Prompt user to enter the start and end dates
read -p "Enter the start date (YYYY-MM-DD): " start_date
read -p "Enter the end date (YYYY-MM-DD): " end_date

# Parse start and end dates
start_timestamp=$(date -d "$start_date" +%s)
end_timestamp=$(date -d "$end_date" +%s)

# SFTP connection details
USER="pnt"
HOST="192.168.0.122"
SSH_KEY="/home/lagha/.ssh/pnt"  # Path to your private key
REMOTE_BASE_DIR="/home/cnpm/BDO/out/SYNOP/BUFR/ISM/"
LOCAL_BASE_DIR="/home/lagha/data/bufr/synop"
FILE_PATTERN="ISM*DAMM*"

# Hours of interest
hours=(00 06 12 18)

# Output file for listing files
LISTING_FILE="${LOCAL_BASE_DIR}/listing_${start_date}_${end_date}.txt"

# Counters for empty and full files
empty_count=0
full_count=0

# Loop through each day directory
current_timestamp=$start_timestamp
while [ $current_timestamp -le $end_timestamp ]; do
  # Construct the current date
  current_date=$(date -d "@$current_timestamp" "+%Y-%m-%d")
  
  # Extract year, month, and day
  year=$(date -d "$current_date" "+%Y")
  month=$(date -d "$current_date" "+%m")
  day=$(date -d "$current_date" "+%d")
  
  for hour in "${hours[@]}"; do
    # Construct the remote and local paths
    REMOTE_DIR="${REMOTE_BASE_DIR}/${year}/${month}/${day}/${hour}"
    LOCAL_DIR="${LOCAL_BASE_DIR}/${year}/${month}/${day}/${hour}"
    
    # Create local directory if it doesn't exist
    create_directory "${LOCAL_DIR}"
    
    # Check if files exist on the remote server
    sftp_output=$(sftp -i ${SSH_KEY} ${USER}@${HOST} <<EOF
cd ${REMOTE_DIR}
ls ${FILE_PATTERN}
EOF
)
    # Check if files were found
    if [[ $sftp_output == *"${FILE_PATTERN}"* ]]; then
      # Download files
      sftp -i ${SSH_KEY} ${USER}@${HOST} <<EOF
lcd ${LOCAL_DIR}
cd ${REMOTE_DIR}
mget ${FILE_PATTERN}
EOF
      
      # Concatenate files into a single file
      output_file="${LOCAL_DIR}/synop_${year}${month}${day}${hour}00.bufr"
      cat ${LOCAL_DIR}/${FILE_PATTERN} > "$output_file"
      
      # Verify size of concatenated file
      file_size=$(stat -c %s "$output_file")
      
      # If size is zero, echo and add to empty files list
      if [ $file_size -eq 0 ]; then
        echo "File $output_file is empty" >> "${LISTING_FILE}"
        ((empty_count++))
      else
        ((full_count++))
      fi
      
      # Clean up downloaded individual files
      rm ${LOCAL_DIR}/${FILE_PATTERN}
    else
      echo "No files found in ${REMOTE_DIR}" >> "${LISTING_FILE}"
    fi
  done
  
  # Move to the next day
  current_timestamp=$(date -d "$current_date +1 day" +%s)
done

# Output counts
echo "Number of empty bufr files: $empty_count" >> "${LISTING_FILE}"
echo "Number of full bufr files: $full_count" >> "${LISTING_FILE}"

