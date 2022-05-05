import 'package:http/http.dart' as http;

var auth_uri = 'https://jsonplaceholder.typicode.com/albums/1';

Future<http.Response> fetchData() {
  return http.get(Uri.parse(auth_uri));
}