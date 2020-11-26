class TableSatatis {
  String date;
  int confiromed;
  int actived;
  int recovered;
  int death;

  TableSatatis({
    this.actived,
    this.confiromed,
    this.date,
    this.death,
    this.recovered
    
  });
  TableSatatis.toDailyJson(Map json) {
    this.confiromed = json["Confirmed"];
    this.death = json["Deaths"];
    this.recovered = json["Recovered"];
    this.date = json["Date"];
    this.actived = json["Active"];
  }
}
