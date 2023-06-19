from flask import Flask, render_template
import os
import random

app = Flask(__name__)


bugubg
# list of cat images
images = [
    "https://media.giphy.com/media/yr7n0u3qzO9nG/giphy.gif",
    "https://media.tenor.com/rMLswxLq2uEAAAAM/funny-as.gif",
    "https://i.gifer.com/QPt.gif",
    "https://media1.giphy.com/media/mC7VjtF9sYofs9DUa5/200w.gif?cid=6c09b9521pven9h01wypu84n9jt6eg2q87g01vl3mlkikduj&ep=v1_gifs_search&rid=200w.gif&ct=g",
    "https://media0.giphy.com/media/kbuQOkATEo6VW/giphy.gif",
    "https://media.tenor.com/lSqAQeWHBQAAAAAC/sid-ice.gif",
    "https://thumbs.gfycat.com/CalculatingEcstaticDwarfrabbit-size_restricted.gif",
    "https://media1.giphy.com/media/H5C8CevNMbpBqNqFjl/giphy.gif",
    "https://media.tenor.com/-o7IJJHaE5MAAAAM/kto-kounotoritoken.gif",
]


@app.route("/")
def index():
    url = random.choice(images)
    return render_template("index.html", url=url)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.environ.get("PORT", 5000)))
