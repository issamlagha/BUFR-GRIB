import os
import glob
from datetime import datetime
from collections import defaultdict

# Configuration
SRC_ROOT = "/home/pnt/work/data/20250523"
DEST_ROOT = "/home/pnt/disque2"
PRODUCT_TYPES = ["FCI", "LI_AFA", "LI_AFR"]

def organize_with_links():
    file_groups = defaultdict(list)
    
    # First pass: Group files by product type and time window
    for product in PRODUCT_TYPES:
        pattern = os.path.join(SRC_ROOT, "**", f"*{product}*.nc")
        for fpath in glob.glob(pattern, recursive=True):
            fname = os.path.basename(fpath)
            
            # Extract timestamp
            try:
                ts_str = fname.split("_")[4]
                dt = datetime.strptime(ts_str, "%Y%m%d%H%M%S")
            except (IndexError, ValueError):
                continue
            
            # Create time window key (rounded to 10 minutes)
            window = dt.replace(minute=(dt.minute // 10) * 10, second=0, microsecond=0)
            date_str = dt.strftime("%Y%m%d")
            time_str = window.strftime("%H%M")
            
            key = (product, date_str, time_str)
            file_groups[key].append(fpath)
    
    # Second pass: Create links enforcing 41-file requirement
    for (product, date, time), files in file_groups.items():
        # Create directory structure
        dest_dir = os.path.join(DEST_ROOT, product, date, time)
        os.makedirs(dest_dir, exist_ok=True)
        
        # Create links for first 41 files
        for idx, src_path in enumerate(files[:41]):
            link_name = os.path.join(dest_dir, os.path.basename(src_path))
            if not os.path.exists(link_name):
                os.symlink(os.path.abspath(src_path), link_name)
        
        # Warn if not exactly 41 files
        if len(files) != 41:
            print(f"Warning: {product}/{date}/{time} has {len(files)} files (expected 41)")

if __name__ == "__main__":
    organize_with_links()
