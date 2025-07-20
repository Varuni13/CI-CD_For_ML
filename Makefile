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

# Login to Hugging Face (Git)
hf-login:
	@echo "Setting up Hugging Face authentication..."
	git config --global user.email "varunisingh131096@gmail.com"
	git config --global user.name "Varuni13"

# Push files to Hugging Face Space using Git
push-hub:
	@echo "Cloning Hugging Face Space repository..."
	rm -rf Drug_Classification || true
	git clone https://huggingface.co/spaces/Singhvar/Drug_Classification
	cp app.py Drug_Classification/
	cp requirements.txt Drug_Classification/
	cp -r Model Drug_Classification/
	cp -r Results Drug_Classification/
	cd Drug_Classification && git add . && git commit -m "Update Space files" || true
	cd Drug_Classification && git push

# Deploy the app
deploy: hf-login push-hub
