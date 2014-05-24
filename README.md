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

```bash
$ python app.py
$ varnishd -f varnish.vcl -n /tmp/varnish -a 0.0.0.0:6001 -F
```
