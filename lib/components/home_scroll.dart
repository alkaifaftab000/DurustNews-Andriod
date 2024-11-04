import 'dart:math';
import 'package:flutter/material.dart';
import 'package:news_app/controller/api_controller.dart';
import 'package:news_app/pages/specific.dart';

class HomeScroll extends StatefulWidget {
  final String selectedCategory;
  const HomeScroll({super.key, required this.selectedCategory});

  @override
  State<HomeScroll> createState() => _HomeScrollState();
}

class _HomeScrollState extends State<HomeScroll> {
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
      apiController.clearNewsList();
      await apiController.getApi(widget.selectedCategory);
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
        final cardWidth = isWeb ? 400.0 : constraints.maxWidth * 0.8;
        final cardHeight = isWeb ? 500.0 : 400.0;

        if (isLoading) {
          return const Center(
              child: CircularProgressIndicator(color: Colors.lightBlueAccent));
        }

        return Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: isWeb ? 20 : 10),
              child: Text(
                widget.selectedCategory,
                style: TextStyle(
                  fontSize: isWeb ? 40 : 30,
                  fontFamily: 'Funky02',
                  color: Colors.lightBlueAccent,
                ),
              ),
            ),
            SizedBox(
              height: 500,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: apiController.newsList.length,
                itemBuilder: (context, index) {
                  final newsItem = apiController.newsList[index];
                  return Padding(
                    padding: EdgeInsets.all(isWeb ? 20 : 10),
                    child: InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailedNewsScreen(news: newsItem))),
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          width: cardWidth,
                          height: cardHeight,
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
                                  newsItem.newsImg,
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
                                      newsItem.newsHead,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Author: ${newsItem.author}',
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
                                            'Source: ${newsItem.sourceName}',
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
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
