#!/bin/bash

INPUT_DIR="/home/pnt/work/output/channels"
OUTPUT_DIR="/home/pnt/work/output/reprojected_channels"

# Crée le répertoire de sortie
mkdir -p "$OUTPUT_DIR"

# Boucle sur chaque sous-dossier (canal)
for channel in "$INPUT_DIR"/*; do
    [ -d "$channel" ] || continue  # Sauter si ce n’est pas un dossier
    channel_name=$(basename "$channel")
    mkdir -p "$OUTPUT_DIR/$channel_name"

    # Boucle sur chaque fichier .tif du canal
    for tif_file in "$channel"/*.tif; do
        filename=$(basename "$tif_file")
        output_file="$OUTPUT_DIR/$channel_name/${filename%.tif}.tif"

        echo "Reprojecting $tif_file to $output_file..."
        gdalwarp -t_srs EPSG:4326 "$tif_file" "$output_file"
    done
done

echo "✅ All channels reprojected to $OUTPUT_DIR"

