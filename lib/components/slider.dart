import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart' as cp;
import 'package:flutter/material.dart';
import 'package:news_app/controller/api_controller.dart';
import 'package:news_app/pages/specific.dart';

class Slide extends StatefulWidget {
  final bool isExpanded;

  const Slide({super.key, required this.isExpanded});

  @override
  State<Slide> createState() => _SlideState();
}

class _SlideState extends State<Slide> {
  late String selectedCategory;
  final List<String> categories = [
    'Sport',
    'Research',
    'Scarcity',
    'Scam',
    'Crime',
    'Wars',
    'Natural Disaster',
    'Stock',
    'Conflict'
  ];

  final ApiController apiController = ApiController();
  final Random random = Random();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      selectedCategory = categories[random.nextInt(categories.length)];
      debugPrint('Selected category: $selectedCategory');
      apiController.clearNewsList();
      await apiController.getApi('India');
      debugPrint('News list length: ${apiController.newsList.length}');
    } catch (e) {
      debugPrint('Error fetching data: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWeb = constraints.maxWidth > 600;
        final fontSize = isWeb ? 16.0 : 14.0;
        final cardHeight = isWeb ? 500.0 : 300.0;

        if (isLoading) {
          return const Center(
              child: CircularProgressIndicator(color: Colors.lightBlueAccent));
        }

        return cp.CarouselSlider(
          items: apiController.newsList.map((item) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailedNewsScreen(news: item)));
              },
              child: Card(
                margin: EdgeInsets.all(constraints.maxWidth * 0.02),
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          item.newsImg,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.7),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        right: 16,
                        bottom: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              item.newsHead,
                              style: TextStyle(
                                fontFamily: 'Pop',
                                fontSize: fontSize * 1.5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Author: ${item.author}',
                                    style: TextStyle(
                                      fontFamily: 'Pop',
                                      fontSize: fontSize,
                                      color: Colors.white70,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Source: ${item.sourceName}',
                                    style: TextStyle(
                                      fontFamily: 'Pop',
                                      fontSize: fontSize,
                                      color: Colors.white70,
                                    ),
                                    textAlign: TextAlign.right,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
          options: cp.CarouselOptions(
            height: cardHeight,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: isWeb ? 0.8 : 0.9,
          ),
        );
      },
    );
  }
}
