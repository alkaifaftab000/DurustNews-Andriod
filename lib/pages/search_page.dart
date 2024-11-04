import 'package:flutter/material.dart';
import 'package:news_app/components/search_scroll.dart';
import 'package:news_app/components/search_slide.dart';
import 'package:news_app/controller/api_controller.dart';

class SearchedScreen extends StatefulWidget {
  final String s;

  const SearchedScreen({super.key, required this.s});

  @override
  State<SearchedScreen> createState() => _SearchedScreenState();
}

class _SearchedScreenState extends State<SearchedScreen> {
  bool isLoading = true;
  final ApiController apiController = ApiController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      debugPrint('Fetching data for: ${widget.s}');
      await apiController.getApi(widget.s);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 30,
        shadowColor: Colors.black,
        toolbarHeight: 60, // Responsive toolbar height
        title: Text(
          'Showing Results : ${widget.s}',
          style: const TextStyle(
            fontSize: 24, // Adjusted font size for readability
            fontFamily: 'Funky02',
          ),
        ),
      ),
      body:SingleChildScrollView(
        child: Column(
              children: [
                const SizedBox(height: 40),
                Text(
                  'Top News About ${widget.s}',
                  style: const TextStyle(
                    color: Colors.lightBlueAccent,
                    fontSize: 22, // Adjusted font size for readability
                    fontFamily: 'Funky02',
                  ),
                ),
                const SizedBox(height: 20),
                if (isLoading)
                  const Center(
                    child: CircularProgressIndicator(color: Colors.lightBlueAccent),
                  )
                else ...[
                  SearchSlide(searchItem: widget.s),
                  const SizedBox(height: 20),
                  SearchedScroll(query: widget.s),
                ],

                const SizedBox(height: 20), // Added spacing for bottom text
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8, // Responsive width
                    height: 60, // Fixed height for consistency
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: Colors.white, // Background color for visibility
                    ),
                    child: const Text(
                      'Designed By Alkaif',
                      style: TextStyle(
                        fontFamily: 'Funky01',
                        fontSize: 18, // Adjusted font size for readability
                      ),
                    ),
                  ),
                ),
              ],
            ),
      ),
    );
  }
}
