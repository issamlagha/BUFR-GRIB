#!/bin/bash

input_dir="/home/pnt/work/output/channels"
output_dir="/home/pnt/work/output/reprojected_channels"

mkdir -p "$output_dir"

# Process only TIFF files under the ir_105 subdirectory
find "$input_dir/vis_08" -type f -name "*.tif" | while read -r tif_file; do
    # Get the relative path (e.g., ir_105/filename.tif)
    relative_path="${tif_file#$input_dir/}"
    # Create the output subdirectory (e.g., reprojected_channels/ir_105)
    mkdir -p "$output_dir/$(dirname "$relative_path")"
    # Define the output file path
    output_file="$output_dir/$relative_path"
    # Reproject to WGS84 (EPSG:4326)
    gdalwarp -t_srs EPSG:4326 "$tif_file" "$output_file"
done
