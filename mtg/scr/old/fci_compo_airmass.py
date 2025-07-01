from satpy import Scene
from glob import glob
import os
from datetime import datetime

# Configuration
BASE_DIR = os.path.expanduser("~/work/data/20250523")
OUTPUT_DIR = os.path.expanduser("~/work/scr/fci_composites")
COMPOSITES = ["airmass"]

os.makedirs(OUTPUT_DIR, exist_ok=True)

# Fixed line with proper parenthesis closure
files = sorted(glob(os.path.join(BASE_DIR, "*FCI-1C-RRAD*BODY*.nc"))) 
print(f"Found {len(files)} FCI files")

for idx, f in enumerate(files):
    try:
        print(f"\nProcessing {idx+1}/{len(files)}: {os.path.basename(f)}")
        
        scn = Scene(filenames=[f], reader="fci_l1c_nc")
        
        # Extract timestamp (adjust split index as needed)
        timestamp_str = os.path.basename(f).split("_")[8]  # 20250522060434
        dt = datetime.strptime(timestamp_str, "%Y%m%d%H%M%S")
        
        # Load composite
        scn.load(COMPOSITES)
        
        # Save each composite
        for composite in COMPOSITES:
            if composite in scn:
                output_path = os.path.join(
                    OUTPUT_DIR,
                    f"{composite}_{dt:%Y%m%d_%H%M%S}.tif"
                )
                
                scn.save_dataset(
                    composite,
                    filename=output_path,
                    enhance=True,
                    writer='geotiff',
                    crs="+proj=geos +h=35785831 +lon_0=0",
                )
                print(f"Saved {composite} composite")
                
    except Exception as e:
        print(f"Error processing {os.path.basename(f)}: {str(e)}")
        continue

print("Composite processing complete!")
