import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app/controller/api_controller.dart';
import 'package:news_app/pages/specific.dart';

class SearchedScroll extends StatefulWidget {
  final String query;
  const SearchedScroll({super.key, required this.query});
  @override
  State<SearchedScroll> createState() => _SearchedScrollState();
}

class _SearchedScrollState extends State<SearchedScroll> {
  final ApiController ac = ApiController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    ac.clearNewsList();
    await ac.getApi(widget.query);
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : NewsGridView(newsList: ac.newsList);
  }
}

class NewsGridView extends StatelessWidget {
  final List<dynamic> newsList;

  const NewsGridView({super.key, required this.newsList});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = (constraints.maxWidth ~/ 300).clamp(1, 3);
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 16 / 9,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: newsList.length,
          shrinkWrap: true, // Add this line
          physics: const NeverScrollableScrollPhysics(), // Add this line
          padding: const EdgeInsets.all(10),
          itemBuilder: (context, index) {
            return NewsCard(news: newsList[index]);
          },
        );
      },
    );
  }
}

// NewsCard class remains unchanged

class NewsCard extends StatelessWidget {
  final dynamic news;

  const NewsCard({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    const fontSize = kIsWeb ? 16.0 : 14.0;
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () async {
          Navigator.push(context,MaterialPageRoute(builder: (context)=> DetailedNewsScreen(news: news)));
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                news.newsImg,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.error),
                  );
                },
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                  ),
                ),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      news.newsHead,
                      style:const TextStyle(
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
                            'Author: ${news.author}',
                            style: const TextStyle(
                              fontFamily: 'Pop',
                              fontSize: fontSize,
                              color: Colors.white70,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Source: ${news.sourceName}',
                            style: const TextStyle(
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
            ),
          ],
        ),
      ),
    );
  }
}

