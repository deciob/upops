import os
from flask import Flask
from flask import render_template

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('index.html')

#@app.route('/channel')
#def channel():
#    return render_template('channel.html')


if __name__ == '__main__':
    # Bind to PORT if defined, otherwise default to 5000.
    port = int(os.environ.get('PORT', 5000))
    if port == 5000:
      app.debug = True
    else:
      app.debug = False
    app.run(host='0.0.0.0', port=port)