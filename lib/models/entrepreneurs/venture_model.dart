class VentureModel {
  String id;
  String ventureName;
  String startupSummary;
  String website;
  int investment;
  String tagLine;
  String vLinkedinProfile;
  String location;
  List<String> industry;

  VentureModel(
      {this.id,
      this.location,
      this.investment,
      this.industry,
      this.tagLine,
      this.startupSummary,
      this.ventureName,
      this.vLinkedinProfile,
      this.website});
}
