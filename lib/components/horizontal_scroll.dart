import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:news_app/data/circular_avatar.dart';
import 'package:news_app/pages/search_page.dart';

class Scroll extends StatefulWidget {
  final bool isExpanded;

  const Scroll({
    super.key,
    required this.isExpanded,
  });

  @override
  State<Scroll> createState() => _ScrollState();
}

class _ScrollState extends State<Scroll> {
  List<Map<String, String>> img = Data.img;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenSize = MediaQuery.of(context).size;
        final isSmallScreen = screenSize.width < 600;

        // Calculate sizes based on screen width
        double containerHeight =
            kIsWeb ? (isSmallScreen ? screenSize.height*.23 : screenSize.width * .17) : screenSize.height*.13;

        double itemWidth = kIsWeb
            ? (isSmallScreen
                ? screenSize.width * 0.25
                : screenSize.width * 0.15)
            : screenSize.width * 0.25;

        itemWidth = itemWidth.clamp(
            100.0, 200.0); // Ensure item width is between 100 and 200

        double avatarRadius = itemWidth * 0.3;
        double fontSize = (itemWidth * 0.05).clamp(8.0, 14.0);

        return Container(
          height: containerHeight,
          width: widget.isExpanded
              ? constraints.maxWidth * 0.9
              : kIsWeb
                  ? (isSmallScreen ? screenSize.width * .9 : screenSize.width)
                  : screenSize.width*.9,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: img.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                width: itemWidth,
                alignment: Alignment.center,
                padding: EdgeInsets.all(itemWidth * 0.05),
                margin: EdgeInsets.all(itemWidth * 0.05),
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SearchedScreen(s: img[index]['label']!),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        elevation: kIsWeb ? 10 : 5,
                        shape: const CircleBorder(),
                        child: CircleAvatar(
                          radius: avatarRadius,
                          backgroundColor: Colors.black87,
                          child: CircleAvatar(
                            radius: avatarRadius - 2,
                            backgroundImage: NetworkImage(img[index]['url']!),
                          ),
                        ),
                      ),
                      SizedBox(height: itemWidth * 0.05),
                      Text(
                        img[index]['label']!,
                        style: TextStyle(
                          fontFamily: 'Pop',
                          fontSize: fontSize,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
