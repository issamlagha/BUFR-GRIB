import os
import numpy as np
import pandas as pd
from datetime import datetime
from pybufrkit.decoder import Decoder
from pybufrkit.dataquery import NodePathParser, DataQuerent
from concurrent.futures import ProcessPoolExecutor

INPUT_DIR = '/home/lagha/data/bufr'
NUM_CORES = 20

def query_bufr_data(input_file, query):
    decoder = Decoder()
    querent = DataQuerent(NodePathParser())
    with open(input_file, 'rb') as f:
        bufr_message = decoder.process(f.read())
        result = querent.query(bufr_message, query)
        return result

def process_bufr_file(file_path):
    # Query the necessary data
    latitudes_result = query_bufr_data(file_path, '005001')
    longitudes_result = query_bufr_data(file_path, '006001')
    years_result = query_bufr_data(file_path, '004001')
    months_result = query_bufr_data(file_path, '004002')
    days_result = query_bufr_data(file_path, '004003')
    hours_result = query_bufr_data(file_path, '004004')
    minutes_result = query_bufr_data(file_path, '004005')
    seconds_result = query_bufr_data(file_path, '004006')
    brightness_temperatures_result = query_bufr_data(file_path, '012063')
    channel_frequencies_result = query_bufr_data(file_path, '002153')
    land_sea_mask_result = query_bufr_data(file_path, '008012')

    # Extract values from OrderedDict
    latitudes = [value[0] for value in latitudes_result.results.values()]
    longitudes = [value[0] for value in longitudes_result.results.values()]
    years = [value[0] for value in years_result.results.values()]
    months = [value[0] for value in months_result.results.values()]
    days = [value[0] for value in days_result.results.values()]
    hours = [value[0] for value in hours_result.results.values()]
    minutes = [value[0] for value in minutes_result.results.values()]
    seconds = [value[0] for value in seconds_result.results.values()]
    brightness_temperatures = [value[0] for value in brightness_temperatures_result.results.values()]
    land_sea_masks = [value[0] for value in land_sea_mask_result.results.values()]

    # Reshape the brightness temperatures array to (461, 11, 6)
    brightness_temperatures = np.array(brightness_temperatures)

    # Convert date and time to datetime format
    datetimes = [datetime(year, month, day, hour, minute, second) for year, month, day, hour, minute, second in
                 zip(years, months, days, hours, minutes, seconds)]

    # Extract TIR1 and TIR2 brightness temperatures (second element along the third dimension)
    tir1_bts = brightness_temperatures[:, 8, 1]  # 9th value (0-indexed 8) and second element
    tir2_bts = brightness_temperatures[:, 9, 1]  # 10th value (0-indexed 9) and second element

    # Create a DataFrame
    df = pd.DataFrame({
        'lat': latitudes,
        'lon': longitudes,
        'datetime': datetimes,
        'tir1_bt': tir1_bts,
        'tir2_bt': tir2_bts,
        'land_sea_mask': land_sea_masks
    })
    
    return df

def process_all_bufr_files(input_dir, num_cores):
    all_files = [os.path.join(input_dir, filename) for filename in os.listdir(input_dir)]
    
    with ProcessPoolExecutor(max_workers=num_cores) as executor:
        results = list(executor.map(process_bufr_file, all_files))
    
    # Concatenate all dataframes
    combined_df = pd.concat(results, ignore_index=True)
    return combined_df

# Process all BUFR files and create a combined DataFrame
combined_df = process_all_bufr_files(INPUT_DIR, NUM_CORES)

# Save the combined DataFrame to a CSV file
combined_df.to_csv('meteosat.csv', index=False)

# # Optionally, save to other formats like Excel
# combined_df.to_excel('combined_brightness_temperatures.xlsx', index=False)

