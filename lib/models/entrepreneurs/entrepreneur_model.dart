import 'dart:convert';

class EntrepreneurPortfolioModel {
  String id;
  String firstName;
  String lastName;
  String execSummary;
  String hashedVentureId;
  String ventureId;
  String linkedinProfile;
  String displayImage;
  String location;

  EntrepreneurPortfolioModel(
      {this.execSummary,
      this.id,
      this.location,
      this.hashedVentureId,
      this.ventureId,
      this.linkedinProfile,
      this.firstName,
      this.lastName,
      this.displayImage});

  EntrepreneurPortfolioModel.fromJson(Map<String, dynamic> jsonMap) {
    EntrepreneurPortfolioModel(
      firstName: jsonMap["firstName"],
      id: jsonMap["id"],
      ventureId: jsonMap["venture"]["ventureId"],
      hashedVentureId: base64.encode(latin1
          .encode("EntrepreneurPortfolio:${jsonMap["venture"]["ventureId"]}")),
      location: jsonMap["location"],
      displayImage: jsonMap["displayImage"],
      lastName: jsonMap["lastName"],
      execSummary: jsonMap["execSummary"],
      linkedinProfile: jsonMap["linkedinProfile"],
    );
  }
}
