from huggingface_hub import HfApi, HfFolder
import os

# Define variables
repo_id = "Singhvar/Drug_Classification"  # Replace with your Space name
token = os.getenv("HF_TOKEN")  # Hugging Face token from secrets

api = HfApi()
HfFolder.save_token(token)

# Create the repo if it doesn't exist
api.create_repo(repo_id=repo_id, repo_type="space", space_sdk="gradio", exist_ok=True)

# Upload files
print("Uploading files to Hugging Face Space...")
api.upload_file(path_or_fileobj="app.py", path_in_repo="app.py", repo_id=repo_id, repo_type="space")
api.upload_file(path_or_fileobj="requirements.txt", path_in_repo="requirements.txt", repo_id=repo_id, repo_type="space")

# Upload Model folder
api.upload_folder(folder_path="Model", path_in_repo="Model", repo_id=repo_id, repo_type="space")

# Upload Results folder
api.upload_folder(folder_path="Results", path_in_repo="Results", repo_id=repo_id, repo_type="space")

print("Deployment successful!")
