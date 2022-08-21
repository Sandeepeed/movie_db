import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moviedb/description_page.dart';
import 'package:moviedb/model/datamodel.dart';
import 'package:moviedb/widgets/listview.dart';

import '../widgets/customText.dart';
class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}
class _SearchState extends State<Search> {
  int index = 0;
  List<MovieModel> result = [];
  String apiKey = "cb75d7027c8f3e832210c1915054e372";
  String avengers = "Avengers";
  final TextEditingController _controller = TextEditingController();
  void searchMovie(text)async{
    print(text);
    var response = await http.get(
        Uri.parse("https://api.themoviedb.org/3/search/movie?query=\"$text\"&api_key=cb75d7027c8f3e832210c1915054e372&language=en-US&page=1&include_adult=false")
    );

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData['results'].forEach((element)
    {
      MovieModel movieModel =  MovieModel();
      movieModel = MovieModel.fromMap(element);
      setState(() {
        result.add(movieModel);
      });
      print(element);
    });
    setState(() {});
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        foregroundColor: Colors.yellow,
        elevation: 0,
        backgroundColor: Colors.black,
        toolbarHeight: 80.0,
        title: Center(
          child: SizedBox(
            width: size.width * 0.9,
            child: TextField(
              onSubmitted: (text){
                setState(() {
                  result = [];
                  searchMovie(text);
                });

              },
              controller: _controller,
              style: const TextStyle(
                  color: Colors.yellow
              ),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.yellow),
                    borderRadius: BorderRadius.circular(15.0)
                ),
                suffixIcon: GestureDetector(
                    onTap: (){
                      setState(() {
                        result = [];
                        searchMovie(_controller.text);
                      });

                    },
                    child: const Icon(Icons.search,color: Colors.yellow,)),
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.yellow,style: BorderStyle.solid,width: 1.0),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                hintStyle: const TextStyle(
                  color: Colors.yellow,
                ),
                hintText: "Search Movies",
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Container(
          color: Colors.black,
          height: size.height,
          width: size.width,
          child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: result.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                mainAxisSpacing: 14.0,
                crossAxisSpacing: 0,
                mainAxisExtent: 320,
              ), itemBuilder: (_,index){
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => DescriptionPage(id: result[index].id!, title: result[index].title!, imgUrl: result[index].imgUrl!,
                    description: result[index].description!, rating: result[index].rating.toString())));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 10,),
                  result[index].imgUrl == null ? Container(
                    width: size.width * 0.45,
                    height: size.height * 0.35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Center(child: CustomText("Image Source Not Available", 15.0, Colors.yellow, true)),
                  ):
                  Container(
                    width: size.width * 0.45,
                    height: size.height * 0.35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            "https://image.tmdb.org/t/p/w500" + result[index].imgUrl!,
                          ),
                        )
                    ),
                  ) ,
                  Center(child: CustomText(result[index].title!, 13.0 , Colors.yellow, false))
                ],
              ),
            );
          })
      ),
    );
  }
}
//https://api.themoviedb.org/3/search/movie?query="avengers"&api_key=cb75d7027c8f3e832210c1915054e372&language=en-US&page=1&include_adult=false