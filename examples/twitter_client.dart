import '../lib/client/api_client.dart';
import 'dart:async';

class TwitterClient extends ApiClient {
  String host = 'api.twitter.com';
  num apiVersion = 1.1;
  String username = '<YOUR TWITTER API KEY>';
  String password = '<YOUR TWITTER API SECRET>';
}

void showTweets(String id, ApiClient client) {
  client.getRequest('tweets', id: id).then(print);
}

void main() {
  var client = new TwitterClient();
  showTweets('abcd', client);
}