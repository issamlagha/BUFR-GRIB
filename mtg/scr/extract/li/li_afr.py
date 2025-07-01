from satpy import Scene
from glob import glob
import os
from datetime import datetime

# Correct base directory
BASE_DIR = os.path.expanduser("~/work/data/20250523")
OUTPUT_DIR = os.path.expanduser("~/work/scr/outputs")
os.makedirs(OUTPUT_DIR, exist_ok=True)

# Fixed line with proper parenthesis closure
files = sorted(glob(os.path.join(BASE_DIR, "*AFR*BODY*0001.nc")))

print(f"Found {len(files)} files")

for f in files:
    try:
        print(f"\nProcessing: {os.path.basename(f)}")
        
        scn = Scene(filenames=[f], reader="li_l2_nc")
        scn.load(["flash_radiance"])
        
        # Generate output path safely
        timestamp = datetime.strptime(os.path.basename(f).split("_")[4], "%Y%m%d%H%M%S")
        output_path = os.path.join(OUTPUT_DIR, f"flash-radiance_{timestamp:%Y%m%d-%H%M%S}.tif")
        
        scn.save_dataset("flash_radiance", 
                        filename=output_path,
                        enhance=True)
        
        print(f"Successfully created: {output_path}")
        
    except Exception as e:
        print(f"Failed: {str(e)}")
