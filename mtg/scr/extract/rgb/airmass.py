from satpy import Scene
from glob import glob
import os
from datetime import datetime

# Configuration
BASE_DIR = os.path.expanduser("/home/pnt/disque2/FCI")
OUTPUT_DIR = os.path.expanduser("/home/pnt/work/output/composites/airmass")
COMPOSITES = ["airmass"]  # Keep as list for loading multiple composites if needed

os.makedirs(OUTPUT_DIR, exist_ok=True)

def process_time_window(date_str, time_str, body_files):
    """Process 40 BODY files for a 10-minute window"""
    try:
        print(f"\nProcessing {date_str}-{time_str}")
        print(f"Found {len(body_files)} BODY files")
        
        # Create and load scene with all body files
        scn = Scene(filenames=body_files, reader="fci_l1c_nc")
        
        # Load the composite(s)
        scn.load(COMPOSITES)
        
        # Create output filename from time window
        output_path = os.path.join(
            OUTPUT_DIR, 
            f"airmass_{date_str}-{time_str}.tif"
        )
        
        # Save the composite (use first element of the list)
        scn.save_dataset(
            COMPOSITES[0],  # Pass the string instead of the list
            filename=output_path,
            writer='geotiff',
            crs="EPSG:4326",
            resampler='nearest',
            enhance=True
        )
        print(f"Saved composite to {output_path}")
        
    except Exception as e:
        print(f"Error processing {date_str}-{time_str}: {str(e)}")
# Main processing loop
for root, dirs, files in os.walk(BASE_DIR):
    # Skip directories without files
    if not files:
        continue
        
    # Get date and time from directory structure
    path_parts = root.split('/')
    date_str = path_parts[-2]
    time_str = path_parts[-1]
    
    # Filter only BODY files (40 per window)
    body_files = [
        os.path.join(root, f) 
        for f in files 
        if 'BODY' in f and 'TRAIL' not in f
    ][:40]  # Ensure max 40 files
    
    if len(body_files) == 40:
        process_time_window(date_str, time_str, body_files)
    else:
        print(f"Skipping {date_str}-{time_str} - found {len(body_files)} BODY files")

print("Processing complete!")
