#!/bin/bash

# Function to check if a directory exists and create it if necessary
create_directory() {
  if [ ! -d "$1" ]; then
    mkdir -p "$1"
  fi
}

# Prompt user to enter the year and month
read -p "Enter the year (YYYY): " year
read -p "Enter the month (MM): " month

# SFTP connection details
USER="pnt"
HOST="192.168.0.122"
SSH_KEY="/home/lagha/.ssh/pnt"  # Path to your private key
REMOTE_BASE_DIR="/home/cnpm/BDO/out/SYNOP/BUFR/ISM/${year}/${month}"
LOCAL_BASE_DIR="/home/lagha/data/bufr/synop"
FILE_PATTERN="ISM*DAMM*"

# Hours of interest
hours=(00 06 12 18)

# Loop through each day directory
for day in {01..31}; do  # Assume maximum 31 days for simplicity
  for hour in "${hours[@]}"; do
    # Construct the remote and local paths
    REMOTE_DIR="${REMOTE_BASE_DIR}/${day}/${hour}"
    LOCAL_DIR="${LOCAL_BASE_DIR}/${year}/${month}/${day}/${hour}"
    
    # Create local directory if it doesn't exist
    create_directory "${LOCAL_DIR}"
    
    # SFTP command to check if files exist
    sftp -i ${SSH_KEY} ${USER}@${HOST} <<EOF
cd ${REMOTE_DIR}
ls ${FILE_PATTERN} >/dev/null 2>&1
EOF
    
    # If files exist, concatenate them
    if [ $? -eq 0 ]; then
      # Concatenate files into a single file
      cat ${LOCAL_DIR}/${FILE_PATTERN} > "${LOCAL_DIR}/synop_${year}${month}${day}${hour}00.bufr"
    fi
  done
done

# Remove individual files after concatenation
find ${LOCAL_BASE_DIR}/${year}/${month} -type f -name "${FILE_PATTERN}" -delete

