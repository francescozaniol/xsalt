# Auto BEM

## template autobem

If `autobem="true"` is assigned to the `template` tag, xsalt will:
1. Add the matched tag as the class of the "root" wrapper. This represents the "Block" in Block-Element-Modifier (in this case `blog-article`).
2. Prepend `blog-article` to any class starting with `__`.

Example:
```xml
<xsl:template match="blog-article" mode="x-component">
  <template autobem="true">
    <article>
      <h1 class="__heading">Title</h1>
      Content
    </article>
  <template>
</xsl>
```

Output:
```html
<article class="blog-article">
  <h1 class="blog-article__heading">Title</h1>
  Content
</article>
```

## style autobem

If `autobem="true"` is assigned to the `style` tag, xsalt will:
1. Replace any `{$}` with `blog-article`.
2. Replace any `.__` with `.blog-article__`.

Example:
```xml
<xsl:template match="blog-article" mode="x-component">
  <style autobem="true">
    .{$} {
      padding: 1em;
    }
    .__heading {
      font-size: 2em;
    }
  <style>
</xsl>
```

Output:
```css
.blog-article {
  padding: 1em;
}
.blog-article__heading {
  font-size: 2em;
}
```

## Complete example

See [code example](./components/blog-article.html) and [live example](https://raw.githack.com/francescozaniol/xsalt/master/examples/autobem/index.xhtml) or [build example](https://raw.githack.com/francescozaniol/xsalt/master/examples/autobem/build.html).