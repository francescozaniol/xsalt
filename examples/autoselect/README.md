# Auto select

When `autoselect="true"` is assigned to the `script` tag, Xsalt automatically selects any node whose class starts with `$`.

For example, consider [counter-button.html](./components/counter-button.html):
```html
<xsl:template match="counter-button" mode="x-component">

  <template>
    <button class="$counterButton" type="button">0</button>
  </template>

  <script autoselect="true">
    $refs.counterButton.addEventListener('click', function () {
      this.innerHTML = Number.parseInt(this.innerHTML) + 1;
    });
  </script>

</xsl:template>
```

Now, `counterButton` is available under `$refs`.

## Demo

See [live XSLT demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/autoselect/index.xhtml) or [static build demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/autoselect/build.html).

## Custom wrapper

The `autoselect` attribute may accept an additional parameter as the wrapper for the selected nodes. For example:
```html
<xsl:template match="counter-button" mode="x-component">

  <template>
    <button class="$counterButton" type="button">0</button>
  </template>

  <script autoselect="true|window.jQuery">
    $refs.counterButton.on('click', function () {
      this.innerHTML = Number.parseInt(this.innerHTML) + 1;
    });
  </script>

</xsl:template>
```

Here, `$refs.counterButton` is wrapped by `window.jQuery`.

## Read next

[X-store](../x-store)