import 'dart:convert';

class VenturePortfolioModel {
  String id;
  String ventureName;
  String ventureId;
  String startupSummary;
  String website;
  int investment;
  String tagLine;
  String vLinkedinProfile;
  String location;
  List<String> industry;
  String logoImage;
  String mainImage;

  VenturePortfolioModel(
      {this.id,
      this.location,
      this.ventureId,
      this.investment,
      this.industry,
      this.tagLine,
      this.startupSummary,
      this.ventureName,
      this.vLinkedinProfile,
      this.logoImage,
      this.mainImage,
      this.website});

  VenturePortfolioModel.fromJson(Map<String, dynamic> jsonMap) {
    VenturePortfolioModel(
        vLinkedinProfile: jsonMap["vLinkedinProfile"],
        ventureName: jsonMap["ventureName"],
        startupSummary: jsonMap["startupSummary"],
        mainImage: jsonMap["mainImage"],
        logoImage: jsonMap["logoImage"],
        ventureId: jsonMap["ventureId"],
        industry: List.generate(jsonMap["industry"]["edges"].length,
            (index) => jsonMap["industry"]["edges"][index]["node"]["industry"]),
        investment: jsonMap["investment"],
        website: jsonMap["website"],
        tagLine: jsonMap["tagLine"],
        location: jsonMap["location"],
        id: base64
            .encode(latin1.encode("VentureModel:${jsonMap["ventureId"]}")));
  }
}
