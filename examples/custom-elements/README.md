# Custom Elements

Xsalt components can be defined as [custom elements](https://developer.mozilla.org/en-US/docs/Web/API/Web_components/Using_custom_elements). Nodes will be transformed by JavaScript using the native browser XSLT engine.

For example, consider this simple [todo-app](./components/todo-app.html):
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

Note how, when adding a new todo, a `<todo-item>` is injected directly as a custom element (see `insertAdjacentHTML`).

Xsalt allows the definition of custom elements via `x-custom-elements`. In this example, such definition is included in [index.xhtml](./index.xhtml):
```html
<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="./includes.xsl" ?>
<html>
<head />
<body>
  <todo-app />

  <x-custom-elements xslt-import-url="./includes.xsl">
    <todo-item />
  </x-custom-elements>
</body>
</html>
```

The `x-custom-elements` tag should contain a list of self-closing tags. Note: these tags will not be included in the output transformation, their porpuse is declarative only.

Additionally, the `x-custom-elements` tag must define the `xslt-import-url` attribute. Such URL, will be used to fetch the XSLT includes. Important note: this URL is relative to the document's URL, it is not a path relative to the current file.

## Demo

See [live XSLT demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/custom-elements/index.xhtml) or [static build demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/custom-elements/build.html).

## Read next

[petite-vue integration](../petite-vue)