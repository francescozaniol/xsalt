# Slots

In this example [blog-article.html](./components/blog-article.html) shows how default and named slots are defined:
```html
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match="blog-article" mode="x-component">

  <template>
    <article class="blog-article">

      <x-slot name="heading">
        <h1 class="blog-article__heading">
          <x-slot-content />
        </h1>
      </x-slot>

      <div class="blog-article__content">
        <x-slot />
      </div>

    </article>
  </template>

</xsl:template>
</xsl:transform>
```

- `<x-slot />` defines the default slot.
- `<x-slot name="heading">` is a named slot. As you can see the slotted content is injected where the `<x-slot-content />` is, so that it can be wrapped by some other tags (in this case an h1).

---

[index.xhtml](./index.xhtml) shows slots usage:
```html
<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="./includes.xsl" ?>
<html>
  <head />
  <body>

    <blog-article>
      <template x-slot="heading">Article heading</template>
      Article content: Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    </blog-article>

  </body>
</html>
```

- Named slots are populated by the usage of `<template x-slot="name-of-the-slot">`.

## Demo

See [live XSLT demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/slots/index.xhtml) or [static build demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/slots/build.html).

## Read next

[Auto BEM](../autobem)
