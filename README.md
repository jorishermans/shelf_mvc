# shelf mvc

This dart library helps you with managing model view control principle into shelf. By default the template engine is mustache.

## Usage

A simple usage example:

```dart
MonoRoute r = new MonoRoute();

r.get('/', (Model model, RequestData rqData) {
  model.addAttribute('hello', 'world');
  return 'home';
});

// stack up handlers
var handler = new Cascade()
    .add(createMVCHandler('client/build/web/',
         monoRoute))
    .handler;

// start shelf
io.serve(handler, 'localhost', 6060).then((server) {
   print('Serving at http://${server.address.host}:${server.port}');
});
```

## Contribution

If you'd like to contribute back to the core, you can [fork this repository](https://help.github.com/articles/fork-a-repo) and send us a pull request, when it is ready.

If you are new to Git or GitHub, please read [this guide](https://help.github.com/) first.

## Todo

- Isomorphic approach
- Using pub serve for the templates
- extending the examples
- usage of annotations
