// To parse this JSON data, do
//
//     final modelAllCharacter = modelAllCharacterFromJson(jsonString);

import 'dart:convert';

ModelAllCharacter modelAllCharacterFromJson(String str) => ModelAllCharacter.fromJson(json.decode(str));

String modelAllCharacterToJson(ModelAllCharacter data) => json.encode(data.toJson());

class ModelAllCharacter {
    Info info;
    List<Result> results;

    ModelAllCharacter({
        required this.info,
        required this.results,
    });

    factory ModelAllCharacter.fromJson(Map<String, dynamic> json) => ModelAllCharacter(
        info: Info.fromJson(json["info"]),
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "info": info.toJson(),
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Info {
    int count;
    int pages;
    String next;
    dynamic prev;

    Info({
        required this.count,
        required this.pages,
        required this.next,
        required this.prev,
    });

    factory Info.fromJson(Map<String, dynamic> json) => Info(
        count: json["count"],
        pages: json["pages"],
        next: json["next"],
        prev: json["prev"],
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "pages": pages,
        "next": next,
        "prev": prev,
    };
}

class Result {
    int id;
    String name;
    String status;
    String species;
    String gender;
    Location origin;
    Location location;
    String image;

    Result({
        required this.id,
        required this.name,
        required this.status,
        required this.species,
        required this.gender,
        required this.origin,
        required this.location,
        required this.image,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        species: json["species"],
        gender: json["gender"],
        origin: Location.fromJson(json["origin"]),
        location: Location.fromJson(json["location"]),
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "species": species,
        "gender": gender,
        "origin": origin.toJson(),
        "location": location.toJson(),
        "image": image,
    };
}

class Location {
    String name;
    String url;

    Location({
        required this.name,
        required this.url,
    });

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
    };
}
