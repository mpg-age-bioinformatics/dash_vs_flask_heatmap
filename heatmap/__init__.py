from flask import Flask
app = Flask(__name__)

from heatmap import dashapp, flaskapp

@app.route('/')
def hello_world():
    return 'Demo site for dash vs. flask plotly heatmap renderings.'