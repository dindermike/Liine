FROM ubuntu:24.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install minimal required packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3.12 \
    python3-pip \
    python3.12-venv \
    sudo \
    nano \
    libpq-dev \
    gcc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create symbolic link for python command
RUN ln -s /usr/bin/python3.12 /usr/bin/python

# Set Working Directory
WORKDIR /app

# Copy Requirements File
COPY app/requirements.txt /app/requirements.txt

# Install Python Dependencies
RUN pip3 install --no-cache-dir -r requirements.txt --break-system-packages

# Copy Application Code
COPY app /app

# Expose Django Development Server Port
EXPOSE 8000

# Default Command
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
