import 'package:flutter/material.dart';
import 'package:moviedb/description_page.dart';
import '../model/datamodel.dart';
import 'customText.dart';

class ListViewWidget extends StatefulWidget {
  final List list;
  final isTV;
  const ListViewWidget({Key? key, required this.list, this.isTV}) : super(key: key);

  @override
  State<ListViewWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ListView.builder(

        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: widget.list.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_,index){
          return Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: GestureDetector(
              onTap: (){
                widget.isTV == true? Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    DescriptionPage(id: widget.list[index].id!,
                        title: widget.list[index].name,
                        imgUrl: widget.list[index].imgUrl,
                        description: widget.list[index].description, rating: widget.list[index].rating.toString()))):
                Navigator.push(context, MaterialPageRoute(builder: (context) => DescriptionPage(
                    id: widget.list[index].id,
                    title: widget.list[index].title,
                    imgUrl: widget.list[index].imgUrl,
                    description: widget.list[index].description,
                    rating: widget.list[index].rating.toString())));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  widget.list[index].imgUrl == null ?
                  Container(
                    width: size.width * 0.35,
                    height: size.height * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: const CustomText("Image Source Not available", 15.0, Colors.yellow, true),
                  ): Container(
                    width: size.width * 0.35,
                    height: size.height * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            "https://image.tmdb.org/t/p/w500" + widget.list[index].imgUrl,
                          ),
                        )
                    ),
                  ) ,

                  Center(child: CustomText(widget.isTV == true? widget.list[index].name : widget.list[index].title, 15.0 , Colors.yellow, false))
                ],
              ),
            ),
          );
        });
  }
}
