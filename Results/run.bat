@echo off
echo ==============================================
echo Installing requirements...
echo ==============================================
python -m pip install --upgrade pip
pip install -r requirements.txt

echo.
echo ==============================================
echo Training the model...
echo ==============================================
python train.py

echo.
echo ==============================================
echo Generating report.md...
echo ==============================================
(
    echo ## Model Metrics
    type .\Results\metrics.txt
    echo.
    echo ## Confusion Matrix Plot
    echo ![Confusion Matrix](./Results/model_results.png)
) > report.md

echo.
echo ==============================================
echo All steps completed successfully!
echo ==============================================
pause
