class EntrepreneurPortfolioModel {
  String id;
  String uid;
  String firstName;
  String lastName;
  String execSummary;
  String linkedinProfile;
  String displayImage;
  String location;

  EntrepreneurPortfolioModel(
      {this.execSummary,
      this.id,
      this.uid,
      this.location,
      this.linkedinProfile,
      this.firstName,
      this.lastName,
      this.displayImage});
}
