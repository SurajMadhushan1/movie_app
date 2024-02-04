import 'package:movie_app/models/company_model.dart';
import 'package:movie_app/models/genres_model.dart';

class MovieModel {
  String? posterPath;
  String? overview;
  int? id;
  String? title;
  String? backdropPath;
  double? voteAverage;
  String? overView;
  bool? adult;
  int? budget;
  String? tagline;
  int? voteCount;
  String? status;
  List<CompanyModel>? companies;
  List<GenresModel>? genres;

  MovieModel(
      {this.backdropPath,
      this.id,
      this.overview,
      this.posterPath,
      this.title,
      this.voteAverage,
      this.overView,
      this.adult,
      this.budget,
      this.status,
      this.tagline,
      this.voteCount,
      this.companies,
      this.genres});

  factory MovieModel.fromJson(Map<String, dynamic> map) {
    List<CompanyModel> companies =
        []; // we cannot make variables inside the if else, so that reason we make it outside the if
    List<GenresModel> genres = [];

    if (map.containsKey('production_companies')) {
      companies = (map['production_companies'] as List)
          .map((e) => CompanyModel.fromJson(e))
          .toList();
      genres =
          (map['genres'] as List).map((e) => GenresModel.fromJson(e)).toList();
    }

    return MovieModel(
      backdropPath: "https://image.tmdb.org/t/p/w500${map['backdrop_path']}",
      id: map['id'],
      overview: map['overview'],
      posterPath: "https://image.tmdb.org/t/p/w500${map['poster_path']}",
      title: map['title'],
      voteAverage: map['vote_average'].toDouble(),
      overView: map['overview'],
      adult: map['adult'] ?? false,
      budget: map['budget'] ?? 0,
      status: map['status'] ?? "",
      tagline: map['tagline'] ?? "",
      voteCount: map['vote_count'] ?? 0,
      companies: companies,
      genres: genres,
    );
  }
}
