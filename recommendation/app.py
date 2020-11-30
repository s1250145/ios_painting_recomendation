# -*- coding: utf-8 -*-

import json
from flask import jsonify, request, Flask

import SVDRating

app = Flask(__name__)

data = json.load(open("PaintDataSet.json", "r"))
sample_data = json.load(open("SampleAnswer.json", "r"))

            
@app.route("/", methods=['GET'])
def first_download():
    return jsonify(data)


@app.route("/order", methods=['POST'])
def decision_paint_order():
    new_order = SVDRating.main(request.json["Feel"], request.json["Like"])
    return jsonify(new_order)


@app.route("/test")
def test():
    return "Hello, Flask!"


if __name__ == "__main__":
    app.run(debug=True)