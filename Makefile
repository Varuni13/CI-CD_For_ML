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
	pip install -U "huggingface_hub[cli]"
	huggingface-cli login --token $(HF_TOKEN)

# Push files to Hugging Face Space
push-hub:
	@echo "Pushing files to Hugging Face Space..."
	huggingface-cli repo create Singhvar/Drug_Classification --repo-type=space --space-sdk=gradio || true
	huggingface-cli upload ./app.py --repo-id Singhvar/Drug_Classification --repo-type=space
	huggingface-cli upload ./requirements.txt --repo-id Singhvar/Drug_Classification --repo-type=space
	huggingface-cli upload ./Model --repo-id Singhvar/Drug_Classification --repo-type=space
	huggingface-cli upload ./Results --repo-id Singhvar/Drug_Classification --repo-type=space

# Deploy the app
deploy: hf-login push-hub
