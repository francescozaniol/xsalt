# x-store

Xsalt provides a global data store which can be accessed by any component.

## External x-store

For static data, you can import an external store from [includes.xsl](./includes.xsl):
```xml
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:include href="./../../src/xsalt.xsl"/>
  <xsl:include href="./store/store.xml"/>
  <xsl:include href="./components/blog-article.html"/>
  <xsl:include href="./components/blog-articles.html"/>

</xsl:transform>
```

---

This is [store.xml](./store/store.xml):
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

Note that `match="x-store" mode="x-store"` is mandatory.

---

[index.xhtml](./index.xhtml) must include an empty `x-store` tag:
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

---

Finally, this is how the component [blog-articles.html](./components/blog-articles.html) can access the store via the global var `$x-store`:
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

See [live XSLT demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/x-store/index.xhtml) or [static build demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/x-store/build.html).

## Inline x-store

Dynamic data (for example fetched from a database with PHP) can be printed directly inside the `x-store` tag in index.xhtml:

For example:
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

Note that the `<x-store>` tag and its inner content will be removed from the HTML output.

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
