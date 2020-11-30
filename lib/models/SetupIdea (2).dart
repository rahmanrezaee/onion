class SetupIdeaModel {
  String category;
  String experienceYear;
  String experienceMonth;
  int teamSize;
  String aboutBusinnes;
  List<String> location = [];
  String website;
  Map<String, String> sendMap() {
    return {
      "industry": category,
      "industryExperienceInMonth":
          "${int.parse(experienceYear) * 12 + int.parse(experienceMonth)}",
      "teamSize": teamSize.toString(),
      "location": location.toString(),
      "aboutYourBusiness": aboutBusinnes,
      "website": website,
    };
  }

  Map<String, String> asMap() {
    return {
      "category": category,
      "experienceYear": experienceYear,
      "experienceMonth": experienceMonth,
      "teamSize": teamSize.toString(),
      "location": location.toString(),
      "aboutYourBusiness": aboutBusinnes,
      "website": website,
    };
  }
}
