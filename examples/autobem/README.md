# Auto BEM

Xsalt scopes the code for you with [BEM](https://getbem.com).

## Template autobem

If `autobem="true"` is assigned to the `template` tag, xsalt will:
1. Add the matched tag (in this example `blog-article`) to the class of the "root" wrapper.
2. Prepend the matched tag to any class starting with `__`.

For example, this is [blog-article.html](./components/blog-article.html)'s template definition:
```html
<xsl:template match="blog-article" mode="x-component">

  <template autobem="true">
    <article>
      <h1 class="__heading">Title</h1>
      Content
    </article>
  </template>

</xsl>
```

And this is the output code:
```html
<article class="blog-article">
  <h1 class="blog-article__heading">Title</h1>
  Content
</article>
```

## Style autobem

If `autobem="true"` is assigned to the `style` tag, xsalt will:
1. Replace any `{$}` with the matched tag (in this example `blog-article`).
2. Replace any `.__` with `.blog-article__`.

This is [blog-article.html](./components/blog-article.html)' style definition:
```html
<xsl:template match="blog-article" mode="x-component">

  <style autobem="true">
    .{$} {
      max-width: 20em;
      padding: 1em;
      border: 1px solid #999;
    }
    .__heading {
      margin: 0 0 1em 0;
    }
  </style>

</xsl>
```

Output code:
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
