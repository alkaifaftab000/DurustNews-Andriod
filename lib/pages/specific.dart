import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/model.dart';

class DetailedNewsScreen extends StatelessWidget {
  final NewsModel news;

  const DetailedNewsScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    final ss = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton.icon(
        onPressed: () => _launchURL(news.newsUrl),
        icon: const Icon(Icons.launch,color: Colors.white),
        label: const Text("Read Full Article",style: TextStyle(color: Colors.white,fontFamily: 'Pop'),),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.cyan,
          padding:const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          minimumSize: const Size(250, 70),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
title: TextButton.icon(onPressed: (){}, label:Text(news.sourceName,
  style: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 16,
      fontFamily: 'Pop'
  ),
),icon:const Icon(Icons.source_rounded,color: Colors.white),
  style: TextButton.styleFrom(backgroundColor: Colors.black38,
    minimumSize: const Size(230, 60),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
  ),
),
              background: Image.network(
                news.newsImg,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[300],
                  child: Icon(Icons.error, size: 50, color: Colors.grey[600]),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: ss.height*2,
              width: ss.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.lightBlue[50]!, Colors.white],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      news.newsHead,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[800],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.person, size: 18, color: Colors.blueGrey),
                        const SizedBox(width: 8),
                        Text(
                          news.author != "UNKNOWN" ? news.author : "Unknown Author",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blueGrey[600],
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.calendar_today, size: 18, color: Colors.blueGrey),

                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      news.newsDes,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blueGrey[700],
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      news.content,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueGrey[700],
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



  void _launchURL(String url) async {
    await EasyLauncher.url(url: url).onError((error,stackTrace){
      debugPrint('Error Occurred in Launching ${error.toString()}');
    });

  }
}