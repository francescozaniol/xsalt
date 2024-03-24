# petite-vue - Basics

"[petite-vue](https://github.com/vuejs/petite-vue) is an alternative distribution of Vue optimized for progressive enhancement."

Using petite-vue in Xsalt components comes with some caveats:

- petite-vue uses the `:` symbol (for example `v-on:click`). However, this symbol is a reserved character in XML, therefore Xsalt offers a workaround: the usage of `..` instead of `:` (think of it as `:` but tilted 90 degrees). For example, use `v-on..click` instead of `v-on:click`.
- petite-vue uses a few shorthands that are not compatible with the XML standard (QName invalid), and therefore cannot be used. These shorthands include:
  - `@` which is the shorthand for dispatched DOM events. In this case, use `v-on..click` instead of `@click`.
  - An attribute starting with `:` is the shorthand for `v-bind:` and cannot be used. In this case use `v-bind..key` instead of `:key`..
- Lastly, the usage of `{` and `}` inside attributes is reserved in XSLT, therefore these should be escaped with double braces (`{{` and `}}`).

As an example, take a look at [counter-button](./components/counter-button.html):

```html
<xsl:template match="counter-button" mode="x-component">

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

Note the usage of `v-on..`. Such attribute will be transformed by Xsalt into `v-on:`. Also, note that it is mandatory to use `v-on..click` instead of `@click`.

Finally, note the usage of double braces inside `v-scope`.

## petite-vue loading

Xsalt does not automatically load the library for you, you will need to include it manually on the page. For an example of how to load it from the CDN, take a look at [index.xhtml](./index.xhtml):

```html
<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="./includes.xsl" ?>
<html>
  <head />
  <body>
    <counter-button />
    <script src="https://unpkg.com/petite-vue" init=""></script>
  </body>
</html>
```

## Demo

See [live XSLT demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/petite-vue/index.xhtml) or [static build demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/petite-vue/build.html).

## What about AlpineJS?

AlpineJS works fine for "static" builds/renders. However, for live XSLT transformations, it can be buggy.

Also, Xsalt comes with petite-vue's components integration. 

## Read next

[petite-vue components](../petite-vue-components)