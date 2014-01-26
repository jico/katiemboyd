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
into `app/lib`. This includes Bootstrap, Galleria, and Stellar.js.

### HTML

All HTML is written in the [Jade](http://jade-lang.com/) templating language.
The views can be found under `app/views`. The Jade configuration and source
which compiles the main `index.html` file (as well as provides the `include`
helper method for views) is at `app/index.coffee`.

### CSS

CSS is written in LESS under `app/css`. Compilation is done via Grunt and
according to `app/css/index.less`. Additional CSS files can also be included in
the `css` key of `manifest.json`.

### JavaScript

JavaScript is concatenated and minified using uglify through Grunt. You can find
all included JS files under the `js` key of the `manifest.json`. App-specific JS
is written in CoffeeScript and organized under `app/js/_coffee`. All coffee
files under this directory is compiled and concatenated into `app/js/build.js`,
which is then included last in the manifest.

### Updating

Run `grunt` to recompile the entire site. Or, run `grunt watch` to automatically
update files as you develop.

## Deploying

As a static site, deployments are as simple as pushing the public directory up
to the server. This can be done with a quick `grunt deploy`. To update deploy
settings, see the `deploy:default` task in the Gruntfile.