import '../../models/investors/investor_model.dart';
import '../api_provider.dart';
import 'dart:convert';

class InvestorPortfolioListAPI {
  String searchInvestor({String searchQuery = ''}) {
    return '''query{
    allInvestors''' +
        searchQuery +
        '''{
      edges{
        node{
          id,
          firstName,
          linkedinProfile,
          lastName,
          background,
          location,
          numInvestments
          portfolioId
          interests{
            edges{
              node{
                industry
              }
            }
          }
          investment,
          displayImage,
          currentOccupation
        }
      }
    }
  } ''';
  }

  Future<dynamic> getAllInvestorPortfolios({String searchQuery = ''}) async {
    String query = searchInvestor(searchQuery: searchQuery);
    String responseFromApi = await user.interactWithApi(query);
    // print(responseFromApi);
    Map<dynamic, dynamic> parsedResponse = json.decode(responseFromApi);
    List<dynamic> allPortfolios =
        parsedResponse["data"]["allInvestors"]["edges"];
    List<InvestorPortfolioModel> investorPortfolioModelList = [];

    for (var i = 0; i < allPortfolios.length; i++) {
      dynamic portfolio = allPortfolios[i]["node"];
      investorPortfolioModelList.add(InvestorPortfolioModel(
        firstName: portfolio["firstName"],
        id: portfolio["id"],
        uid: portfolio["portfolioId"],
        displayImage: portfolio["displayImage"],
        location: portfolio["location"],
        numInvestments: portfolio["numInvestments"],
        lastName: portfolio["lastName"],
        background: portfolio["background"],
        interests: List.generate(
            portfolio["interests"]["edges"].length,
            (index) =>
                portfolio["interests"]["edges"][index]["node"]["industry"]),
        investment: portfolio["investment"],
        currentOccupation: portfolio["currentOccupation"],
        linkedinProfile: portfolio["linkedinProfile"],
      ));
    }
    return investorPortfolioModelList;
  }
}
