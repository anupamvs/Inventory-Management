from flask import Flask
import json
from flask_sqlalchemy import SQLAlchemy
from flask_login import LoginManager

with open("config.json") as temp:
    config = json.load(temp)

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+mysqldb://root:root@localhost/docs_inventory'
app.config['SECRET_KEY'] = b'_5#y2L"F4Q8z\n\xec]/'
db = SQLAlchemy(app)
login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = 'login'

from views import *
if __name__ == "__main__":
    app.run(debug=True)
