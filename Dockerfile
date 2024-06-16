FROM python:3.8-slim-buster

# Install necessary packages
RUN apt update -y && apt install awscli -y && \
    apt clean && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy dependency files first to leverage Docker cache
COPY requirements.txt requirements.txt
COPY pyproject.toml pyproject.toml

# Install dependencies
RUN pip install -r requirements.txt

# Copy the application files
COPY se489_group_project/ se489_group_project/
COPY models/ models/
COPY templates/ templates/
COPY app.py app.py

# Set the command to run the application
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8080"]
