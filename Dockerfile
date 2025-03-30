FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 80

ENV FLASK_APP=app:app

# Make startup script executable
RUN chmod +x start.sh

# Run the script when the container starts
CMD ["./start.sh"]
