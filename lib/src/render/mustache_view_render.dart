library shelf_mvc.mustache_render;

import "view_render.dart";
import 'package:mustache/mustache.dart';

class MustacheRender extends ViewRender {
  String delimiters = '{{ }}';

  String render_view(String template, model) {
    var t = new Template(_reviewTemplate(template), delimiters: delimiters);

    var output = t.renderString(model);
    // var output = render(_reviewTemplate(template), model, delimiter: delimiter);
    return _transform(output);
  }

  String _reviewTemplate(String result) {
    // result = result.replaceAll("${delimiter.opening}&amp;", "${delimiter.opening}&");
    return result;
  }

  String _transform(String result) {
    result = result.replaceAll("src=\"", "src=\"/");
    result = result.replaceAll("src=\"/http:/", "src=\"http:/");
    result = result.replaceAll("src=\"/../", "src=\"../");
    result = result.replaceAll("src='", "src='/");
    result = result.replaceAll("src='/http:/", "src='http:/");
    result = result.replaceAll("src='/../", "src='../");
    result = result.replaceAll("src='//", "src='/");
    result = result.replaceAll("src=\"//", "src=\"/");
    return result;
  }
}
