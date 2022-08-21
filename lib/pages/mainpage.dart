import 'dart:convert';
import 'package:moviedb/model/datamodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moviedb/pages/search.dart';
import 'package:moviedb/widgets/listview.dart';
import '../model/tvseriesmodel.dart';
import '../widgets/customText.dart';
import '../widgets/listview.dart';
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

String apiKey = "cb75d7027c8f3e832210c1915054e372";
List<MovieModel> movies = [];
List<MovieModel> topRated = [];
List<TvSeriesModel> topRatedTV = [];

class _MainPageState extends State<MainPage> {
  void getData()async
  {
    var response =await http.get(
        Uri.parse("https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=en-US&page=1")
    );
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData['results'].forEach((element)
    {
      MovieModel movieModel =  MovieModel();
      movieModel = MovieModel.fromMap(element);
      movies.add(movieModel);
    });
    setState(() {});
  }
  void getTopRated()async
  {
    var response =await http.get(
        Uri.parse("https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey&language=en-US&page=1")
    );
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData['results'].forEach((element)
    {
      MovieModel movieModel =  MovieModel();
      movieModel = MovieModel.fromMap(element);
      topRated.add(movieModel);

    });
    setState(() {});
  }
  void getTopSeries()async
  {
    var response =await http.get(
        Uri.parse("https://api.themoviedb.org/3/tv/top_rated?api_key=$apiKey&language=en-US&page=1"));
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData['results'].forEach((element)
    {
      TvSeriesModel tvModel =  TvSeriesModel();
      tvModel = TvSeriesModel.fromMap(element);
      topRatedTV.add(tvModel);
    });

    setState(() {});
  }
  @override
  void initState() {
    // TODO: implement initState
    movies = [];
    topRated = [];
    topRatedTV = [];
    getTopSeries();
    getData();
    getTopRated();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding:  EdgeInsets.only(left: 15.0,right: 15),
              child: CustomText('Popular Movies', 25.0, Colors.yellow, true),
            ),
            const SizedBox(height: 20,),
            SizedBox(
              width: size.width,
              height: size.height * 0.34,
              child: ListViewWidget(list: movies),
            ),
            const SizedBox(height: 15,),
            const Padding(
              padding:  EdgeInsets.only(left: 15.0),
              child: CustomText('Top Rated Movies', 25.0, Colors.yellow, true),
            ),
            SizedBox(
              width: size.width,
              height: size.height * 0.34,
              child: ListViewWidget(list: topRated),
            ),
            const SizedBox(height: 15,),
            const Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: CustomText('Top Rated TV shows', 25.0, Colors.yellow, true),
            ),
            SizedBox(
              width: size.width,
              height: size.height * 0.34,
              child: ListViewWidget(list: topRatedTV,isTV: true,),
            ),

          ],
        ),
      ),

    );
  }
}
