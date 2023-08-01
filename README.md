# xsalt
Kinda like Vue, but written in XSLT

## About
With xsalt you can define Vue-like components, which are used to transform XML into HTML.

Xsalt does not need complex tooling such as Webpack or Vite, a simple PHP script is sufficient to render/build web pages. XSLT is also natively understood by browsers, so components may be transformed on the fly without build tools.

I use xsalt for static minisites.

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
- [The basics](./examples/basic): the example you've just read, explained.
- [Single-File Components](./examples/sfc): inspired by Vue's `template`, `script` and `style` tags.
- [Slots](./examples/slots): default and named slots.
- [Auto BEM](./examples/autobem): BEM-like classes automatically added by xsalt.
- auto-select: Easy JS nodes auto-selection.`Docs:TODO/Feature:Available`
- [X-store](./examples/x-store): global data store.
- [Xsalt.php](./tools/php): a simple PHP class to render or build a page.
- AlpineJS integration.`Docs:TODO/Feature:Available`
- XSL basics: Cool stuff you can do with XSL.`Docs:TODO`
- Custom-elements: dynamic JS custom elements from xsalt components.`Docs:TODO/Feature:Available`

## Installation
```
git submodule add https://github.com/francescozaniol/xsalt
```
To update to latest version:
```
git submodule update --remote --reference https://github.com/francescozaniol/xsalt
```
Or simply download `/src/xsalt.xsl`
