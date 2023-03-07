# SFC - Single-File Components

Xsalt is heavily inspired by Vue, and it has a similar usage of the `template`, `style` and `script` tags.

Have a look at [counter-button.html](./components/counter-button.html):
```html
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match="counter-button" mode="x-component">

  <template>
    <button class="counter-button" type="button">0</button>
  </template>

  <script>/*<![CDATA[*/
    var $button = $('.counter-button');
    $button.on('click', function () {
      this.innerHTML = Number.parseInt(this.innerHTML) + 1;
    });
  /*]]>*/</script>

  <style>/*<![CDATA[*/
    .counter-button {
      font-size: 2em;
      margin: 20px;
    }
  /*]]>*/</style>

  <!-- reset.min.css -->
  <insertAdjacentHTML tagName="head" position="beforeend">
    <link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css"
      integrity="sha512-NmLkDIU1C/C88wi324HBc+S2kLhi08PN5GDeUVVVC/BVt/9Izdsc9SVeVfA1UZbY3sHUlDSyRXhCzHfr6hmPPw=="
      crossorigin="anonymous"
      referrerpolicy="no-referrer"
    />
  </insertAdjacentHTML>

  <!-- jquery -->
  <insertAdjacentHTML tagName="body" position="beforeend">
    <script
      src="https://code.jquery.com/jquery-3.6.3.slim.min.js"
      integrity="sha256-ZwqZIVdD3iXNyGHbSYdsmWP//UBokj2FHAxKuSBKDSo="
      crossorigin="anonymous"></script>
  </insertAdjacentHTML>

</xsl:template>
</xsl:transform>
```

- The `template` block defines how the component's match tag will be expanded.
- The `script` block is injected at the end of the `body` tag.
- The `style` block is injected at the end of the `head` tag.
- The `insertAdjacentHTML` can be used to inject tags (usually dependencies) into the `head` or `body`. In this example the `reset.min.css` and `jquery` dependencies are injected. Note that `tagName` can receive `head` or `body`; `position` supports only `beforeend`.

## Demo

See [live XSLT demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/sfc/index.xhtml) or [static build demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/sfc/build.html).

## Other notes

- See how `style` and `script` are wrapped by such ugly `/*<![CDATA[*/ ... /*]]>*/`? This is needed to escape special XML characters: without CDATA the inclusion of, for example, this code: `if(condition1 && condition2) {...}` would break the parser because `&` is a special charater in XML. If no special characters are used then CDATA is not necessary.
- The `style`, `script` and `insertAdjacentHTML` tags are injected only once in the page, even if multiple `counter-button` are used.
- The `script` block is wrapped by an IIFE function to ensure scope isolation from the global context. If you want to avoid this, use `<script scoped="false">`.
- It is good practice to use a `-` for the `match` tag. Note also that anything starting with `x-` is likely to be a reserved name for xsalt, therefore avoid the usage of any `x-` for your tags.

## Read next

[Slots](../slots)
