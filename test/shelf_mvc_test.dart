// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library shelf_iso.test;

import 'package:test/test.dart';

import 'package:shelf_mvc/shelf_mvc.dart';

void main() {
  group('A group of tests', () {
    MonoRoute monoRoute;

    setUp(() {
      monoRoute = new MonoRoute();
    });

    test('First Test', () {
      // expect(awesome.isAwesome, isTrue);
    });
  });
}
