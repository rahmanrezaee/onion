class CircularChart {
  String slug;
  String country;
  String countryCode;
  int newConfirmed;
  int totalConfirmed;
  int newDeaths;
  int totalDeaths;
  int newRecovered;
  int active;
  int totalRecovered;
  String date;
  
  CircularChart(
      {this.active,
      this.country,
      this.countryCode,
      this.date,
      this.newConfirmed,
      this.newDeaths,
      this.newRecovered,
      this.slug,
      this.totalConfirmed,
      this.totalDeaths,
      this.totalRecovered});


  CircularChart.toJson(Map json) {
    this.country = json["Country"];
    this.countryCode = json["CountryCode"];
    this.slug = json["Slug"];
    this.newConfirmed = json["NewConfirmed"];
    this.totalConfirmed = json["TotalConfirmed"];
    this.newDeaths = json["NewDeaths"];
    this.totalDeaths = json["TotalDeaths"];
    this.newRecovered = json["NewRecovered"];
    this.totalRecovered = json["TotalRecovered"];
    this.date = json["Date"];
    this.active = json["TotalConfirmed"] - json["NewConfirmed"];
  }
}
