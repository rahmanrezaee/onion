class GlobalChart {
  int newConfirmed;
  int totalConfirmed;
  int newDeaths;
  int totalDeaths;
  int newRecovered;
  int totalRecovered;

  GlobalChart.toJson(Map json) {
    this.newConfirmed = json["NewConfirmed"];
    this.totalConfirmed = json["TotalConfirmed"];
    this.newDeaths = json["NewDeaths"];
    this.totalDeaths = json["TotalDeaths"];
    this.newRecovered = json["NewRecovered"];
    this.totalRecovered = json["TotalRecovered"];
  }
}
