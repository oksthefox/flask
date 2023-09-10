from flask import Flask, render_template, redirect, url_for, request
from flask import Flask, render_template, send_from_directory, request, Response
import mysql.connector
import os
import random
import time
import requests
import socket
from flask import Flask, render_template, send_from_directory
from prometheus_client import Counter, generate_latest, CONTENT_TYPE_LATEST
from flask import Flask, render_template, redirect, url_for, request, send_from_directory, Response


app = Flask(__name__, template_folder='Web', static_folder='Static')

CV_downloads = Counter('CV_downloads', 'Number of times CV has been downloaded')

def establish_db_connection():
    while True:
        try:
            db = mysql.connector.connect(
                host="db",
                user="root",
                password="password",
                database="flask_db"
            )
            return db
        except mysql.connector.Error as err:
            print("Failed connecting to database. Retrying...")
            time.sleep(1)

# Establish connection to database
db = establish_db_connection()




@app.route("/", methods=["GET", "POST"])
def test():
    if request.method == "POST":
        if 'formDownload' in request.form:
            CV_downloads.inc()
            return send_from_directory('Static/images', 'Resume.pdf', as_attachment=True)
    return render_template("test.html")


@app.route("/gifs")
def displaygifs():
    global db  # ensure you're modifying the global db
    for _ in range(3):  # Try 3 times
        try:
            if db.is_connected() == False: # check if connection is still open
                db = establish_db_connection()
            cursor = db.cursor()
            cursor.execute("SELECT url FROM images;")
            images = [row[0] for row in cursor.fetchall()]
            url = random.choice(images)
            return render_template("index.html", url=url)
        except mysql.connector.Error as err:
            # Handle the error and attempt to reconnect
            print("Error accessing the database. Reconnecting...")
            db = establish_db_connection()
            continue
    return "Error accessing the database. Please try again later."


@app.route("/metrics")
def metrics():
    return Response(generate_latest(), mimetype=CONTENT_TYPE_LATEST)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.environ.get("PORT", 5000)))
