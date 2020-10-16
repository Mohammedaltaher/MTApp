class AllStreetDto {
  List<Data> data;

  AllStreetDto({this.data});

  AllStreetDto.fromJson(Map<String, dynamic> json) {
    if (json['Data'] != null) {
      data = new List<Data>();
      json['Data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int streetID;
  String streetName;
  String cityName;
  int streetCapacity;
  String from;
  String to;
  int carrentCars;
  double trafficJam;

  Data(
      {this.streetID,
      this.streetName,
      this.cityName,
      this.streetCapacity,
      this.from,
      this.to,
      this.carrentCars,
      this.trafficJam});

  Data.fromJson(Map<String, dynamic> json) {
    streetID = json['StreetID'];
    streetName = json['StreetName'];
    cityName = json['CityName'];
    streetCapacity = json['StreetCapacity'];
    from = json['From'];
    to = json['To'];
    carrentCars = json['CarrentCars'];
    trafficJam = json['TrafficJam'];
  }

  get capacity => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StreetID'] = this.streetID;
    data['StreetName'] = this.streetName;
    data['CityName'] = this.cityName;
    data['StreetCapacity'] = this.streetCapacity;
    data['From'] = this.from;
    data['To'] = this.to;
    data['CarrentCars'] = this.carrentCars;
    data['TrafficJam'] = this.trafficJam;
    return data;
  }
}
