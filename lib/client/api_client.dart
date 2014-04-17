import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'converter.dart';

class ApiClient<T> {
  // The user must provide these
  String host;
  num apiVersion;
  String username;

  // This one is optional
  String password;
  bool converter;

  // Private variables
  String _path;
  http.Client _client;
  Map _finalHeaders;

  // A variety of getters for use in API calls
  Map get _authHeader {
    return {
      'authorization':
        'Basic ${CryptoUtils.bytesToBase64(UTF8.encode('$username:$password'))}'
    };
  }
  String get _versionString => apiVersion == null ? null : 'v$apiVersion';
  String get _finalPath => _versionString == null ? _path : '$_versionString/$_path';
  Uri get _uri => new Uri.https(host, _finalPath, {});

  // The client's constructor
  ApiClient() {
    _client = new http.Client();
  }

  // GET
  Future<String> getRequest(String path, {String id, Map headers}) {
    Completer _c = new Completer();
    _path = id == null ? path : '$path/$id';
    headers = headers == null ? {} : headers;
    headers.addAll(_authHeader);
    _client.get(_uri, headers: headers).then((http.Response res) {
      _c.complete(res.body);
    });
    return _c.future;
  }

  // POST
  Future<String> postRequest(String path, {Map body, Map headers}) {
    Completer _c = new Completer();
    _path = path;
    headers = headers == null ? {} : headers;
    headers.addAll(_authHeader);
    _client.post(_uri, headers: headers, body: body).then((http.Response res) {
      _c.complete(res.body);
    });
    return _c.future;
  }

  // PUT
  Future<String> putRequest(String path, {Map body, Map headers}) {
    Completer _c = new Completer();
    _path = path;
    headers = headers == null ? {} : headers;
    headers.addAll(_authHeader);
    _client.put(_uri, headers: headers, body: body).then((http.Response res) {
      _c.complete(res.body);
    });
    return _c.future;
  }

  // DELETE
  Future<String> deleteRequest(String path, String id, {Map body, Map headers}) {
    Completer _c = new Completer();
    _path = id == null ? path : '$path/$id';
    headers = headers == null ? {} : headers;
    headers.addAll(_authHeader);
    _client.delete(_uri, headers: headers).then((http.Response res) {
      _c.complete(res.body);
    });
    return _c.future;
  }

  Future<T> getObject() {
    var _c = new Completer();
    getRequest().then((String value) {
      new Converter<T>(getRequest()).convert((http.))
      _c.complete(t);
    });
    return _c.future;
  }

  Future<List<T>> getList
}