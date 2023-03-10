# Xsalt.php
This is a simple utility class to use with xsalt. Usage example:

```php
Xsalt::render('./index.xhtml'); // renders to standard output; useful in development or if your server runs PHP
Xsalt::build('./index.xhtml', './index.html') // builds to static code and writes to ./index.html; useful for serving static pages
```

Usage [example in this codebase here](../../examples/build-examples.php)

## Debugging
Append `?xsalt_debug=true` to the URL to enable debugging; this makes it easier to spot errors in your XSLT code.

## Did you know
Did you know that XSLT is natively supported by browsers? This means that the browser itself is able to transform xsalt components on the fly, without the need of additional tools like this one. Unfortunately XSLT is not understood by SEO crawlers therefore this might not be a viable option for most projects.
