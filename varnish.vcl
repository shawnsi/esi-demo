#
# This is an example VCL file for Varnish.
#
# It does not do anything by default, delegating control to the
# builtin VCL. The builtin VCL is called when there is no explicit
# return statement.
#
# See the VCL chapters in the Users Guide at https://www.varnish-cache.org/docs/
# and http://varnish-cache.org/trac/wiki/VCLExamples for more examples.

# Marker to tell the VCL compiler that this VCL has been adapted to the
# new 4.0 format.
vcl 4.0;

# Default backend definition. Set this to point to your content server.
backend default {
    .host = "127.0.0.1";
    .port = "5000";
}

sub vcl_backend_response {
    if (bereq.url == "/") {
       set beresp.do_esi = true; /* Do ESI processing               */
       set beresp.ttl = 24 h;    /* Sets the TTL on the HTML above  */
    } elseif ( bereq.url ~ "^/esi/.*" ) {
       set beresp.ttl = 1m;      /* Sets a one minute TTL on        */
                                 /*  the included object            */
    }
}

sub vcl_hash {
    hash_data(req.url);
    hash_data(req.http.host);

    if (req.http.cookie ~ "username=[^;]+") {
        set req.http.X-Varnish-Logged-In = true;
    }

    if (req.url ~ ".*\?.*cache=user.*" && req.http.X-Varnish-Logged-In) {
        set req.http.X-Varnish-Hashed-On = req.http.cookie;
    }

    if (req.url ~ ".*\?.*cache=login.*" && req.http.X-Varnish-Logged-In) {
        set req.http.X-Varnish-Hashed-On = "logged-in";
    }

    if (req.url ~ "^/esi/.*") {
        hash_data(req.http.X-Varnish-Hashed-On);
    }

    return(lookup);
}

sub vcl_recv {
    if( req.http.Cookie ~ "username" ) {
        return(hash);
    }
}
