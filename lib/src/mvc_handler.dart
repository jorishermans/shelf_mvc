library shelf_mvc.iso_handler;

import 'dart:io';

import 'package:shelf/shelf.dart';

import 'model.dart';
import "monoroute.dart";

import "server/serving_assistent.dart";
import "render/read_template.dart";
import "render/mustache_view_render.dart";
import "render/view_render.dart";
import 'package:http_server/http_server.dart' as http_server;

/// Creates a Shelf [Handler] that can handle the isomorphic pattern, run 1 request on the server
/// and the rest on the client
///
/// The path of the view templates [fileSystemPath] and the monoRoute logic so we can execute this logic.
Handler createMVCHandler(String fileSystemPath, MonoRoute route, {ViewRender mvr}) {
//  var rootDir = new Directory(fileSystemPath);
//  if (!rootDir.existsSync()) {
//    throw new ArgumentError('A directory corresponding to fileSystemPath '
//        '"$fileSystemPath" could not be found');
//  }
//
//  fileSystemPath = rootDir.resolveSymbolicLinksSync();

  // creating an assistent to serve files and listen to
  Uri clientFilesAbsoluteUri = Platform.script.resolve(fileSystemPath);
  var virDir = new http_server.VirtualDirectory(clientFilesAbsoluteUri.toFilePath());
  ServingAssistent servingAssistent = new ServingAssistent(_pubServeUrl(), virDir);

  // define a view render
  if (mvr == null) {
    mvr = new MustacheRender();
  }

  return (Request request) async {

    var uri = request.requestedUri;
    Model model = new Model();
    String view = route.parse(uri, model);

    ReadTemplatesOnServer rtos = new ReadTemplatesOnServer(fileSystemPath, servingAssistent);

    // first render view and then add it to the model
    String viewTemplate = await rtos.readTemplate(view);
    model.addAttribute("body", mvr.render_view(viewTemplate, model.getData()));
    // then render total layout!
    String template = await rtos.readTemplate("layout");
    String endResult = mvr.render_view(template, model.getData());
    // resolve and render view and layout!
    Map headers = new Map();
    headers["content-type"] = "text/html";
    return new Response.ok(endResult, headers: headers);
  };
}

Uri _pubServeUrl() {
    var env = Platform.environment;
    String pubServeUrlString = env['DART_PUB_SERVE'];

    Uri pubServeUrl = pubServeUrlString != null
                        ? Uri.parse(pubServeUrlString)
                        : null;
    return pubServeUrl;
}
