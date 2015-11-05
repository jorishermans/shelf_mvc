// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

// TODO: Put public facing types in this file.

library shelf_mvc.monoroute;

import 'model.dart';
import 'request_data.dart';
import 'package:uri/uri.dart';

typedef String Controller(Model model, RequestData requestData);

/// MonoRoute helps to route your application
/// It keeps track of all the registered routes for your application
class MonoRoute {

  Map gets = new Map();

  void get(String path, Controller controller) {
    gets[path] = controller;
  }

  /// parse a Uri and match it to a controller function
  String parse(Uri uri, Model model) {
     String view;
     gets.forEach((key, ctrlr) {
        var parser = new UriParser(new UriTemplate(key));
        var match = parser.match(uri);

        if (match != null) {
          // execute controller based on the match!
          view = ctrlr(model, new RequestData(match.rest, match.parameters));
         }
     });
     return view;
  }
}
