#!/usr/bin/env bash
set -euo pipefail

# Configuration
declare -A PRODUCTS=(
    ["EO:EUM:DAT:0686"]="LI_Accumulated_Flashes"
    ["EO:EUM:DAT:0687"]="LI_Accumulated_Flash_Area"
    ["EO:EUM:DAT:0688"]="LI_Accumulated_Flash_Radiance"
    ["EO:EUM:DAT:0665"]="FCI_Level_1c_High_Resolution_Image_Data"
    ["EO:EUM:DAT:0662"]="FCI_Level_1c_Normal_Resolution_Image_Data"
)

BASE_DIR="${HOME}/work/mtg_data"
LOG_DIR="${BASE_DIR}/logs"
SCRIPT_PATH="${HOME}/work/mtg.sh"

# Initialize logging
mkdir -p "${LOG_DIR}"
exec > >(tee -a "${LOG_DIR}/mtg_$(date -u +%Y%m%d).log") 2>&1

# Time calculations
calculate_times() {
    # Get current time in epoch seconds
    local current_epoch=$(date -u +%s)
    
    # Calculate end_time (floor to hour)
    local end_epoch=$(( (current_epoch / 3600) * 3600 ))
    END_TIME=$(date -u -d "@${end_epoch}" +%Y-%m-%dT%H:%M)
    
    # Calculate start_time (10 minutes before end_time)
    local start_epoch=$(( end_epoch - 600 ))  # 600 seconds = 10 minutes
    START_TIME=$(date -u -d "@${start_epoch}" +%Y-%m-%dT%H:%M)
    
    # Determine data directory based on end_time
    local data_dir_date=$(date -u -d "@${end_epoch}" +%Y%m%d)
    local data_dir_hour=$(date -u -d "@${end_epoch}" +%H)
    DATA_DIR="${BASE_DIR}/${data_dir_date}/${data_dir_hour}"
}

# Modified download_product function
download_product() {
    local code=$1
    local product_name=$2
    local product_dir="${DATA_DIR}/${product_name}"
    
    mkdir -p "${product_dir}" || return 1

    echo "Searching for ${product_name} (${code}) between ${START_TIME} - ${END_TIME}"
    
    # Store search results in a variable
    local search_results=$(eumdac search -c "${code}" --start "${START_TIME}" --end "${END_TIME}")
    
    if [ -n "${search_results}" ]; then
        echo "Found products: ${search_results}"
        echo "Downloading ${product_name}..."
        if eumdac download -c "${code}" \
            --start "${START_TIME}" \
            --end "${END_TIME}" \
            --limit 1 \
            -o "${product_dir}" \
            --entry "*.nc" \
            --onedir; then
            # Verify download success
            if [ -n "$(ls -A "${product_dir}")" ]; then
                echo "SUCCESS: Downloaded ${product_name} to ${product_dir}"
                return 0
            fi
        fi
    fi
    
    # Cleanup if no files downloaded
    rm -rf "${product_dir}"
    echo "WARNING: No data available for ${product_name}"
    return 1
}
# Main processing
main() {
    echo "=== Starting MTG data download at $(date -u +'%Y-%m-%d %H:%M:%S UTC') ==="
    
    calculate_times
    mkdir -p "${DATA_DIR}"
    
    for code in "${!PRODUCTS[@]}"; do
        download_product "${code}" "${PRODUCTS[$code]}" || true
    done
    
    # Cleanup empty directories
    find "${DATA_DIR}" -type d -empty -delete
    find "${BASE_DIR}" -mindepth 1 -type d -mmin +2880 -exec rm -rf {} +
    
    echo "=== Completed processing at $(date -u +'%Y-%m-%d %H:%M:%S UTC') ==="
}


