import 'dart:convert';

class TrailerReponse {
    TrailerReponse({
        required this.id,
        required this.results,
    });

    int id;
    List<Result> results;

    factory TrailerReponse.fromJson(String str) => TrailerReponse.fromMap(json.decode(str));
 
    factory TrailerReponse.fromMap(Map<String, dynamic> json) => TrailerReponse(
        id: json["id"],
        results: List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
    );
}

class Result {
    Result({
        //required this.iso6391,
        //required this.iso31661,
        required this.name,
        required this.key,
        required this.site,
        required this.size,
        required this.type,
        required this.official,
        required this.publishedAt,
        required this.id,
    });

    //Iso6391 iso6391;
    //Iso31661 iso31661;
    String name;
    String key;
    String site;
    int size;
    String type;
    bool official;
    DateTime publishedAt;
    String id;

    factory Result.fromJson(String str) => Result.fromMap(json.decode(str));
 
    factory Result.fromMap(Map<String, dynamic> json) => Result(
        //iso6391: iso6391Values.map[json["iso_639_1"]],
        //iso31661: iso31661Values.map[json["iso_3166_1"]],
        name: json["name"],
        key: json["key"],
        site: json["site"],
        size: json["size"],
        type: json["type"],
        official: json["official"],
        publishedAt: DateTime.parse(json["published_at"]),
        id: json["id"],
    );

 
}

 
