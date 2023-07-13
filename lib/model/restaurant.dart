class RestaurantsModel {
  List<RestaurantData>? restaurant;

  RestaurantsModel({this.restaurant});

  RestaurantsModel.fromJson(Map<String, dynamic> json) {
    if (json['restaurants'] != null) {
      restaurant = <RestaurantData>[];
      json['restaurants'].forEach((v) {
        restaurant!.add(RestaurantData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (restaurant != null) {
      data['restaurants'] = restaurant!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RestaurantData {
  int? id;
  String? name;
  String? neighborhood;
  String? photograph;
  String? address;
  Latlng? latlng;
  String? cuisineType;
  OperatingHours? operatingHours;
  List<Reviews>? reviews;

  RestaurantData(
      {this.id,
      this.name,
      this.neighborhood,
      this.photograph,
      this.address,
      this.latlng,
      this.cuisineType,
      this.operatingHours,
      this.reviews});

  RestaurantData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    neighborhood = json['neighborhood'];
    photograph = json['photograph'];
    address = json['address'];
    latlng = json['latlng'] != null ? Latlng.fromJson(json['latlng']) : null;
    cuisineType = json['cuisine_type'];
    operatingHours = json['operating_hours'] != null
        ? OperatingHours.fromJson(json['operating_hours'])
        : null;
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['neighborhood'] = neighborhood;
    data['photograph'] = photograph;
    data['address'] = address;
    if (latlng != null) {
      data['latlng'] = latlng!.toJson();
    }
    data['cuisine_type'] = cuisineType;
    if (operatingHours != null) {
      data['operating_hours'] = operatingHours!.toJson();
    }
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Latlng {
  double? lat;
  double? lng;

  Latlng({this.lat, this.lng});

  Latlng.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}

class OperatingHours {
  String? monday;
  String? tuesday;
  String? wednesday;
  String? thursday;
  String? friday;
  String? saturday;
  String? sunday;

  OperatingHours(
      {this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday,
      this.sunday});

  OperatingHours.fromJson(Map<String, dynamic> json) {
    monday = json['Monday'];
    tuesday = json['Tuesday'];
    wednesday = json['Wednesday'];
    thursday = json['Thursday'];
    friday = json['Friday'];
    saturday = json['Saturday'];
    sunday = json['Sunday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Monday'] = monday;
    data['Tuesday'] = tuesday;
    data['Wednesday'] = wednesday;
    data['Thursday'] = thursday;
    data['Friday'] = friday;
    data['Saturday'] = saturday;
    data['Sunday'] = sunday;
    return data;
  }
}

class Reviews {
  String? name;
  String? date;
  int? rating;
  String? comments;

  Reviews({this.name, this.date, this.rating, this.comments});

  Reviews.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    date = json['date'];
    rating = json['rating'];
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['date'] = date;
    data['rating'] = rating;
    data['comments'] = comments;
    return data;
  }
}
