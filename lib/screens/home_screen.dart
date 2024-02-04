import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/screens/movie_view.dart';
import 'package:movie_app/screens/search_result.dart';
import 'package:movie_app/services/api_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    ApiServices service = ApiServices();
    TextEditingController queryController =
        TextEditingController(); // make object for catch the text field input
    List<MovieModel>? movies = [];
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 30,
                    ),
                    Text(
                      "TMDB Movies",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.favorite,
                      color: Color.fromRGBO(255, 255, 255, 1),
                      size: 30,
                    ),
                  ],
                ),
              ),
              Container(
                width: screenSize.width * 0.85,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller:
                            queryController, // used query controller object
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: "Search"),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchResult(
                                query: queryController.text,
                              ),
                            ));
                      },
                      child: const Icon(
                        Icons.search,
                        size: 35,
                        weight: 80,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder(  // future builder
                future: service.getPopularMovies(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    movies = snapshot.data;
                    return CarouselSlider(
                      options: CarouselOptions(
                        height: 160.0,
                        autoPlay: true,
                      ),
                      items: movies!.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return InkWell(
                              onTap: () {},
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        colorFilter: ColorFilter.mode(
                                            Colors.black.withOpacity(0.3),
                                            BlendMode.darken),
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            i.backdropPath.toString())),
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.grey.shade500),
                                child: Stack(children: [
                                  Positioned(
                                    bottom: 5,
                                    left: 10,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // Start of the rate and star container
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  i.voteAverage.toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        //End of the container
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 15.0),
                                          child: Text(i.title.toString(),
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 3,
                                    right: 10,
                                    child: Container(
                                      width: 100,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.orange.withOpacity(0.8),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: const Center(
                                        child: Text(
                                          "Watch Now",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                  )
                                ]),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    );
                  } else {
                    return const CupertinoActivityIndicator(
                      color: Colors.white,
                    );
                  }
                },
              ),
              // Emd of the auto horizontal axis Popular movies
              const Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Top Rated Movies",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),

              FutureBuilder(
                future: service.getTopratedMovies(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<MovieModel> topRatedMovies = snapshot.data!;
                    return SizedBox(
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: topRatedMovies.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(4),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MovieView(
                                          movie: topRatedMovies[index]),
                                    ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.3),
                                          BlendMode.darken),
                                      fit: BoxFit.cover,
                                      image: NetworkImage(topRatedMovies[index]
                                          .posterPath
                                          .toString())),
                                  color: Colors.grey.shade700,
                                ),
                                width: 120,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 5,
                                      right: 2,
                                      child: Hero(
                                        tag: "${topRatedMovies[index].id}hero",
                                        child: Container(
                                          // Start of the rate and star container
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  topRatedMovies[
                                                          index] // access topratedmovies list Index
                                                      .voteAverage
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                  size: 16,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 5,
                                      left: 3,
                                      right: 1,
                                      child: Text(
                                        topRatedMovies[index].title.toString(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
              const Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Upcoming Movies",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              // upcomming movies start

              FutureBuilder(
                future: service.getUpcommingMovies(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<MovieModel> upcomingMovies = snapshot.data!;
                    return SizedBox(
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: upcomingMovies.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(4),
                            child: InkWell(
                              child: Container(
                                // upcomming movies containers
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.3),
                                          BlendMode.darken),
                                      fit: BoxFit.cover,
                                      image: NetworkImage(upcomingMovies[index]
                                          .posterPath
                                          .toString())),
                                  color: Colors.grey.shade700,
                                ),
                                width: 120,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 5,
                                      right: 2,
                                      child: Hero(
                                        tag: "${upcomingMovies[index].id}hero",
                                        child: Container(
                                          // Start of the rate and star container
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  upcomingMovies[
                                                          index] // access to upcomming movies list Index
                                                      .voteAverage
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                  size: 16,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 5,
                                      left: 3,
                                      right: 1,
                                      child: Text(
                                        upcomingMovies[index].title.toString(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MovieView(
                                        movie: upcomingMovies[index],
                                      ),
                                    ));
                              },
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const CircularProgressIndicator();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
