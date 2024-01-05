# petite-vue integration

"[petite-vue](https://github.com/vuejs/petite-vue) is an alternative distribution of Vue optimized for progressive enhancement."

Using petite-vue in Xsalt components comes with some caveats:

- petite-vue uses the `:` symbol (for example `v-on:click`). However, this symbol is a reserved character in XML, therefore Xsalt offers a workaround: the usage of `..` instead of `:` (think of it as `:` but tilted 90 degrees). For example, use `v-on..click` instead of `v-on:click`.
- petite-vue uses a few shorthands that are not compatible with the XML standard (QName invalid), and therefore cannot be used. These shorthands include:
  - `@` which is the shorthand for dispatched DOM events. In this case, use `v-on..click` instead of `@click`.
  - An attribute starting with `:` is the shorthand for `v-bind:` and cannot be used. In this case use `v-bind..key` instead of `:key`..
- Lastly, the usage of `{` and `}` inside attributes is reserved in XSLT, therefore these should be escaped with double braces (`{{` and `}}`).

As an example, take a look at [toggle-button](./components/toggle-button.html):

```html
<xsl:template match="toggle-button" mode="x-component">

  <template autobem="true">
    <button type="button"
      v-on..click="count++"
      v-scope="{{ count: 0 }}"
    >
      {{ count }}
    </button>
  </template>

</xsl:template>
```

Note the usage of `v-on..`. Such attribute will be transformed by xsalt into `v-on:`. Also, note that it is mandatory to use `v-on..click` instead of `@click`.

Finally, note the usage of double braces inside `v-scope`.

## Demo

See [live XSLT demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/petite-vue/index.xhtml) or [static build demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/petite-vue/build.html).

## What about AlpineJS?

AlpineJS works fine for "static" builds/renders. However, for live XSLT transformations, it can be buggy.

## Read next

[Xsalt.php](../../tools/php)