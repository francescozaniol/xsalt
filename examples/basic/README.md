# The basics

[index.xhtml](./index.xhtml) is the XML file that will be transformed. It includes transformations via [includes.xsl](./includes.xsl), which includes the framework itself [xsalt.xsl](./../../src/xsalt.xsl), and a component [hello-world](./components/hello-world.html).

[hello-world](./components/hello-world.html) defines a xsalt component. Note how the file has the `html` extension? This is only for syntax highlight reasons. The file is actually a XSL transformation, as you can read from line 1; such `xsl:transform` tag, although a bit verbose, is necessary.

As for line 2 of [hello-world](./components/hello-world.html):
- The `xsl:template` tag wraps the definition of the component.
- The `match` attribute defines the tag of the component.
- The `mode="x-component"` attribute is needed by xsalt.

See [live example](https://raw.githack.com/francescozaniol/xsalt/master/examples/basic/index.xhtml) or [build example](https://raw.githack.com/francescozaniol/xsalt/master/examples/basic/build.html)
