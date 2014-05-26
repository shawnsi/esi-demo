ESI Demo
========

Varnish Edge Side Includes for Personalization

Prereqs
-------

* Python 2.7+
* [Flask](http://flask.pocoo.org/docs/installation/)
* [Names](https://pypi.python.org/pypi/names)
* [Varnish](https://www.varnish-cache.org/releases)

Quickstart
----------

Start up the web application:
```bash
$ python app.py
```

Fire up varnish:
```bash
$ varnishd -f varnish.vcl -n /tmp/varnish -a 0.0.0.0:6001 -F
```

Cache Query Parameter
---------------------

Varnish looks for an optional `cache` query parameter which can manipulate cachine behavior for ESI includes.

Option | Description
------ | -----------
user | unique cache for each user and shared cache for anonymous users
login | shared cache for logged in users and separate shared cache anonymous users
(default) | shared cache for all users
