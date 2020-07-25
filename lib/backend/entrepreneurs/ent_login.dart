import 'package:MobileApp/backend/entrepreneurs/portfolio_list.dart';

import '../api_provider.dart';
import 'dart:convert';

class EntrepreneurLoginAPI {
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
      if (await EntrepreneurDataAPI().fetchInvestorData())
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

class EntrepreneurDataAPI {
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
      if (user.category == 'ENTREPRENEUR') {
        dynamic portfolioData = await EntrepreneurPortfolioListAPI()
            .getAllEntrepreneurPortfolios(searchQuery: '(user: "${user.id}")');
        user.entrepreneurModel = portfolioData[0];
        return true;
      } else
        return false;
    }
  }
}
