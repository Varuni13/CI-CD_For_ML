import gradio as gr
import skops.io as sio

model_path = "./Model/drug_pipeline.skops"

# Load the model safely with trusted types
untrusted_types = sio.get_untrusted_types(file=model_path)
pipe = sio.load(model_path, trusted=untrusted_types)

def predict_drug(age, sex, blood_pressure, cholesterol, na_to_k_ratio):
    features = [age, sex, blood_pressure, cholesterol, na_to_k_ratio]
    predicted_drug = pipe.predict([features])[0]
    return f"Predicted Drug: {predicted_drug}"

# Define Gradio UI components
inputs = [
    gr.Slider(15, 74, step=1, label="Age"),
    gr.Radio(["M", "F"], label="Sex"),
    gr.Radio(["HIGH", "LOW", "NORMAL"], label="Blood Pressure"),
    gr.Radio(["HIGH", "NORMAL"], label="Cholesterol"),
    gr.Slider(6.2, 38.2, step=0.1, label="Na_to_K"),
]

outputs = [gr.Label(num_top_classes=5)]

examples = [
    [30, "M", "HIGH", "NORMAL", 15.4],
    [35, "F", "LOW", "NORMAL", 8],
    [50, "M", "HIGH", "HIGH", 34],
]

title = "Drug Classification"
description = "Enter the details to correctly identify Drug type?"
article = "This app is part of the CI/CD pipeline for drug classification."
