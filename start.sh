#!/bin/sh

echo "Running database migrations..."
flask db upgrade

echo "Starting Flask app..."
flask run --host=0.0.0.0 --port=80
