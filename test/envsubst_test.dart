// Copyright (c) 2016, Kwang Yul Seo. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:envsubst/envsubst.dart';
import 'package:test/test.dart';

void main() {
  group('envSubst', () {
    // Assume $HOME and $USER are set.
    final home = Platform.environment['HOME'];
    final user = Platform.environment['USER'];

    test('text', () {
      final input = r'My home is kseo';
      expect(envSubst(input), 'My home is kseo');
    });

    test(r'subst $HOME', () {
      final input = r'My home is $HOME';
      expect(envSubst(input), 'My home is ${home}');
    });

    test(r'subst ${HOME}', () {
      final input = r'My home is ${HOME}';
      expect(envSubst(input), 'My home is ${home}');
    });

    test(r'subst ${HOME:+/root}', () {
      var input = r'My home is ${HOME:+/root}';
      expect(envSubst(input), 'My home is /root');

      input = r'My home is ${FOOBAR:+/root}';
      expect(envSubst(input), 'My home is ');
    });

    test(r'subst ${HOME:-/root}', () {
      var input = r'My home is ${HOME:-/root}';
      expect(envSubst(input), 'My home is ${home}');

      input = r'My home is ${FOOBAR:-/root}';
      expect(envSubst(input), 'My home is /root');
    });

    test(r'subst ${HOME:+$USER}', () {
      final input = r'My home is ${HOME:+$USER}';
      expect(envSubst(input), 'My home is ${user}');
    });

    test(r'subst ${HOME:-$USER}', () {
      final input = r'My home is ${HOME:-$USER}';
      expect(envSubst(input), 'My home is ${home}');
    });

    test(r'escape with \$', () {
      final input = r'My home is \$HOME';
      expect(envSubst(input), r'My home is \$HOME');
    });

    test(r'escape with \${', () {
      final input = r'My home is \${HOME}';
      expect(envSubst(input), r'My home is \${HOME}');
    });
  });
}
