from flask import Flask, render_template, redirect, url_for, request
from flask import Flask, render_template, send_from_directory, request, Response
import mysql.connector
import os
import random
import time
from flask import Flask, render_template, send_from_directory
from prometheus_client import Counter
from prometheus_client import generate_latest, CONTENT_TYPE_LATEST


app = Flask(__name__, template_folder='Web', static_folder='Static')

CV_downloads = Counter('CV_downloads', 'Number of times CV has been downloaded')

# Configure MySQL connection
db = None
while db is None:
    try:
        db = mysql.connector.connect(
            host="db",
            user="root",
            password="password",
            database="flask_db"
        )
    except mysql.connector.Error as err:
        print("Failed connecting to database. Retrying...")
        time.sleep(1)




@app.route("/", methods=["GET", "POST"])
def test():
    if request.method == "POST":
        if 'formDownload' in request.form:
            CV_downloads.inc()
            return send_from_directory('Static/images', 'Resume.pdf', as_attachment=True)
    return render_template("test.html")


@app.route("/gifs", methods=["GET", "POST"])
def index():
    cursor = db.cursor()
    cursor.execute("SELECT url FROM images;")
    images = [row[0] for row in cursor.fetchall()]
    url = random.choice(images)
    return render_template("index.html", url=url)


@app.route("/metrics")
def metrics():
    return Response(generate_latest(), mimetype=CONTENT_TYPE_LATEST)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.environ.get("PORT", 5000)))
