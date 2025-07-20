import os
import subprocess

print("="*50)
print("Installing requirements...")
os.system("python -m pip install --upgrade pip")
os.system("pip install -r requirements.txt")

print("\n" + "="*50)
print("Training the model...")
os.system("python train.py")

print("\n" + "="*50)
print("Generating report.md...")
with open("report.md", "w") as report:
    report.write("## Model Metrics\n")
    with open("Results/metrics.txt", "r") as metrics_file:
        report.write(metrics_file.read())
    report.write("\n## Confusion Matrix Plot\n")
    report.write("![Confusion Matrix](./Results/model_results.png)\n")

print("\nAll steps completed successfully!")
