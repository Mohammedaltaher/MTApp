class StreetDto {
  List<Data> data;

  StreetDto({this.data});

  StreetDto.fromJson(Map<String, dynamic> json) {
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
  String streetName;
  int currentCars;
  int capacity;

  Data({this.streetName, this.currentCars, this.capacity});

  Data.fromJson(Map<String, dynamic> json) {
    streetName = json['StreetName'];
    currentCars = json['CurrentCars'];
    capacity = json['Capacity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StreetName'] = this.streetName;
    data['CurrentCars'] = this.currentCars;
    data['Capacity'] = this.capacity;
    return data;
  }
}

class StreetInfo {
  final String streetName;
  final int capacity;
  final int currentCars;

  StreetInfo({this.streetName, this.capacity, this.currentCars});

  factory StreetInfo.fromJson(Map<String, dynamic> json) {
    return StreetInfo(
      streetName: json['StreetName'] as String,
      capacity: json['Capacity'] as int,
      currentCars: json['CurrentCars'] as int,
    );
  }
}
