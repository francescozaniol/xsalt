# AlpineJS integration

"[Alpine](https://alpinejs.dev/) is a rugged, minimal tool for composing behavior directly in your markup."

The usage of Alpine in xsalt components has some caveats:

- AlpineJS uses the `:` symbol (for example `x-on:click`). Such symbol is a reserved character in XML identifiers therefore xsalt offers a workaround: the usage of `..` instead of `:` (think of it as `:` but tilted 90 degrees). For example, use `x-on..click` instead of `x-on:click`.
- AlpineJS uses few shorthands that are not compatible with the XML standard (QName invalid), therefore these cannot be used. Such shorthands are:
  - `@` is the shorthand for dispatched DOM events. In this case use `x-on..click` instead of `@click`.
  - An attribute starting with `:` is the shorthand for `x-bind:` and cannot be used. In this case use `x-bind..key` instead of `:key`..
- Finally, the usage of `{` and `}` inside attributes is reserved in XSLT, therefore these should be escaped with double braces (`{{` and `}}`).

As an example, have a look at [toggle-button](./components/toggle-button.html):

```html
<xsl:template match="toggle-button" mode="x-component">

  <template autobem="true">
    <button type="button"
      x-on..click="pressed = !pressed"
      x-bind..aria-pressed="Boolean(pressed)"
      x-data="{{ pressed: false }}"
    >
      <x-slot />
    </button>
  </template>

  <style autobem="true">
    .\$\[aria-pressed=true] {
      outline: 3px solid red;
    }
  </style>

</xsl:template>
```

Note the usage of `x-on..` and `x-bind..`. Such attributes will be transformed by xsalt into `x-on:` and `x-bind:`. Note also that it is mandatory the usage of `x-on..click` instead of `@click`.

Finally note the usage of double braces inside `x-data`.

## Demo

See [live XSLT demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/alpinejs/index.xhtml) or [static build demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/alpinejs/build.html).

## Read next

[Xsalt.php](../../tools/php)