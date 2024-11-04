import 'package:flutter/material.dart';
import 'package:news_app/pages/search_page.dart';

// ignore: must_be_immutable
class Cat extends StatefulWidget {
  dynamic isExpanded;
  Cat({super.key, required this.isExpanded});

  @override
  State<Cat> createState() => _CatState();
}

class _CatState extends State<Cat> {
  @override
  Widget build(BuildContext context) {
    List<String> img = [
      'National News',
      'International News',
      'Geographical News',
      'Animal News',
      'Ayurvedic News',
      'Medical News',
      'Health Care',
      'Political News',
      'Educational News',
      'Breaking News',
      'State Wise News',
      'Debate'
    ];

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        height: 80,
        width: widget.isExpanded ?1150:1350,
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: img.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                  width: 300,
                  height: 50,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Shadow color
                          spreadRadius: 2, // Spread radius
                          blurRadius: 10, // Blur radius
                          // offset: Offset(0, 5), // Offset in x and y direction
                        ),
                      ]),
                  child: InkWell(
                      onTap: () {   
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>
                        SearchedScreen(s: img[index])
                        ));
                      },
                      child: Text(
                        img[index],
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Pop',
                            fontSize: 20),
                      )));
            }));
  }
}
