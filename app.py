import gradio as gr
from App.drug_app import predict_drug, inputs, outputs, examples, title, description, article

# Launch Gradio app
gr.Interface(
    fn=predict_drug,
    inputs=inputs,
    outputs=outputs,
    examples=examples,
    title=title,
    description=description,
    article=article,
    theme=gr.themes.Soft(),
).launch()
