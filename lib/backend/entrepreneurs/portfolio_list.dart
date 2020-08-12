import 'package:MobileApp/models/entrepreneurs/venture_model.dart';

import '../api_provider.dart';
import 'dart:convert';
import '../../models/entrepreneurs/entrepreneur_model.dart';

class EntrepreneurPortfolioListAPI {
  String searchEntrepreneur({String searchQuery = ''}) {
    return '''query{
    allEntrepreneurs''' +
        searchQuery +
        '''{
      edges{
        node{
          id,
          firstName,
          location,
          
          linkedinProfile,
          portfolioId,
          displayImage,
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
    String responseFromApi = await user.interactWithApi(query);
    Map<dynamic, dynamic> parsedResponse = json.decode(responseFromApi);
    List<dynamic> allPortfolios =
        parsedResponse["data"]["allEntrepreneurs"]["edges"];
    List<EntrepreneurPortfolioModel> entrepreneurPortfolioList = [];

    for (var i = 0; i < allPortfolios.length; i++) {
      dynamic portfolio = allPortfolios[i]["node"];
      entrepreneurPortfolioList.add(EntrepreneurPortfolioModel(
        firstName: portfolio["firstName"],
        id: portfolio["id"],
        uid: portfolio["portfolioId"],
        location: portfolio["location"],
        displayImage: portfolio["displayImage"],
        lastName: portfolio["lastName"],
        execSummary: portfolio["execSummary"],
        linkedinProfile: portfolio["linkedinProfile"],
      ));
    }
    return entrepreneurPortfolioList;
  }
}

class VenturePortfolioListAPI {
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
           mainImage,
           logoImage,
           location,
           website,
           ventureId,
           investment,
          vLinkedinProfile,
           industry{
             edges{
               node{
             industry
             }
            }
          }
        }
      }
    }
  }
  ''';
  }

  Future<dynamic> getAllVenturePortfolios({String searchQuery = ''}) async {
    String query = searchVenture(searchQuery: searchQuery);
    String responseFromApi = await user.interactWithApi(query);
    Map<dynamic, dynamic> parsedResponse = json.decode(responseFromApi);
    List<dynamic> allPortfolios =
        parsedResponse["data"]["allVentures"]["edges"];

    List<VenturePortfolioModel> venturePortfolioList = [];

    for (var i = 0; i < allPortfolios.length; i++) {
      dynamic portfolio = allPortfolios[i]["node"];

      venturePortfolioList.add(new VenturePortfolioModel(
          id: portfolio["id"],
          vLinkedinProfile: portfolio["vLinkedinProfile"],
          ventureName: portfolio["ventureName"],
          startupSummary: portfolio["startupSummary"],
          mainImage: portfolio["mainImage"],
          logoImage: portfolio["logoImage"],
          uid: portfolio["ventureId"],
          industry: List.generate(
              portfolio["industry"]["edges"].length,
              (index) =>
                  portfolio["industry"]["edges"][index]["node"]["industry"]),
          investment: portfolio["investment"],
          website: portfolio["website"],
          tagLine: portfolio["tagLine"],
          location: portfolio["location"]));
    }
    return venturePortfolioList;
  }
}
