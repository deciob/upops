Urban population prospects
====

poprosps

## How to clone the repo:
```
# Move into a directory of your choice:
cd
git clone git@github.com:deciob/upops.git

```

## How to setup python virtualenv and Flask development server:
```
pip install virtualenv

cd
mkdir .virtualenv
cd .virtualenv
virtualenv --distribute flask

# This must be done every time you need to activate the flask virtualenv.
source ~/.virtualenv/flask/bin/activate

# Only needs to be done once.
pip install -r requirements.txt

# Move back to the upops directory...
cd ~/upops
# ... and run the flask development server!
python app.py

# Open your browser at:
# http://0.0.0.0:5000/ 

```

