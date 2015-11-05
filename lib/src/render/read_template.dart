library shelf_mvc.read_template;

import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:logging/logging.dart';
import '../server/serving_assistent.dart';

class ReadTemplatesOnServer {
  final Logger log = new Logger('ServerViewRender');

  String views;
  ServingAssistent servingAssistent;
  Uri _viewUriResolved;

  ReadTemplatesOnServer(this.views, this.servingAssistent) {
     _viewUriResolved = Platform.script.resolve(this.views);
  }

  Future<String> readTemplate(String view) async {
    var viewUri = _viewUriResolved.resolve("$view.html");
    var file = new File(viewUri.toFilePath());
    var result = "";

    if (file.existsSync()) {
      result = await _readFile(file);
    } else {
      if (servingAssistent!=null) {
        try {
           Stream<List<int>> inputStream = await servingAssistent.read(views, "$view.html");
           result = await inputStream.transform(UTF8.decoder).first;
        } catch(e) {
          log.severe("The '$view' can't be resolved.");
        }
      } else {
        viewUri = new Uri.file(views).resolve("$view.html");
        file = new File(viewUri.toFilePath());
        if (file.existsSync()) {
          result = await _readFile(file);
        }
      }
    }

    return result;
  }

  Future<String> _readFile(File file) async {
    var data = await file.readAsBytes();
    return new String.fromCharCodes(data);
  }

}
