import 'package:MobileApp/models/investors/investor_model.dart';

class InvestorUserModel {
  InvestorPortfolioModel investorPortfolioModel;
  String username;
  String password;
  String email;

  InvestorUserModel() {
    investorPortfolioModel = InvestorPortfolioModel();
  }
}
