import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moviedb/widgets/customText.dart';
import 'package:moviedb/widgets/customText.dart';

import 'homepage.dart';


class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  opacity: 0.5,
                  fit: BoxFit.cover,
                  image: AssetImage('assets/background2.jpg')
              )
          ),
        ),
        Positioned(
            child: Container(
              width: size.width,
              height: size.height * 0.2,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [Colors.black87,Colors.black38],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.1,0.8]
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  CustomText("TheMovieDB", 28, Colors.amber, true),
                  CustomText('Your home for Movie Wishlisting', 18, Colors.amber, false)
                ],
              ),
            )
        ),
        Positioned(
            bottom: 1,
            child: Container(
              width: size.width,
              height: size.height * 0.2,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [Colors.black87,Colors.black38],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.1,0.8]
                ),
              ),
              child: const Align(
                  alignment: Alignment.topCenter,
                  child:  CustomText('Sign In Using Google Account', 20, Colors.amber, false)),
            )),
        Positioned(
          left: 0,
          right: 0,
          bottom: 10,
          child: SizedBox(
            height: size.height * 0.08,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0))
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
              }, icon: const FaIcon(
                FontAwesomeIcons.google
            ), label: const Text("Sign in"),),
          ),
        )
      ],
    );
  }
}
