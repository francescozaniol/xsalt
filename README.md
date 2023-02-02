# xsalt
Kinda like Vue, but written in XSLT

## Tell me more
With xsalt you can define Vue-like "HTML components", which are used to transform XML tags.

xsalt does not need complex tooling such as webpack or vite, a simple PHP script is sufficient to render/compile to static HTML/CSS/JS code.

I use xsalt for static minisites.

## Example
index.xhtml:
```html
<?xml version='1.0'?>
<?xml-stylesheet type="text/xsl" href="./includes.xsl" ?>
<html>
  <head></head>
  <body>
    <hello-world />
  </body>
</html>
```

includes.xsl:
```xml
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:include href="./../../src/xsalt.xsl"/>
  <xsl:include href="./components/hello-world.html"/>

</xsl:transform>
```

hello-world.html:
```html
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match="hello-world" mode="x-component">

  <template>
    <h1>Hello world</h1>
  </template>

  <style>
    h1 {
      color: blue;
    }
  </style>

</xsl:template>
</xsl:transform>
```

result:
```html
<!DOCTYPE html>
<html>
  <head>
    <style>h1 { color: blue; }</style>
  </head>
  <body>
    <h1>Hello world</h1>
  </body>
</html>
```

## Installation
```
git submodule add https://github.com/francescozaniol/xsalt
```
To update to latest version:
```
git submodule update --remote --reference https://github.com/francescozaniol/xsalt
```
Or simply download `/src/xsalt.xsl`
