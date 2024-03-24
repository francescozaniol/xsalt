# petite-vue - Components

Xsalt natively integrates the definition of petite-vue's components. Simply add `petite-vue="true"` to the `script` tag.

As an example, take a look at [todo-app](./components/todo-app.html):

```html
<xsl:template match="todo-app" mode="x-component">

  <template>
    <div>

      <form v-on..submit.prevent="addTodo">
        <input type="text" ref="text" />
        <button type="submit">Add todo</button>
      </form>

      <div>
        <todo-item v-for="(todo, i) in todos" v-on..removed="removeTodo(i)">{{ todo }}</todo-item>
      </div>

    </div>
  </template>

  <script petite-vue="true">
    return {
      todos: ['Buy milk', 'Buy bread'],
      addTodo() {
        this.todos.push(this.$refs.text.value);
      },
      removeTodo(index) {
        this.todos.splice(index, 1);
      },
    }
  </script>

</xsl:template>
```

By adding `petite-vue="true"`, the `script` tag now encapsulates the function which defines the "reusable scope logic" of a petite-vue component.

For completion, take a look at [todo-item](./components/todo-item.html):

```html
<xsl:template match="todo-item" mode="x-component">

  <template>
    <div ref="todo">
      <x-slot />
      <button v-on..click="remove" type="button">Remove</button>
    </div>
  </template>

  <script petite-vue="true">
    return {
      remove() {
        this.$refs.todo.dispatchEvent(new CustomEvent('removed'));
      },
    }
  </script>

</xsl:template>
```

## Demo

See [live XSLT demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/petite-vue-components/index.xhtml) or [static build demo](https://raw.githack.com/francescozaniol/xsalt/master/examples/petite-vue-components/build.html).

## Read next

[Xsalt.php](../../tools/php)