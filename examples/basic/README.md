# The basics

In this example [index.xhtml](./index.xhtml) is the root XML file that will be transformed to HTML code:
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

It imports transformations via includes.xsl.

---

[includes.xsl](./includes.xsl) imports the framework itself and a component hello-world:
```xml
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:include href="./../../src/xsalt.xsl"/>
  <xsl:include href="./components/hello-world.html"/>

</xsl:transform>
```

---

[hello-world.html](./components/hello-world.html) defines a xsalt component:
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

Note how the file has the `html` extension? This is only for syntax highlight reasons. As you can read from line 1 the file is actually a XSL transformation. Such `xsl:transform` tag, although a bit verbose, is necessary.

As for line 2:
- The `xsl:template` tag wraps the definition of the component.
- The `match` attribute defines the tag of the component.
- The `mode="x-component"` attribute is needed by xsalt.

## Demo

See [live XSLT demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/basic/index.xhtml) or [static build demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/basic/build.html).

## Read next

[Single-File Components](../sfc): `template`, `script` and `style` usage.