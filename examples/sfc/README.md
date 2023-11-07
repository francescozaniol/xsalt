# SFC - Single-File Components

Xsalt is heavily inspired by Vue, and employs similar usage of the `template`, `style` and `script` tags.

Consider [counter-button.html](./components/counter-button.html) as an example:
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

  <insertAdjacentHTML tagName="head" position="beforeend">
    <link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css"
      integrity="sha512-NmLkDIU1C/C88wi324HBc+S2kLhi08PN5GDeUVVVC/BVt/9Izdsc9SVeVfA1UZbY3sHUlDSyRXhCzHfr6hmPPw=="
      crossorigin="anonymous"
      referrerpolicy="no-referrer"
    />
  </insertAdjacentHTML>

  <insertAdjacentHTML tagName="body" position="beforeend">
    <script
      src="https://code.jquery.com/jquery-3.6.3.slim.min.js"
      integrity="sha256-ZwqZIVdD3iXNyGHbSYdsmWP//UBokj2FHAxKuSBKDSo="
      crossorigin="anonymous"></script>
  </insertAdjacentHTML>

</xsl:template>
</xsl:transform>
```

- The `template` block specifies how the component's match tag will expand.
- The `script` block is injected at the end of the `body` tag.
- The `style` block is injected at the end of the `head` tag.
- The `insertAdjacentHTML` allows the injection of tags, typically dependencies, into the `head` or `body`. In this example, `reset.min.css` and `jquery` dependencies are injected. Note that `tagName` can be either `head` or `body`, and `position` only supports `beforeend`.

## Demo

See [live XSLT demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/sfc/index.xhtml) or [static build demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/sfc/build.html).

## Other notes

- Notice the awkward `/*<![CDATA[*/ ... /*]]>*/` wrapping around the `style` and `script` blocks? This is essential for escaping special XML characters. Without CDATA, including code like `if(condition1 && condition2) {...}` would break the parser because `&` is a special character in XML. If no special characters are used, CDATA is not needed.
- The `style`, `script` and `insertAdjacentHTML` tags are injected only once on the page, even if multiple `counter-button` components are used.
- The `script` block is enclosed in an IIFE function to ensure scope isolation from the global context. If you wish to avoid this, use `<script scoped="false">`.
- 's a good practice to use a hyphen `-` for the `match` tag. Additionally, be aware that any tag starting with `x-` is likely to be a reserved name in Xsalt, so avoid using `x-` for your tags.

## Read next

[Slots](../slots)
