# x-store

Xsalt provides a global data store which can be accessed by any component. The store can be populated in few ways:

## Inline x-store data

Data can be included inside the `x-store` tag:

```html
<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="./includes.xsl" ?>
<html>
  <head />
  <body>

    <blog-articles />

    <x-store>
      <articles>
        <article>
          <heading>Article 1</heading>
          <content><strong>Lorem ipsum dolor</strong> sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</content>
        </article>
        <article>
          <heading>Article 2</heading>
          <content>Ut enim ad minim veniam, <strong>quis nostrud exercitation</strong> ullamco laboris nisi ut aliquip ex ea commodo consequat.</content>
        </article>
        <article>
          <heading>Article 3</heading>
          <content>Duis aute irure dolor <strong>in reprehenderit</strong> in voluptate velit esse cillum dolore eu fugiat nulla pariatur.</content>
        </article>
      </articles>
    </x-store>

  </body>
</html>
```

It is important to note that the `<x-store>` tag and its content will be removed from the output transformation.

---

This is how the component [blog-articles.html](./components/blog-articles.html) can access the store via the global var `$x-store`:

```html
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match="blog-articles" mode="x-component">

  <template>
    <div>
      <xsl:for-each select="$x-store/articles/article">
        <blog-article>
          <template x-slot="heading"><xsl:value-of select="./heading" /></template>
          <xsl:copy-of select="./content" />
        </blog-article>
      </xsl:for-each>
    </div>
  </template>

</xsl:template>
</xsl:transform>
```

## Demo

See [live XSLT demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/x-store/inline/index.xhtml) or [static build demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/x-store/inline/build.html).

## Included XSLT x-store

Data can be inlined inside an imported [x-store](./xslt/store.xsl):

```xml
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match="x-store" mode="x-store">
  <articles>
    <article>
      <heading>Article 1</heading>
      <content><strong>Lorem ipsum dolor</strong> sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</content>
    </article>
    <article>
      <heading>Article 2</heading>
      <content>Ut enim ad minim veniam, <strong>quis nostrud exercitation</strong> ullamco laboris nisi ut aliquip ex ea commodo consequat.</content>
    </article>
    <article>
      <heading>Article 3</heading>
      <content>Duis aute irure dolor <strong>in reprehenderit</strong> in voluptate velit esse cillum dolore eu fugiat nulla pariatur.</content>
    </article>
  </articles>
</xsl:template>
</xsl:transform>
```

Note on line 2: `match="x-store" mode="x-store"` is mandatory.

---

The store is included in [includes.xsl](./xslt/includes.xsl):
```xml
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:include href="./../../../src/xsalt.xsl"/>
  <xsl:include href="./store.xsl"/>
  <xsl:include href="./../components/blog-article.html"/>
  <xsl:include href="./../components/blog-articles.html"/>

</xsl:transform>
```
---

Note that [index.xhtml](./xslt/index.xhtml) must include an empty `x-store` tag:
```html
<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="./includes.xsl" ?>
<html>
  <head />
  <body>
    <blog-articles />
    <x-store />
  </body>
</html>
```

## Demo

See [live XSLT demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/x-store/xslt/index.xhtml) or [static build demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/x-store/xslt/build.html).

## Local XML data

Data can be imported from a local XML file in [x-store](./local/store.xsl):

```xml
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match="x-store" mode="x-store">
  <xsl:copy-of select="document('./articles.xml')" />
</xsl:template>
</xsl:transform>
```

As in the previous example, [index.xhtml](./local/index.xhtml) must include an empty `x-store` tag.

## Demo

See [live XSLT demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/x-store/local/index.xhtml) or [static build demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/x-store/local/build.html).

## Remote XML x-store

Data can be imported from a remote source in [x-store](./remote/store.xsl):

```xml
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match="x-store" mode="x-store">
  <xsl:copy-of select="document('https://raw.githack.com/francescozaniol/xsalt/master/examples/x-store/remote/articles.xml')" />
</xsl:template>
</xsl:transform>
```

Note: some sources might not be imported due to CORS.

As in the previous example, [index.xhtml](./remote/index.xhtml) must include an empty `x-store` tag.

## Demo

See [live XSLT demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/x-store/remote/index.xhtml).

## X-store in JS

The data in the store can also be accessed from Javascript by adding the attribute `x-store-js="true"` to the node that you want to expose:

```xml
<x-store>
  <articles x-store-js="true">
    <article>...</article>
    <article>...</article>
    <article>...</article>
  </articles>
</x-store>
```

Now `articles` is available as XML nodes from the global var `window.xsalt.xStore`:

```js
window.xsalt.xStore.querySelectorAll('articles > article').forEach( article => {
  console.log(article);
});
```

See [index.xhtml](./js/index.xhtml) as an example.

## Demo

See [live XSLT demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/x-store/js/index.xhtml) or [static build demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/x-store/js/build.html).

## Read next

[Custom elements](../custom-elements)