#!/bin/bash

#Building the project
echo "Zap @_@, I am building the project...."
python3.9 -m pip install -r requirements.txt

#Run the project 
echo "Zap @_@, I am migrating the project..."
python3.9 manage.py makemigrations --no-input
python3.9 manage.py migrate --no-input

#Collecting the static files 
echo "Zap @_@, I am collecting the Static stuff...."
python3.9 manage.py collectstatic --no-input --clear

