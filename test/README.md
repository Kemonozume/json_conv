# JSON God Tests

Command-line serialization tests can be found in `all_tests.dart`.

To test JSON God in the browser, head over to the `../web/` directory. Start a simple
HTTP server in that directory, and you can test with Dartium. The web tests run the
aforementioned serialization tests, as well as some simple tests for deserialization into
classes through reflection.

To test with Dart2JS, run `pub build --mode=debug`. In production, of course, remove the
`--mode=debug` flag. Start an HTTP server in `../build/web`, and you can run the tests in
any standard browser.

If you add any tests, make sure to included a `@MirrorsUsed` annotation, to ensure
compatibility with Dart2JS.

```dart
library my_tests;

@MirrorsUsed(targets: 'my_tests')
import 'dart:mirrors';
```

### Thank you for contributing to this library by testing it.

Feel free to report any bugs you encounter.