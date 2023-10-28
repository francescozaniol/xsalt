# petite-vue integration

"[petite-vue](https://github.com/vuejs/petite-vue) is an alternative distribution of Vue optimized for progressive enhancement."

The usage of petite-vue in xsalt components has some caveats:

- petite-vue uses the `:` symbol (for example `v-on:click`). Such symbol is a reserved character in XML identifiers therefore xsalt offers a workaround: the usage of `..` instead of `:` (think of it as `:` but tilted 90 degrees). For example, use `v-on..click` instead of `v-on:click`.
- petite-vue uses few shorthands that are not compatible with the XML standard (QName invalid), therefore these cannot be used. Such shorthands are:
  - `@` is the shorthand for dispatched DOM events. In this case use `v-on..click` instead of `@click`.
  - An attribute starting with `:` is the shorthand for `v-bind:` and cannot be used. In this case use `v-bind..key` instead of `:key`..
- Finally, the usage of `{` and `}` inside attributes is reserved in XSLT, therefore these should be escaped with double braces (`{{` and `}}`).

As an example, have a look at [toggle-button](./components/toggle-button.html):

```html
<xsl:template match="toggle-button" mode="x-component">

  <template autobem="true">
    <button type="button"
      v-on..click="pressed = !pressed"
      v-bind..aria-pressed="Boolean(pressed)"
      v-scope="{{ pressed: false }}"
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

Note the usage of `v-on..` and `v-bind..`. Such attributes will be transformed by xsalt into `v-on:` and `v-bind:`. Note also that it is mandatory the usage of `v-on..click` instead of `@click`.

Finally note the usage of double braces inside `v-scope`.

## Demo

See [live XSLT demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/petite-vue/index.xhtml) or [static build demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/petite-vue/build.html).

## Read next

[Xsalt.php](../../tools/php)