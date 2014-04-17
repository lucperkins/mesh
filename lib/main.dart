import 'client/api_client.dart';
import 'dart:convert';
import 'package:http/testing.dart';
import 'dart:async';
import 'dart:collection';

import 'client/convertable.dart';

void main() {
  List<Map> m = [{ 'foo': 'bar' }];
  print(m is List<int>);
}