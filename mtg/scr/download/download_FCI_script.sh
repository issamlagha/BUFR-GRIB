for product_code in "0662"; do
  eumdac download -c "EO:EUM:DAT:${product_code}" \
    --start "2025-05-22T06:00:00" \
    --end "2025-05-22T12:00:00" \
    -o "data/20250523" \
    --entry "*.nc" \
    --onedir
done
