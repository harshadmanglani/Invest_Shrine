import 'package:MobileApp/models/entrepreneurs/entrepreneur_model.dart';

class EntrepreneurUserModel {
  EntrepreneurPortfolioModel entrepreneurPortfolioModel;
  String email;
  String password;
  String username;

  EntrepreneurUserModel() {
    entrepreneurPortfolioModel = EntrepreneurPortfolioModel();
  }
}
