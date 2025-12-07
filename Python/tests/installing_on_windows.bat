@echo off
setlocal

:: 1. Capture Start Time
set "start_time=%time%"
echo --- Starting Environment Setup ---

:: 2. Check/Create requirements.txt
if not exist "requirements.txt" (
    echo requirements.txt not found. Creating one...
    (echo pandas==2.3.3 & echo plotly==6.5.0) > requirements.txt
)

:: 3. Create the Python Virtual Environment (.venv)
echo Creating virtual environment (.venv)...
python -m venv .venv

:: 4. Install Dependencies
:: We point directly to the python executable inside the venv
echo Installing packages from requirements.txt...
.venv\Scripts\python.exe -m pip install -r requirements.txt

:: 5. Capture End Time & Calculate Duration
set "end_time=%time%"

echo ----------------------------------
echo Setup Complete!
echo Start Time: %start_time%
echo End Time:   %end_time%

:: Calculating time difference in pure Batch is complex, so we use a 
:: one-line PowerShell helper here to do the math accurately.
powershell -NoProfile -Command "$s = [DateTime]::Parse('%start_time%'); $e = [DateTime]::Parse('%end_time%'); Write-Host 'Total Time Taken: ' ($e - $s)"
echo ----------------------------------

pause