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
	@echo "Pushing files to Hugging Face Space..."
	huggingface-cli repo create your-space-name --type=space --sdk=gradio --yes
	huggingface-cli upload ./App --repo Singhvar/Drug_Classification --path / --token $(HF_TOKEN)
	huggingface-cli upload ./Model --repo Singhvar/Drug_Classification --path /Model --token $(HF_TOKEN)
	huggingface-cli upload ./Results --repo Singhvar/Drug_Classification --path /Results --token $(HF_TOKEN)

# Deployment
deploy:
	make hf-login HF_TOKEN=$(HF_TOKEN)
	make push-hub HF_TOKEN=$(HF_TOKEN)
