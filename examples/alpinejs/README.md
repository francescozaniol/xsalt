# AlpineJS integration

"[Alpine](https://alpinejs.dev/) is a rugged, minimal tool for composing behavior directly in your markup."

The usage of Alpine in xsalt components has some caveats:
- AlpineJS uses the `:` symbol (for example `x-on:click`). Such symbol is reserved in the XML markup, therefore xsalt offers a workaround: the usage of `..` instead of `:` (think of it as `:` but tilted 90 degrees).
- AlpineJS also uses `@`, but this character is completely illegal in XML and cannot be used.
- The usage of `{` and `}` inside attributes is reserved to XSLT, therefore escaping them with double braces (`{{` and `}}`) is needed.

For example, have a look at [toggle-button](./components/toggle-button.html):
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

Finally note the usage of double braches inside `x-data`.

## Demo

See [live XSLT demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/alpinejs/index.xhtml) or [static build demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/alpinejs/build.html).

## Read next

[Xsalt.php](../../tools/php)