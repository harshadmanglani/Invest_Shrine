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
          venture{
            ventureId,
          }
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
      entrepreneurPortfolioList
          .add(EntrepreneurPortfolioModel.fromJson(portfolio));
    }
    return entrepreneurPortfolioList;
  }

  Future<dynamic> getEntrepreneurWithId({String id}) async {
    String query = searchEntrepreneur(searchQuery: ('(id:$id)'));
    String responseFromApi = await user.interactWithApi(query);
    Map<dynamic, dynamic> parsedResponse = json.decode(responseFromApi);
    return EntrepreneurPortfolioModel.fromJson(parsedResponse);
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
      venturePortfolioList.add(VenturePortfolioModel.fromJson(portfolio));
    }
    return venturePortfolioList;
  }

  Future<dynamic> getVenturePortfolioWithId({String id}) async {
    String query = searchVenture(searchQuery: '(ventureId: $id)');
    String responseFromApi = await user.interactWithApi(query);
    Map<dynamic, dynamic> parsedResponse = json.decode(responseFromApi);
    return VenturePortfolioModel.fromJson(
        parsedResponse["data"]["allVentures"]["edges"][0]);
  }
}
