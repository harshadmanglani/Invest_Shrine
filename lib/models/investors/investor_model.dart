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
  InvestorModel(
      {this.background,
      this.investment,
      this.currentOccupation,
      this.firstName,
      this.id,
      this.interests,
      this.investmentHistory,
      this.lastName,
      this.linkedinProfile});
}
