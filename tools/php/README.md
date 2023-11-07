# Xsalt.php
This is a simple utility class for use with Xsalt. Here's an example of its usage in PHP:

```php
Xsalt::render('./index.xhtml'); // renders to standard output; useful in development or if your server runs PHP
Xsalt::build('./index.xhtml', './index.html') // builds to static code and writes to ./index.html; useful for serving static pages
```

You can find an [example of its usage in this codebase](../../examples/build-examples.php)

## Debugging
To enable debugging, append `?xsalt_debug=true` to the URL. This feature makes it easier to identify errors in your XSLT code.

## Did you know
XSLT is natively supported by browsers. This means that the browser can transform Xsalt components on the fly without the need for additional tools like this one. However, XSLT is not understood by SEO crawlers, making it an impractical choice for most projects.
