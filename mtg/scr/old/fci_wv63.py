from satpy import Scene
from glob import glob
import os
from datetime import datetime

# Configuration
BASE_DIR = os.path.expanduser("~/work/data/20250523")
OUTPUT_DIR = os.path.expanduser("~/work/scr/fci_outputs")
CHANNELS = ['wv_63']  # Add other channels as needed: 'ir_105', 'nir_13', etc.

os.makedirs(OUTPUT_DIR, exist_ok=True)

# Find FCI files using pattern matching
files = sorted(glob(os.path.join(BASE_DIR, "*FCI-1C-RRAD*BODY*.nc")))
print(f"Found {len(files)} FCI files")

for idx, f in enumerate(files):
    try:
        print(f"\nProcessing {idx+1}/{len(files)}: {os.path.basename(f)}")
        
        # Create and load scene
        scn = Scene(filenames=[f], reader="fci_l1c_nc")
        
        # Extract timestamp from filename (adjust index based on your filename pattern)
        timestamp_str = os.path.basename(f).split("_")[8]  # 20250522060434
        dt = datetime.strptime(timestamp_str, "%Y%m%d%H%M%S")
        
        # Load and process channels
        scn.load(CHANNELS, upper_right_corner='NE')
        
        # Save each channel
        for channel in CHANNELS:
            if channel in scn:
                output_path = os.path.join(OUTPUT_DIR, f"{channel}_{dt:%Y%m%d-%H%M%S}.tif")
                scn.save_dataset(
                    channel,
                    filename=output_path,
                    enhance=True,
                    writer='geotiff',
                    crs="+proj=geos +h=35785831 +lon_0=0"
                )
                print(f"Saved {channel} to {output_path}")
                
    except Exception as e:
        print(f"Error processing {os.path.basename(f)}: {str(e)}")
        continue

print("FCI processing complete!")
