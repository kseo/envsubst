# envsubst

[![Build Status](https://travis-ci.org/kseo/envsubst.svg?branch=master)](https://travis-ci.org/kseo/envsubst)

Docker style environment variables substitution for Dart.

Environment variables are notated either with $variable_name or
${variable_name}. They are treated equivalently and the brace syntax is
typically used to address issues with variable names with no whitespace,
like ${foo}_bar.

The ${variable_name} syntax also supports a few of the standard bash
modifiers as specified below:

* ${variable:-word} indicates that if variable is set then the result will
  be that value. If variable is not set then word will be the result.
* ${variable:+word} indicates that if variable is set then word will be the
  result, otherwise the result is the empty string.

In all cases, word can be any string, including additional environment
variables.

Escaping is possible by adding a \ before the variable: \$foo or \${foo},
for example, will translate to $foo and ${foo} literals respectively.

# Examples

```dart
import 'package:envsubst/envsubst.dart';

main() {
  String input = r'Hello $HOME';
  String output = envSubst(input);
  print(output); // print 'Hello /Users/kseo'
}
```

# Other Projects

If you are a Go programmer, see [a8m/envsubst][a8m/envsubst].

[a8m/envsubst]: https://github.com/a8m/envsubst
