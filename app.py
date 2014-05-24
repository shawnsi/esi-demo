#!/usr/bin/env python

from flask import Flask, make_response, redirect, render_template, request, url_for
import names

app = Flask(__name__)

@app.route("/")
def index():
    return render_template('index.html')


@app.route("/esi/content")
def content():
    return render_template('content.html')


@app.route("/esi/status")
def status():
    return render_template('status.html')


@app.route("/login")
def login():
    resp = make_response(redirect(url_for('index')))
    resp.set_cookie('username', names.get_full_name())
    return resp


@app.route("/logout")
def logout():
    resp = make_response(redirect(url_for('index')))
    resp.set_cookie('username', expires=0)
    return resp

if __name__ == "__main__":
    app.run(host='0.0.0.0', debug=True)
