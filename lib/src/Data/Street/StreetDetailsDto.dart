class StreetsDetailsDto {
  List<Data> data;

  StreetsDetailsDto({this.data});

  StreetsDetailsDto.fromJson(Map<String, dynamic> json) {
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
  String name;
  String cityName;
  int capacity;

  Data({this.id, this.name, this.cityName, this.capacity});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    cityName = json['CityName'];
    capacity = json['Capacity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['CityName'] = this.cityName;
    data['Capacity'] = this.capacity;
    return data;
  }
}
