# xsalt
Kinda like Vue, but written in XSLT

## About
With Xsalt, you can define Vue-like components to transform XML/XHTML/RSS into HTML.

Xsalt doesn't require complex tooling like Webpack or Vite; a simple PHP script is sufficient for rendering/building web pages. XSLT is also natively understood by browsers, allowing components to be transformed on the fly without the need for build tools.

I use Xsalt for creating static minisites.

## Example
index.xhtml:
```html
<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="./includes.xsl" ?>
<html>
  <head />
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
    <h1 class="title">Hello world</h1>
  </template>

  <style>
    .title {
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
    <style>.title { color: blue; }</style>
  </head>
  <body>
    <h1 class="title">Hello world</h1>
  </body>
</html>
```

See [live XSLT demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/basic/index.xhtml) or [static build demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/basic/build.html)

## Features & Docs
- [The basics](./examples/basic): The example you've just read, explained.
- [Single-File Components](./examples/sfc): Inspired by Vue's `template`, `script` and `style` tags.
- [Slots](./examples/slots): Default and named slots.
- [Auto BEM](./examples/autobem): BEM-like classes automatically added by xsalt.
- [Auto select](./examples/autoselect): Easy JS nodes auto-selection.
- [X-store](./examples/x-store): Global data store.
- [Custom elements](./examples/custom-elements): Live custom elements from Xsalt components.
- [petite-vue integration](./examples/petite-vue): Use petite-vue in Xsalt components.
- [Xsalt.php](./tools/php): A simple PHP class to render or build a page.

## Installation
```
git submodule add https://github.com/francescozaniol/xsalt
```
To update to latest version:
```
git submodule update --remote --reference https://github.com/francescozaniol/xsalt
```
Or simply download `/src/xsalt.xsl`
