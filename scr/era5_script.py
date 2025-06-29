#!/usr/bin/python3

import cdsapi

year=2024
month=12
day=31

c = cdsapi.Client()
c.retrieve('reanalysis-era5-single-levels',
    {
        'product_type': 'reanalysis',
        'variable': [
            '10m_u_component_of_wind',
	    '10m_v_component_of_wind', 
            '2m_temperature',	
	    'mean_sea_level_pressure', 	
            'total_precipitation',
        	    ],
        'year': '2024',
        'month': '01',
        'day': '31',
        'time': ['00:00', '03:00', '06:00', '09:00', '12:00', '15:00', '18:00', '21:00'],
        'area': [60, -40, 15, 20],
        'format': 'grib',
    },
    'era5.grib')
