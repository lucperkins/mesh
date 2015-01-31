Mesh
====

Mesh is a helper library for interacting with web service APIs. It provides a
powerful set of abstractions to make this process much more seamless than it
otherwise would be using the basic `HttpClient` library in `dart:io`.

## Creating a New Client

All clients are derived from the abstract `ApiClient`. To create a new client, you need to extends that class and provide the following information:

* The target host
* The version of the API being targeted (optional)
* Your client's username
* Your client's password (optional)

Here's an example:

```dart
class FooClient extends ApiClient {
  String host = 'api.foo.com';
  int apiVersion = 2;
  String username = 'user';
  String password = 'rosebud';
}
```

With this information in hand, all necessary authorization headers will be constructed and attached to each request. Currently, the following methods available on the client:

* `getRequest(String path, {String id, Map headers})`
* `postRequest(String path, {Map body, Map headers})`
* `putRequest(String path, {Map body, Map headers})`
* `deleteRequest(String path, String id, {Map body, Map headers})`

Each call returns a `Future<String>`.

## Examples

Let's say that you want to fetch the resource at the following address:

```bash
https://api.foo.com/v2/people/1234
```

Your API key for this API is `1a2b3c4d5e6f7g` and no password is required. The client can be constructed like this:

```dart
class FooClient extends ApiClient {
  String host = 'api.foo.com';
  int apiVersion = 2;
  String username = '1a2b3c4d5e6f7g';
}
```

Now, we can make a `GET` request for our resource like this:

```dart
var fooClient = new FooClient();
fooClient.getRequest('people', id: '1234').then((String response) {
  ... do something with response ...
});
```

Or, we can `POST` the JSON object `{"foo":"bar"}` to the `people` endpoint:

```dart
var json = { 'foo' : 'bar' };
fooClient.postRequest('people', body: json).then((String response) {
  ... do something with response ...
});
```
