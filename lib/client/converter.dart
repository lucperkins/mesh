import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:exportable/exportable.dart';

class Converter<T> {
  Future<T> convert(Future<String> res, {String field}) {
    var _c = new Completer();
    res.then((String value) {
      Map json = JSON.decode(value);
      Map finalJson = field == null ? json : json[field];
      T t = new Exportable(T, finalJson);
      _c.complete(t);
    });
    return _c.future;
  }

  Future<List<T>> convertList(Future<String> res, {String field}) {
    var _c = new Completer();
    res.then((String value) {
      Map json = JSON.decode(value);
      List<Map> jsonList = field == null ? json : json[field];
      List<T> _builder = new List<T>();
      jsonList.forEach((Map m) {
        T t = new Exportable(T, m);
        _builder.add(t);
      });
      _c.complete(_builder);
    });
    return _c.future;
  }
}