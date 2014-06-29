# Katie Boyd - UX/Photography Portfolio

## Development

The main development files are under the `app` directory:

```
app
├── css
├── js
├── lib
└── views
```

### Third-party libraries

Front-end dependencies are managed by [Bower](http://bower.io) and installed
into `app/lib`.

### HTML

All HTML is written in the [Jade](http://jade-lang.com/) templating language.
The views can be found under `app/views`. The Jade configuration and source
which compiles the main view files (as well as provides the `include`
helper method and yield construct) is at `app/index.coffee`.

All resulting views should be listed under the `views` variable in
`app/index.coffee`. The key of each hash entry is the resulting filename/path (i.e.
index, photography, etc.). The value is the jade filename to yield into the
layout for that view.

### CSS

CSS is written in LESS under `app/css`. Compilation is done via Grunt and
according to `app/css/index.less`. Additional CSS files can also be included in
the `css` key of `manifest.json`.

The framework is [Ribs](https://github.com/nickpack/Ribs), a Bower-available and
maintained fork of [Skeleton](http://www.getskeleton.com/).

### JavaScript

JavaScript is concatenated and minified using uglify through Grunt. You can find
all included JS files under the `js` key of the `manifest.json`. App-specific JS
is written in CoffeeScript and organized under `app/js/_coffee`. All coffee
files under this directory is compiled and concatenated into `app/js/build.js`,
which is then included last in the manifest.

### Updating

Run `grunt` to recompile the entire site. Or, run `grunt watch` to automatically
update files as you develop.
