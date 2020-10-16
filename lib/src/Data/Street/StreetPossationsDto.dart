class StreetPossationsDto {
  List<Data> data;

  StreetPossationsDto({this.data});

  StreetPossationsDto.fromJson(Map<String, dynamic> json) {
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
  int id;
  int streetID;
  String streetName;
  double latitude;
  double longitude;
  String name;
  String cityName;
  int capcity;

  Data(
      {this.id,
      this.streetID,
      this.streetName,
      this.latitude,
      this.longitude,
      this.name,
      this.cityName,
      this.capcity});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    streetID = json['StreetID'];
    streetName = json['StreetName'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    name = json['Name'];
    cityName = json['CityName'];
    capcity = json['Capcity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['StreetID'] = this.streetID;
    data['StreetName'] = this.streetName;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['Name'] = this.name;
    data['CityName'] = this.cityName;
    data['Capcity'] = this.capcity;
    return data;
  }
}
