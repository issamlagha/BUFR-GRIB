import xarray as xr
import pygmt

# Define the path to your GRIB file
fid_grib = 'gfs.t00z.pgrb2full.0p50.f012'

# List of parameters to extract from the GRIB file (use available variables)
parameters = ['prmsl', 'clwmr', 'icmr', 'rwmr', 'snmr', 'grle', 'refd']

# List of additional keys to read from the GRIB file
list_keys = ['pv']

# Initialize an empty list to store datasets
datasets = []

# Loop through each parameter and read the corresponding data from the GRIB file
for shortName in parameters:
    print(f'Reading parameter: {shortName}')
    try:
        filter_by_keys = {
            'shortName': shortName
        }
        # Adjust 'typeOfLevel' for specific variables
        if shortName == 'prmsl':
            filter_by_keys['typeOfLevel'] = 'meanSea'
        else:
            filter_by_keys['typeOfLevel'] = 'hybrid'
        
        ds = xr.open_dataset(
            fid_grib,
            engine='cfgrib',
            backend_kwargs={
                'read_keys': list_keys,
                'filter_by_keys': filter_by_keys
            }
        )
        datasets.append(ds)
    except Exception as e:
        print(f"Error reading {shortName}: {e}")

# Merge all datasets into a single dataset
if datasets:
    merged_ds = xr.merge(datasets)
    print("Merged dataset variables:", list(merged_ds.variables))
else:
    raise ValueError("No datasets were successfully read.")

# Select a variable to plot (use an available variable, e.g., 'clwmr')
if 'clwmr' in merged_ds.variables:
    # Check the dimensions of 'clwmr'
    print("Dimensions of 'clwmr':", merged_ds["clwmr"].dims)
    
    # Use the variable directly (no need to select by time or level)
    var = merged_ds["clwmr"]
else:
    raise KeyError("The variable 'clwmr' is not in the dataset.")

# Initialize a PyGMT figure
fig = pygmt.Figure()

# Plot the selected variable using grdimage
fig.grdimage(
    grid=var,
    projection='M15c',  # Mercator projection with a width of 15 cm
    frame=True,         # Add a frame around the plot
    cmap='viridis',     # Use the 'viridis' colormap
    shading=True,       # Add shading to the plot
    transparency=30     # Set transparency level (0-100)
)

# Add a colorbar to the plot
fig.colorbar(position="JBC+ef", frame="af+l@;Variable Unit@;")

# Show the plot
fig.show()

# Save the plot to a file (optional)
fig.savefig('output_plot.png', dpi=300)
