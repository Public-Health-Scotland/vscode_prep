# Open a terminal - run this bash with the following command: bash test.sh | tee output.txt

for folder in /opt/python/*; do
    name=$(basename "$folder")
    if [ -d "$folder" ] && [[ "$name" == 3.* ]]; then
        pip_path="$folder/bin/pip"
        echo "📦 Python Packages in $folder:"
        "$pip_path" list
        echo "----------------------------------------"
    fi
done

# Start timer
start_time=$(date +%s)

# MYHOME="$HOME"
MYHOME=$HOME

if [ -d "$MYHOME/test_01" ]; then
    echo "Virtual environment already exists at $MYHOME/test_01"
else
    echo "Creating virtual environment at $MYHOME/test_01"
    /opt/python/3.12.6/bin/python3.12 -m venv $MYHOME/test_01
fi
source "$MYHOME/test_01/bin/activate"

echo "Packages installed in current venv:"
pip list

# Run pip install
pip install --upgrade pip wheel
pip install pandas==2.3.1
# pip install -r requirements.txt

# Print Python version
echo "Python version in current vemv:"
python --version

# Print pandas version
echo "Pandas version in current venv:"
python -c "import pandas as pd; print(pd.__version__)"

deactivate

# Calculate duration
end_time=$(date +%s)
duration=$((end_time - start_time))

# Output the result
echo "Installation completed in $duration seconds."