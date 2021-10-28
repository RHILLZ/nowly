import 'dart:convert';

PlaceAutoCompleteResponse placeAutoCompleteResponseFromJson(String str) => PlaceAutoCompleteResponse.fromJson(json.decode(str));

String placeAutoCompleteResponseToJson(PlaceAutoCompleteResponse data) => json.encode(data.toJson());

class PlaceAutoCompleteResponse {
    PlaceAutoCompleteResponse({
        required this.predictions,
        required this.status,
    });

    final List<PlacePrediction> predictions;
    final String status;

    factory PlaceAutoCompleteResponse.fromJson(Map<String, dynamic> json) => PlaceAutoCompleteResponse(
        predictions: List<PlacePrediction>.from(json["predictions"].map((x) => PlacePrediction.fromJson(x))),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "predictions": List<dynamic>.from(predictions.map((x) => x.toJson())),
        "status": status,
    };
}

class PlacePrediction {
    PlacePrediction({
        required this.description,
        required this.placeId,
        required this.reference,
        required this.structuredFormatting,
        required this.types,
        // required this.terms,
        // required this.matchedSubstrings,
     });

    final String description;
    final String placeId;
    final String reference;
    final _StructuredFormatting structuredFormatting;
    final List<String> types;
    // final List<_Term> terms;
    // final List<_MatchedSubstring> matchedSubstrings;

    factory PlacePrediction.fromJson(Map<String, dynamic> json) => PlacePrediction(
        description: json["description"],
        placeId: json["place_id"],
        reference: json["reference"],
        structuredFormatting: _StructuredFormatting.fromJson(json["structured_formatting"]),
         types: List<String>.from(json["types"].map((x) => x)),
         // terms: List<_Term>.from(json["terms"].map((x) => _Term.fromJson(x))),
         // matchedSubstrings: List<_MatchedSubstring>.from(json["matched_substrings"].map((x) => _MatchedSubstring.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "place_id": placeId,
        "reference": reference,
        "types": List<dynamic>.from(types.map((x) => x)),
        // "terms": List<dynamic>.from(terms.map((x) => x.toJson())),
        // "matched_substrings": List<dynamic>.from(matchedSubstrings.map((x) => x.toJson())),
    };
}



class _StructuredFormatting {
    _StructuredFormatting({
        required this.mainText,
        required this.secondaryText,
        // required this.mainTextMatchedSubstrings,
     });

    final String mainText;
    final String secondaryText;
    // final List<_MatchedSubstring> mainTextMatchedSubstrings;
    
     factory _StructuredFormatting.fromJson(Map<String, dynamic> json) => _StructuredFormatting(
        mainText: json["main_text"],
        secondaryText: json["secondary_text"],
        // mainTextMatchedSubstrings: List<_MatchedSubstring>.from(json["main_text_matched_substrings"].map((x) => MatchedSubstring.fromJson(x))),
    );
}

// class _Term {
//     _Term({
//         required this.offset,
//         required this.value,
//     });

//     final int offset;
//     final String value;

//     factory _Term.fromJson(Map<String, dynamic> json) => _Term(
//         offset: json["offset"],
//         value: json["value"],
//     );

//     Map<String, dynamic> toJson() => {
//         "offset": offset,
//         "value": value,
//     };
// }

// class _MatchedSubstring {
//     _MatchedSubstring({
//         required this.length,
//         required this.offset,
//     });

//     final int length;
//     final int offset;

//     factory _MatchedSubstring.fromJson(Map<String, dynamic> json) => _MatchedSubstring(
//         length: json["length"],
//         offset: json["offset"],
//     );

//     Map<String, dynamic> toJson() => {
//         "length": length,
//         "offset": offset,
//     };
// }
