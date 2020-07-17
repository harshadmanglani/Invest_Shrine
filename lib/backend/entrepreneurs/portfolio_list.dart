import 'package:MobileApp/models/entrepreneurs/venture_model.dart';

import '../api_provider.dart';
import 'dart:convert';
import '../../models/entrepreneurs/entrepreneur_model.dart';

class EntrepreneurPortfolioList {
  String searchEntrepreneur({String searchQuery = ''}) {
    return '''query{
    allEntrepreneurs''' +
        searchQuery +
        '''{
      edges{
        node{
          id,
          firstName,
          linkedinProfile,
          lastName,
          execSummary,
        }
      }
    }
  } ''';
  }

  Future<dynamic> getAllEntrepreneurPortfolios(
      {String searchQuery = ''}) async {
    String query = searchEntrepreneur(searchQuery: searchQuery);
    String responseFromApi = await ApiProvider().interactWithApi(query);
    Map<dynamic, dynamic> parsedResponse = json.decode(responseFromApi);
    List<dynamic> allPortfolios =
        parsedResponse["data"]["allEntrepreneurs"]["edges"];
    List<EntrepreneurModel> entrepreneurPortfolioList = [];

    for (var i = 0; i < allPortfolios.length; i++) {
      dynamic portfolio = allPortfolios[i]["node"];
      entrepreneurPortfolioList.add(EntrepreneurModel(
        firstName: portfolio["firstName"],
        id: portfolio["id"],
        lastName: portfolio["lastName"],
        venture: portfolio["venture"],
        execSummary: portfolio["execSummary"],
        linkedinProfile: portfolio["linkedinProfile"],
      ));
    }
    return entrepreneurPortfolioList;
  }
}

class VenturePortfolioList {
  String searchVenture({String searchQuery = ''}) {
    return ''' 
  query{
    allVentures''' +
        searchQuery +
        '''
      {
      edges{
        node{
          id,
           ventureName,
           startupSummary,
           tagLine,
           location,
           investment,
          vLinkedinProfile,
           industry{
             industry
          }
        }
      }
    }
  }
  ''';
  }

  Future<dynamic> getAllVenturePortfolios({String searchQuery = ''}) async {
    String query = searchVenture(searchQuery: searchQuery);
    String responseFromApi = await ApiProvider().interactWithApi(query);
    Map<dynamic, dynamic> parsedResponse = json.decode(responseFromApi);
    List<dynamic> allPortfolios =
        parsedResponse["data"]["allVentures"]["edges"];

    List<VentureModel> venturePortfolioList = [];

    for (var i = 0; i < allPortfolios.length; i++) {
      dynamic portfolio = allPortfolios[i]["node"];

      venturePortfolioList.add(new VentureModel(
          id: portfolio["id"],
          vLinkedinProfile: portfolio["vLinkedinProfile"],
          ventureName: portfolio["ventureName"],
          startupSummary: portfolio["startupSummary"],
          industry: [
            portfolio["industry"][0]["industry"],
            portfolio["industry"][1]["industry"]
          ],
          investment: portfolio["investment"],
          website: portfolio["website"],
          tagLine: portfolio["tagLine"],
          location: portfolio["location"]));
    }
    return venturePortfolioList;
  }
}
