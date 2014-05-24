#!/usr/bin/env python

from flask import Flask, redirect, render_template, session, url_for
import names

app = Flask(__name__)
app.secret_key = 'A0Zr98j/3yX R~XHH!jmN]LWX/,?RT'

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
    session['username'] = names.get_full_name()
    return redirect(url_for('index'))


@app.route("/logout")
def logout():
    session.pop('username')
    return redirect(url_for('index'))

if __name__ == "__main__":
    app.run(host='0.0.0.0', debug=True)
