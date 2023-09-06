# Auto select

If `autoselect="true"` is assigned to the `script` tag, xsalt automatically selects any node which class starts with `$`.

For example, have a look at [counter-button.html](./components/counter-button.html):
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

`counterButton` is now available under `$refs`.

## Demo

See [live XSLT demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/autoselect/index.xhtml) or [static build demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/autoselect/build.html).

## Custom wrapper

`autoselect` may accept an additional parameter as the wrapper of the selected nodes. For example:
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

`$refs.counterButton` is wrapped by `window.jQuery`.

## Read next

[X-store](../x-store)