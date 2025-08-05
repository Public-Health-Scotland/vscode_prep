# Start timer
start_time=$(date +%s)

# Run pip install
pip install -r requirements.txt

# End timer
end_time=$(date +%s)

# Calculate duration
duration=$((end_time - start_time))

# Output the result
echo "Installation completed in $duration seconds."