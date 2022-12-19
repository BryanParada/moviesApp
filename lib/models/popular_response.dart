// To parse this JSON data, do
//
//     final popularReponse = popularReponseFromMap(jsonString);

import 'dart:convert';

import 'models.dart';
 

class PopularReponse {
    PopularReponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    factory PopularReponse.fromJson(String str) => PopularReponse.fromMap(json.decode(str));
 
    factory PopularReponse.fromMap(Map<String, dynamic> json) => PopularReponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );
 
}
 
