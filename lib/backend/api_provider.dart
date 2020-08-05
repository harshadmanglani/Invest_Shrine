import 'package:MobileApp/models/entrepreneurs/entrepreneur_model.dart';
import 'package:MobileApp/models/investors/investor_model.dart';
import 'package:http/http.dart';

class ApiProvider {
  String baseUrl = "http://investshrinetest-1.azurewebsites.net/graphql/";
  String email;
  String id;
  String username;
  String category;
  bool isAuthenticated;
  InvestorPortfolioModel investorPortfolioModel;
  EntrepreneurPortfolioModel entrepreneurPortfolioModel;

  void logout() {
    this.email = null;
    this.investorPortfolioModel = null;
    this.entrepreneurPortfolioModel = null;
    this.id = null;
    this.username = null;
    this.category = null;
    this.isAuthenticated = null;
  }

  Future<dynamic> interactWithApi(String payload) async {
    Response response = await post(baseUrl, body: {"query": payload});
    // print(response.body);
    return response.body;
  }
}

ApiProvider user = ApiProvider();
