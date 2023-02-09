# SFC - Single-File Components

xsalt is heavily inspired by Vue, and it has a similar usage of the `template`, `style` and `script` tags. Have a look at [counter-button](./components/counter-button.html):

- The `template` block defines how the components' match tag should be expanded.
- The `script` block is injected at the end of the `body` tag.
- The `style` block is injected at the end of the `head` tag.
- The `insertAdjacentHTML` can be used to inject tags (usually dependencies) into the `head` or `body`. In this example the `reset.min.css` and `jquery` dependencies are injected. Note that `tagName` can receive `head` or `body`; `position`, for now, supports only `beforeend`.

See [live build here](https://htmlpreview.github.io/?https://github.com/francescozaniol/xsalt/blob/master/examples/sfc/build.html)

Few other important notes:
- See how `style` and `script` are wrapped by the ugly `/*<![CDATA[*/ ... /*]]>*/`? This is needed to escape special XML characters: without CDATA the inclusion of, for example, this code: `if(condition1 && condition2) {...}` would break the parser because `&` is a special charater in XML.
- The `style`, `script` and `insertAdjacentHTML` blocks are injected only once in the page. This means that if multiple `counter-button` tags are used, these blocks are not repeated.
- The `script` block is wrapped by an IIFE function to ensure scope isolation from the global context. If you want to avoid this, use `<script scoped="false">`.
- It is good practice to use a `-` for the `match` tag (because all native HTML tags do not contain it). Note also that anything starting with `x-` is likely to be a reserved name for xsalt, therefore avoid the usage of any `x-` for your tags.