# Auto BEM

Xsalt automatically scopes your code with [BEM](https://getbem.com).

## Template autobem

When `autobem="true"` is assigned to the `template` tag, Xsalt will:
1. Add the matched tag (in this example, `blog-article`) to the class of the "root" wrapper.
2. Prepend the matched tag to any class starting with `__`.

For example, consider the template definition in [blog-article.html](./components/blog-article.html):
```html
<template autobem="true">
  <article>
    <h1 class="__heading">Title</h1>
    Content
  </article>
</template>
```

The output code will be:
```html
<article class="blog-article">
  <h1 class="blog-article__heading">Title</h1>
  Content
</article>
```

## Style autobem

When `autobem="true"` is assigned to the `style` tag, Xsalt will replace any `\$` with the matched tag (in this example, `blog-article`).

Consider the style definition in [blog-article.html](./components/blog-article.html):
```html
<style autobem="true">
  .\$ {
    max-width: 20em;
    padding: 1em;
    border: 1px solid #999;
  }
  .\$__heading {
    margin: 0 0 1em 0;
  }
</style>
```

The output code will be:
```css
.blog-article {
  max-width: 20em;
  padding: 1em;
  border: 1px solid #999;
}
.blog-article__heading {
  margin: 0 0 1em 0;
}
```

## Demo

See [live XSLT demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/autobem/index.xhtml) or [static build demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/autobem/build.html).

## Read next

[Auto select](../autoselect)