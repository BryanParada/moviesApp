// To parse this JSON data, do
//
//     final searchReponse = searchReponseFromMap(jsonString);

import 'dart:convert';

import 'models.dart';

class SearchReponse {
    SearchReponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    factory SearchReponse.fromJson(String str) => SearchReponse.fromMap(json.decode(str));
 
    factory SearchReponse.fromMap(Map<String, dynamic> json) => SearchReponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );
 
}
 