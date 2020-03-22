class LocationDataModel {
  final String country;
  final String lat;
  final String long;

  LocationDataModel({this.country, this.lat, this.long});

  factory LocationDataModel.fromJson(Map<String, dynamic> json) {
    return LocationDataModel(
      country: json['country'],
      lat: json['lat'],
      long: json['long'],
    );
  }
}
