//library convertable;

import 'dart:mirrors';
import 'dart:convert';
import 'package:exportable/exportable.dart';

abstract class Convertable<T> {
  Future<T>


  Convertable() {
    reflectClass(T).declarations.forEach((k, v) => print(const Symbol(k)));
  }
}

class Person extends Convertable<Person> {
  String __name;
  int __age;

  Person(this.__name, this.__age);
}

void main() {
  print(new Person('Luc', 32).__age);
}

