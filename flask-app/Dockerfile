FROM python:3.8

# set a directory for the app
WORKDIR /usr/src/app

# copy all the files to the container
COPY . .

# install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# tell the port number the container should expose
EXPOSE 5000

# run the command
CMD ["python", "./app.py"]

# Add tags to the image
ARG BUILD_NUMBER
ENV TAG1=${BUILD_NUMBER}
ENV TAG2=latest

# Tag the image with multiple tags during the build process
RUN docker tag oksthefox/dockerflask:${TAG2} oksthefox/dockerflask:${TAG1} \
    && docker tag oksthefox/dockerflask:${TAG1} oksthefox/dockerflask:${TAG2}
