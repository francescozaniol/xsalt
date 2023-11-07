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

It imports transformations via `includes.xsl`.

---

[includes.xsl](./includes.xsl) imports the framework itself and a component, `hello-world`:
```xml
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:include href="./../../src/xsalt.xsl"/>
  <xsl:include href="./components/hello-world.html"/>

</xsl:transform>
```

---

[hello-world.html](./components/hello-world.html) defines a Xsalt component:
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

Note how the file has the `.html` extension. This is for syntax highlighting purposes. As you can see from line 1, the file is actually an XSL transformation. The `xsl:transform` tag, although verbose, is necessary.

As for line 2:
- The `xsl:template` tag wraps the definition of the component.
- The `match` attribute specifies the tag of the component.
- The `mode="x-component"` attribute is required by Xsalt.

## Demo

See [live XSLT demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/basic/index.xhtml) or [static build demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/basic/build.html).

## Read next

[Single-File Components](../sfc): Usage of `template`, `script` and `style`.