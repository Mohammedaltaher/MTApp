class StreetReportDto {
  List<Data> data;

  StreetReportDto({this.data});

  StreetReportDto.fromJson(Map<String, dynamic> json) {
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
  int streetId;
  String value;
  int carsCount;
  int trafficJam;

  Data({this.streetId, this.value, this.carsCount, this.trafficJam});

  Data.fromJson(Map<String, dynamic> json) {
    streetId = json['streetId'];
    value = json['Value'];
    carsCount = json['carsCount'];
    trafficJam = json['TrafficJam'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['streetId'] = this.streetId;
    data['Value'] = this.value;
    data['carsCount'] = this.carsCount;
    data['TrafficJam'] = this.trafficJam;
    return data;
  }
}
