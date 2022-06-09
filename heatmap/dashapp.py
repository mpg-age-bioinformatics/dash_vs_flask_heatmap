import dash
from dash import dcc, html
from dash.dependencies import Input, Output, State, MATCH, ALL

import pandas as pd
from heatmap.mainfunc import make_figure, figure_defaults

from heatmap import app

dashapp = dash.Dash("dashapp",url_base_pathname=f'/demo/dashapp/', server=app )

pa=figure_defaults()
# df=pd.DataFrame({"i":["AA","BB","CC"],"A":[1,2,4],"B":[5,5,7] })
df=pd.read_excel("heatmap/egdata.xlsx")
pa["xvals"]=df.columns.tolist()[0]
pa["yvals"]=df.columns.tolist()[1:]

fig, clusters_cols, clusters_rows, df_=make_figure(df,pa)
fig_config={ 'modeBarButtonsToRemove':["toImage"], 'displaylogo': False}
fig=dcc.Graph(figure=fig,config=fig_config,  id="graph", responsive=True)

dashapp.layout=html.Div( 
    fig
)