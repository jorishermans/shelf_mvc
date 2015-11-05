// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library shelf_iso.example;

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_mvc/shelf_mvc.dart';

main() {

  MonoRoute monoRoute = new MonoRoute();
  int count = 0;

  monoRoute.get('/', (Model model, RequestData rqData) {
    model.addAttribute('hello', 'world');
    return 'home';
  });

  monoRoute.get('/count', (Model model, RequestData rqData) {
    count++;
    model.addAttribute('count', count);
    return 'second';
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
}
