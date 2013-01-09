import os
from flask import Flask
from flask import render_template

app = Flask(__name__)

app = Flask(__name__)
#app.config.from_object('app.default_settings')
app.config.from_envvar('APPLICATION_SETTINGS')

#app.debug = True

@app.route('/')
def home():
    return render_template('index.html')

#@app.route('/channel')
#def channel():
#    return render_template('channel.html')


if __name__ == '__main__':
    # Bind to PORT if defined, otherwise default to 5000.
    app.debug = True
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port)