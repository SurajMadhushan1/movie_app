import 'package:flutter/material.dart';
import 'package:movie_app/models/company_model.dart';
import 'package:movie_app/models/genres_model.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/services/api_service.dart';

class MovieView extends StatefulWidget {
  MovieView({super.key, required this.movie});
  MovieModel movie;

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  List<CompanyModel> company = [];
  List<GenresModel> genres = [];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            widget.movie.backdropPath.toString()))),
                width: size.width,
                height: 200,
                child: const Stack(
                  children: [
                    BackButton(
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              // end of the image

              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "${widget.movie.title}",
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Hero(
                        tag: "${widget.movie.id}hero",
                        child: Container(
                          height: 180,
                          width: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular((15)),
                              color: Colors.grey,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      widget.movie.posterPath.toString()))),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text(
                          '${widget.movie.overView}',
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              FutureBuilder(
                future:
                    ApiServices().getMovieDetails(widget.movie.id.toString()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    MovieModel movie = snapshot.data!;
                    company = movie.companies!;
                    genres = movie.genres!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Tagline(
                            text: "Tagline",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            movie.tagline.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, top: 5),
                          child: Tagline(
                            text: "Production Companies",
                          ),
                        ),
                        SizedBox(
                          height: 140,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: movie.companies!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(5),
                                child: Container(
                                  width: 120,
                                  height: 140,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Image.network(
                                          movie.companies![index].logoPath
                                                      .toString() ==
                                                  ''
                                              ? "https://th.bing.com/th/id/R.6c59570848e71adaf51caccc14d3a090?rik=y9aCVpleviSHeA&riu=http%3a%2f%2fwww.pngmart.com%2ffiles%2f5%2fMitsubishi-Logo-Transparent-Background.png&ehk=r3FoDow95BXh%2f10KFMGxXF30WbC7d4rYLv%2bQOAIMtUw%3d&risl=&pid=ImgRaw&r=0"
                                              : "https://image.tmdb.org/t/p/w500${movie.companies![index].logoPath.toString()}",
                                          width: 100,
                                          height: 120,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, bottom: 4),
                                          child: Text(
                                            movie.companies![index].name
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Tagline(text: "Generes"),
                        Wrap(
                          children: List.generate(
                              movie.genres!.length,
                              (index) => Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Chip(
                                        label: Text(movie.genres![index].name
                                            .toString())),
                                  )),
                        )
                      ],
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Tagline extends StatelessWidget {
  Tagline({
    super.key,
    required this.text,
  });
  String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 19, color: Colors.white),
    );
  }
}
