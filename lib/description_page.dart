import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:moviedb/model/castmodel.dart';
import 'package:moviedb/widgets/customText.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DescriptionPage extends StatefulWidget {
  final int id;
  final String title;
  final isTv;
  final String imgUrl;
  final String description;
  final String rating;
  const DescriptionPage({Key? key, required this.id, required this.title, required this.imgUrl, required this.description, required this.rating, this.isTv}) : super(key: key);

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

String apiKey = "cb75d7027c8f3e832210c1915054e372";
List<CastModel> cast = [];
class _DescriptionPageState extends State<DescriptionPage> {

  void getCast()async{
    final int id = widget.id;
    var response = await http.get(
        Uri.parse("https://api.themoviedb.org/3/movie/$id/credits?api_key=$apiKey&language=en-US")
    );
    Map<String,dynamic> jsonData = jsonDecode(response.body);
    jsonData['cast'].forEach((element) {
      CastModel castModel = CastModel();
      castModel = CastModel.fromMap(element);
      cast.add(castModel);
    });
    setState(() {});
  }
  @override
  void initState() {
    // TODO: implement initState

    getCast();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: (){
            setState(() {
              cast = [];
            });
            Navigator.pop(context);
          },
          child: Container(
              margin: const EdgeInsets.only(left: 10,top: 15),
              width: size.width * 0.02,
              height: size.height * 0.02,
              decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle
              ),
              child: const Center(child: Icon(Icons.arrow_back,color: Colors.yellow,size: 30,))),
        ),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      body: Scrollbar(
        thumbVisibility: true,
        thickness: 2,

        radius: const Radius.circular(10.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width,
                height: size.height * 0.9,
                child: Stack(
                  children: [
                    Container(
                      height: size.height * 0.8,
                      width: size.width,
                      decoration: BoxDecoration(
                          color: Colors.yellow,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                "https://image.tmdb.org/t/p/w500" + widget.imgUrl,
                              )
                          )
                      ),
                    ),
                    Positioned(
                      top: 420,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(20.0),topLeft: Radius.circular(20.0))
                        ),
                        width: size.width,
                        height: size.height * 0.9,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(widget.title, 24.0, Colors.yellowAccent, true),
                                  CircularPercentIndicator(
                                    percent: double.parse(widget.rating) / 10,
                                    progressColor: Colors.yellowAccent,
                                    backgroundColor: Colors.transparent,
                                    radius: 25.0,
                                    center: CustomText((double.parse(widget.rating)* 10).toString().substring(0,2) + "%", 15.0, Colors.yellow, false),),
                                ],
                              ),
                              const CustomText('Description: ', 18.0, Colors.yellow, true),
                              const SizedBox(height: 5,),
                              Text(widget.description,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.encodeSansCondensed(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15.0,top: 15),
                child: CustomText('Cast:', 18.0, Colors.yellow, true),
              ),
              SizedBox(
                height: size.height * 0.2,
                width: size.width,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: cast.length > 10?10: cast.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_,index)
                    {
                      return Padding(
                        padding: const EdgeInsets.only(left: 10.0,right: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            cast[index].profilePath != null ? Container(
                              width: size.width * 0.2,
                              height: size.height *0.15,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage("https://image.tmdb.org/t/p/w500" + cast[index].profilePath!),
                                  )
                              ),
                            ) : Container(
                                width: size.width * 0.2,
                                height: size.height *0.15,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                )
                            ),
                            CustomText(cast[index].actorName!, 14.0, Colors.yellow, false)
                          ],
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
