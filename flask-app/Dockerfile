# Use an official Python runtime as a parent image
FROM python:3.8

# Set a directory for the app
WORKDIR /usr/src/app

# Install system-level dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    default-libmysqlclient-dev

# Copy all the files to the container
COPY . .

# Install dependencies
RUN pip --default-timeout=100 install --no-cache-dir -r requirements.txt

# Tell the port number the container should expose
EXPOSE 5000

# Run the command
CMD ["python", "./app.py"]
