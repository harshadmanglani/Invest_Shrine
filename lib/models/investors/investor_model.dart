class InvestorModel {
  String id;
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
  InvestorModel(
      {this.background,
      this.location,
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
