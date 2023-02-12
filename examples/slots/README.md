# Slots

See [content-article](./components/content-article.html), and [index.xhtml](./index.xhtml) for slots' usage.

See [live example](https://raw.githack.com/francescozaniol/xsalt/master/examples/slots/index.xhtml) or [build example](https://raw.githack.com/francescozaniol/xsalt/master/examples/slots/build.html).

- `<x-slot />` defines the default slot.
- `<x-slot name="heading">` is a named slot. As you can see the slotted content is injected where the `<x-slot-content />` is, so that it can be wrapped by some other tags (in this case an h1). Named slots are populated by the usage of `<template x-slot="name-of-the-slot">`.