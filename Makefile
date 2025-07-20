install:
	pip install --upgrade pip && \
		pip install -r requirements.txt

format:
	black *.py

train:
	python train.py

eval:
	echo "## Model Metrics" > report.md
	cat ./Results/metrics.txt >> report.md

	echo '\n## Confusion Matrix Plot' >> report.md
	echo '![Confusion Matrix](./Results/model_results.png)' >> report.md

	cml comment create report.md

# Login to Hugging Face
hf-login:
	@echo "Logging in to Hugging Face..."
	huggingface-cli login --token $(HF_TOKEN)

# Push files to Hugging Face Space
	push-hub:
		python deploy.py

	
deploy: hf-login push-hub

