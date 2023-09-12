# Custom Elements

Xsalt components can be defined as [custom elements](https://developer.mozilla.org/en-US/docs/Web/API/Web_components/Using_custom_elements). Nodes will be transformed by Javascript using the native browser XSLT engine.

For example, have a look at this simple [todo-app](./components/todo-app.html):
```html
<xsl:template match="todo-app" mode="x-component">

  <template>
    <div>

      <form class="$form">
        <input type="text" class="$text" />
        <button type="submit">Add todo</button>
      </form>

      <div class="$todos">
        <todo-item>Buy milk</todo-item>
        <todo-item>Buy bread</todo-item>
      </div>

    </div>
  </template>

  <custom-elements xslt-import-url="./includes.xsl">
    <todo-item />
  </custom-elements>

  <script autoselect="true">/*<![CDATA[*/
    $refs.form.addEventListener('submit', function (e) {
      e.preventDefault();
      $refs.todos.insertAdjacentHTML('beforeend',
        '<todo-item>' + $refs.text.value + '</todo-item>'
      );
    });
  /*]]>*/</script>

</xsl:template>
```

The `custom-elements` tag should contain a list of self-closing tags which will be defined as custom elements.

`custom-elements` must also define the `xslt-import-url` attribute, which will be used by Javascript to import the transformations. Important: such url is relative to the document's url, it is NOT a path relative to the current file.

Note how, on adding a new todo (see `script`), a `<todo-item>` is injected directly in the dom. That's because it's defined as a custom element.

## Demo

See [live XSLT demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/custom-elements/index.xhtml) or [static build demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/custom-elements/build.html).

## Read next

[AlpineJS integration](../alpinejs)