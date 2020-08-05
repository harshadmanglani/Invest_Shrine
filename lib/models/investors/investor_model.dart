class InvestorPortfolioModel {
  String id;
  String uid;
  String firstName;
  String lastName;
  String currentOccupation;
  String linkedinProfile;
  String background;
  List<String> interests;
  List<String> investmentHistory;
  int investment;
  int numInvestments;
  String location;
  String displayImage;
  InvestorPortfolioModel(
      {this.background,
      this.location,
      this.uid,
      this.numInvestments,
      this.investment,
      this.currentOccupation,
      this.firstName,
      this.id,
      this.interests,
      this.investmentHistory,
      this.lastName,
      this.displayImage,
      this.linkedinProfile});
}
