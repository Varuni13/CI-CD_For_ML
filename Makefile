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
	huggingface-cli repo create your-space-name --type space --yes || true
	huggingface-cli upload ./App/* --Singhvar/Drug_Classification
	huggingface-cli upload ./Model/* --Singhvar/Drug_Classification
	huggingface-cli upload ./Results/* --Singhvar/Drug_Classification


	
deploy: hf-login push-hub

