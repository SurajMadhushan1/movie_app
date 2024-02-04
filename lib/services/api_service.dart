import 'dart:convert';

import 'package:http/http.dart';
import 'package:movie_app/models/movie_model.dart';

class ApiServices {
  String popularMovies = "https://api.themoviedb.org/3/movie/popular";
  String topRatedMovies = "https://api.themoviedb.org/3/movie/top_rated";
  String upcommingMovies = "https://api.themoviedb.org/3/movie/upcoming";
  String movieDetails = "https://api.themoviedb.org/3/movie/";
  String searchMovie = "https://api.themoviedb.org/3/search/movie";
  String apiKey = "?api_key=e6cc2b28aa0862deda8e90a9e20822f4";

  Future<List<MovieModel>> getPopularMovies() async {
    Response response = await get(Uri.parse("$popularMovies$apiKey"));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      List<dynamic> results = body["results"];
      List<MovieModel> movies =
          results.map((e) => MovieModel.fromJson(e)).toList();
      return movies;
    } else {
      return [];
    }
  }

  Future<List<MovieModel>> getTopratedMovies() async {
    Response response = await get(Uri.parse("$topRatedMovies$apiKey"));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      List<dynamic> results = body["results"];

      List<MovieModel> movies =
          results.map((e) => MovieModel.fromJson(e)).toList();
      return movies;
    } else {
      return [];
    }
  }

  Future<List<MovieModel>> getUpcommingMovies() async {
    Response response = await get(Uri.parse("$upcommingMovies$apiKey"));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      List<dynamic> results = body['results'];
      List<MovieModel> movies =
          results.map((e) => MovieModel.fromJson(e)).toList();
      return movies;
    } else {
      return [];
    }
  }

  Future<MovieModel> getMovieDetails(String id) async {
    Response response = await get(Uri.parse("$movieDetails$id$apiKey"));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      MovieModel movie = MovieModel.fromJson(body);
      return movie;
    } else {
      return MovieModel();
    }
  }

  Future<List<MovieModel>> searchMovies(String query) async {
    Response response =
        await (get(Uri.parse("$searchMovie$apiKey&query=$query")));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      List<dynamic> results = body['results'];
      List<MovieModel> movies = results
          .map((e) => MovieModel.fromJson(e))
          .toList(); // to list use for make movie model all elements as a list
      return movies;
    } else {
      throw response.statusCode; //  for return to status code
    }
  }
}
