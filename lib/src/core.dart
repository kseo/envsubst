// Copyright (c) 2016, Kwang Yul Seo. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import './parser.dart';

String envSubst(String input) {
  final p = new EnvSubstParser();
  final nodes = p.parse(input);
  final sb = new StringBuffer();
  for (final node in nodes) {
    sb.write(node.toString());
  }
  return sb.toString();
}

