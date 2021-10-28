import 'dart:convert';

Places placeFromJson(String str) => Places.fromJson(json.decode(str));

String placeToJson(Places data) => json.encode(data.toJson());

class Places {
  Places({
    required this.htmlAttributions,
    required this.nextPageToken,
    required this.results,
    required this.status,
  });

  final List<dynamic> htmlAttributions;
  final String? nextPageToken;
  final List<Place> results;
  final String status;

  factory Places.fromJson(Map<String, dynamic> json) => Places(
        htmlAttributions:
            List<dynamic>.from(json["html_attributions"].map((x) => x)),
        nextPageToken: json["next_page_token"],
        results:
            List<Place>.from(json["results"].map((x) => Place.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "html_attributions": List<dynamic>.from(htmlAttributions.map((x) => x)),
        "next_page_token": nextPageToken,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "status": status,
      };
}

class Place {
  Place({
    required this.geometry,
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconMaskBaseUri,
    required this.name,
    required this.placeId,
    required this.rating,
    required this.userRatingsTotal,
  });

  final Geometry geometry;
  final String icon;
  final String iconBackgroundColor;
  final String iconMaskBaseUri;
  final String name;
  //final OpeningHours? openingHours;
  final String placeId;
  final double? rating;
  final int? userRatingsTotal;

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        geometry: Geometry.fromJson(json["geometry"]),
        icon: json["icon"],
        iconBackgroundColor: json["icon_background_color"],
        iconMaskBaseUri: json["icon_mask_base_uri"],
        name: json["name"],
        placeId: json["place_id"],
        rating: json["rating"] == null ? 0 : json["rating"].toDouble(),
        userRatingsTotal: json["user_ratings_total"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "geometry": geometry.toJson(),
        "name": name,
        "place_id": placeId,
        "rating": rating,
        "user_ratings_total": userRatingsTotal,
      };
}

class Geometry {
  Geometry({
    required this.location,
    required this.viewport,
  });

  final PlaceLocation location;
  final Viewport viewport;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        location: PlaceLocation.fromJson(json["location"]),
        viewport: Viewport.fromJson(json["viewport"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "viewport": viewport.toJson(),
      };
}

class PlaceLocation {
  PlaceLocation({
    required this.lat,
    required this.lng,
  });

  final double lat;
  final double lng;

  factory PlaceLocation.fromJson(Map<String, dynamic> json) => PlaceLocation(
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}

class Viewport {
  Viewport({
    required this.northeast,
    required this.southwest,
  });

  final PlaceLocation northeast;
  final PlaceLocation southwest;

  factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
        northeast: PlaceLocation.fromJson(json["northeast"]),
        southwest: PlaceLocation.fromJson(json["southwest"]),
      );

  Map<String, dynamic> toJson() => {
        "northeast": northeast.toJson(),
        "southwest": southwest.toJson(),
      };
}

class OpeningHours {
  OpeningHours({
    required this.openNow,
  });

  final bool openNow;

  factory OpeningHours.fromJson(Map<String, dynamic> json) => OpeningHours(
        openNow: json["open_now"],
      );

  Map<String, dynamic> toJson() => {
        "open_now": openNow,
      };
}

class Photo {
  Photo({
    required this.height,
    required this.htmlAttributions,
    required this.photoReference,
    required this.width,
  });

  final int height;
  final List<String> htmlAttributions;
  final String photoReference;
  final int width;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        height: json["height"],
        htmlAttributions:
            List<String>.from(json["html_attributions"].map((x) => x)),
        photoReference: json["photo_reference"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "height": height,
        "html_attributions": List<dynamic>.from(htmlAttributions.map((x) => x)),
        "photo_reference": photoReference,
        "width": width,
      };
}

class PlusCode {
  PlusCode({
    required this.compoundCode,
    required this.globalCode,
  });

  final String compoundCode;
  final String globalCode;

  factory PlusCode.fromJson(Map<String, dynamic> json) => PlusCode(
        compoundCode: json["compound_code"],
        globalCode: json["global_code"],
      );

  Map<String, dynamic> toJson() => {
        "compound_code": compoundCode,
        "global_code": globalCode,
      };
}
