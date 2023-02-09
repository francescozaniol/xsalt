# xsalt
Kinda like Vue, but written in XSLT

## Tell me more
With xsalt you can define Vue-like "HTML components", which are used to transform XML tags.

xsalt does not need complex tooling such as webpack or vite, a simple PHP script is sufficient to render or compile to static HTML/CSS/JS code.

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

## Features
- [The basics](./examples/basic): the example you've just read, explained.
- [Single-File Components](./examples/sfc): inspired by Vue's `template`, `script` and `style` tags.
- [Slots](./examples/slots): default and named slots.
- Auto-bem & auto-select: Easy BEM-like syntax automatically added by xsalt + Easy JS nodes' auto-selection.`Docs:TODO/Feature:Available`
- X-store: a store available globally, kinda like pinia/vuex.`Docs:TODO/Feature:Available`
- Custom-elements: dynamic JS custom elements from xsalt components.`Docs:TODO/Feature:Available`

## Status
I use xsalt for static minisites. It works fine but I'd consider it in beta.

## Installation
```
git submodule add https://github.com/francescozaniol/xsalt
```
To update to latest version:
```
git submodule update --remote --reference https://github.com/francescozaniol/xsalt
```
Or simply download `/src/xsalt.xsl`
