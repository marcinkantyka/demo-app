import os
from flask import Flask, render_template
from flask import send_from_directory
import socket



app = Flask(__name__)


@app.route('/')
def index():

    host=(socket.gethostname())

    body_msg = 'World'
    title_msg = 'Hello Ergo!'
    return render_template('index.html', title=title_msg, msg=body_msg, from_host=host)
    



@app.route('/favicon.ico')
def favicon():
    return send_from_directory(os.path.join(app.root_path, 'static'),
                               'favicon.ico', mimetype='image/vnd.microsoft.icon')
    
if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8080, debug=True)
