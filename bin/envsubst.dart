#!/usr/bin/env dart
// Copyright (c) 2016, Kwang Yul Seo. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:envsubst/envsubst.dart';

main() {
  stdin
      .transform(new Utf8Decoder())
      .transform(new EnvSubst())
      .transform(new Utf8Encoder())
      .pipe(stdout);
}

