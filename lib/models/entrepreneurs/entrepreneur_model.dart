class EntrepreneurPortfolioModel {
  String id;
  String uid;
  String firstName;
  String lastName;
  String execSummary;
  String linkedinProfile;
  String displayImage;

  EntrepreneurPortfolioModel(
      {this.execSummary,
      this.id,
      this.uid,
      this.linkedinProfile,
      this.firstName,
      this.lastName,
      this.displayImage});
}
