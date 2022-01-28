import 'package:http/http.dart' as http;

void main() async {
  Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");
  final response =
      await http.get(url, headers: {"key": "834822fe68f57f82768f7f08e930a8ec"});

  print(response.body);
}
