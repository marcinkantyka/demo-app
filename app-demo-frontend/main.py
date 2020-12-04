import os
from flask import Flask, render_template
import socket





app = Flask(__name__)


@app.route('/')
def index():

    host=(socket.gethostname())

    body_msg = 'World'
    title_msg = 'Hello Ergo!'
    return render_template('index.html', title=title_msg, msg=body_msg, from_host=host)
    
    
    
if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8080, debug=True)
