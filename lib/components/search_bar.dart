import 'dart:math';
import 'package:flutter/material.dart';
import 'package:news_app/pages/search_page.dart';

class Search extends StatefulWidget {
  final bool isExpanded;

  const Search({
    super.key,
    required this.isExpanded,
  });

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _suggestions = [
    'Sports',
    'Politics',
    'International',
    'National',
    'Animal'
  ];

  String get _randomSuggestion {
    final random = Random();
    return _suggestions[random.nextInt(_suggestions.length)];
  }

  @override
  Widget build(BuildContext context) {
    final ss = MediaQuery.of(context).size;
    final isSmallScreen = ss.width < 600;
    return LayoutBuilder(
      builder: (context, constraints) {
        double containerWidth = widget.isExpanded ? 1150 : 1350;
        if (constraints.maxWidth < containerWidth) {
          containerWidth = constraints.maxWidth *
              0.9; // Use 90% of the available width for smaller screens
        }

        return Container(
          alignment: Alignment.center,
          width: containerWidth,
          height: isSmallScreen ? 70 : 80,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.lightBlue.shade50,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  final searchText = _controller.text.trim();
                  if (searchText.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchedScreen(s: searchText)),
                    );
                  }
                },
                child: const Icon(Icons.search, size: 30),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _controller,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search News About $_randomSuggestion',
                    hintStyle:
                        const TextStyle(fontFamily: 'Poppins', fontSize: 25),
                  ),
                  style: const TextStyle(
                      color: Colors.black, fontFamily: 'Pop', fontSize: 25),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
