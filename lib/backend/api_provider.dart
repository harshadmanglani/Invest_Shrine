import 'package:http/http.dart';

class ApiProvider {
  String baseUrl = "http://investshrine-test1.azurewebsites.net/graphql/";

  Future<dynamic> interactWithApi(String payload) async {
    Response response = await post(baseUrl, body: {"query": payload});
    // print(response.body);
    return response.body;
  }
}
