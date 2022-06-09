from flask import render_template, Flask, Response
from heatmap import app
from heatmap.mainfunc import make_figure, figure_defaults

import plotly
import json
import pandas as pd


@app.route('/demo/flaskapp',methods=['GET', 'POST'])
def flaskapp():
    pa=figure_defaults()
    # df=pd.DataFrame({"i":["AA","BB","CC"],"A":[1,2,4],"B":[5,5,7] })
    df=pd.read_excel("heatmap/egdata.xlsx")
    pa["xvals"]=df.columns.tolist()[0]
    pa["yvals"]=df.columns.tolist()[1:]

    fig, clusters_cols, clusters_rows, df_=make_figure(df,pa)
    figure_url = json.dumps(fig, cls=plotly.utils.PlotlyJSONEncoder)

    return render_template('flaskapp.html', figure_url=figure_url)