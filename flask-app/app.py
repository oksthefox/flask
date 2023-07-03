from flask import Flask, render_template
import mysql.connector
import os
import random

app = Flask(__name__)

# Configure MySQL connection
db = mysql.connector.connect(
    host="db",
    user="root",
    password="password",
    database="flask_db"
)

@app.route("/")
def index():
    cursor = db.cursor()
    cursor.execute("SELECT url FROM images;")
    images = [row[0] for row in cursor.fetchall()]
    url = random.choice(images)
    return render_template("index.html", url=url)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.environ.get("PORT", 5000)))
