import 'package:http/http.dart' as http;
import 'dart:convert'; // for working with JSON data

class NetworkHelper {
  final url;

  NetworkHelper(this.url);

  Future getData() async {
    // print(url);
    http.Response r = await http.get(url);

    if (r.statusCode == 200) {
      var jsonData = jsonDecode(r.body);

      return (jsonData);
    } else {
      print(r.statusCode);
    }
  }
}
