import 'package:MobileApp/backend/investors/portfolio_list.dart';

import '../api_provider.dart';
import 'dart:convert';

class InvestorLoginAPI {
  String loginQuery({String username, String password}) {
    return '''mutation{
      tokenAuth(username: "$username", password: "$password")
      {
        payload
      }
    }''';
  }

  Future<dynamic> loginUser({String username, String password}) async {
    String query = loginQuery(username: username, password: password);
    String responseFromApi = await user.interactWithApi(query);
    Map<dynamic, dynamic> parsedResponse = json.decode(responseFromApi);
    print(parsedResponse);
    if (parsedResponse["errors"] == null) {
      print("login succeeded");
      user.username = username;
      user.isAuthenticated = true;
      if (await InvestorDataAPI().fetchInvestorData())
        return true;
      else
        return false;
    } else {
      print("login failed");
      user.isAuthenticated = false;
      return false;
    }
  }
}

class InvestorDataAPI {
  String query = '''
  query{
    allUsers(username: "${user.username}"){
      edges{
        node{
          id
          category
          email
        }
      }
    }
  } 
  ''';
  Future<dynamic> fetchInvestorData() async {
    if (user.username == null)
      return false;
    else {
      String responseFromApi = await user.interactWithApi(query);
      Map<dynamic, dynamic> parsedResponse = json.decode(responseFromApi);
      user.id = parsedResponse["data"]["allUsers"]["edges"][0]["node"]["id"];
      user.email =
          parsedResponse["data"]["allUsers"]["edges"][0]["node"]["email"];
      user.category =
          parsedResponse["data"]["allUsers"]["edges"][0]["node"]["category"];
      if (user.category == 'INVESTOR') {
        dynamic portfolioData = await InvestorPortfolioListAPI()
            .getAllInvestorPortfolios(searchQuery: '(user: "${user.id}")');
        user.investorModel = portfolioData[0];
        return true;
      } else
        return false;
    }
  }
}
