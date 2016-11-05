// Copyright (c) 2016, Kwang Yul Seo. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:envsubst/envsubst.dart';

void main() {
  String input = r'Hello $HOME';
  String output = envSubst(input);
  print(output); // print 'Hello /Users/kseo'
}

