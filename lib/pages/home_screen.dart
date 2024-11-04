import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:news_app/components/cat.dart';
import 'package:news_app/components/home_scroll.dart';
import 'package:news_app/components/horizontal_Scroll.dart';
import 'package:news_app/components/search_bar.dart';
import 'package:news_app/components/sidebar.dart';
import 'package:news_app/components/slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isExpanded = false;
  final List<String> categories = [
    'Crime',
    'Sports',
    'Natural Disaster',
    'Conflicts',
  ];

  @override
  void initState() {
    super.initState();
    updateState(isExpanded);
  }

  void updateState(bool expanded) {
    setState(() {
      isExpanded = expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 600;
        final isMediumScreen =
            constraints.maxWidth >= 600 && constraints.maxWidth < 1200;
        final isLargeScreen = constraints.maxWidth >= 1200;
        final isAndroid = !kIsWeb && Platform.isAndroid;

        return Scaffold(
          backgroundColor: Colors.grey.shade50,
          appBar: _buildAppBar(isSmallScreen),
          drawer: isSmallScreen ? _buildDrawer() : null,
          body: Row(
            children: [
              if (!isAndroid && !isSmallScreen)
                SideBarHome(isExpanded: isExpanded),
              if (!isAndroid && !isSmallScreen) const SizedBox(width: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: _buildMainContent(
                      isSmallScreen, isMediumScreen, isLargeScreen),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMainContent(
      bool isSmallScreen, bool isMediumScreen, bool isLargeScreen) {
    return Column(
      children: [
        const SizedBox(height: 30),
        Search(isExpanded: isExpanded),
        _buildSectionTitle('Top Stories'),
        Scroll(isExpanded: isExpanded),
        const SizedBox(height: 10),
        _buildSectionTitle('Top News'),
        const SizedBox(height: 20),
        Slide(isExpanded: isExpanded),
        const SizedBox(height: 10),
        _buildSectionTitle('Categories'),
        const SizedBox(height: 10),
        Cat(isExpanded: isExpanded),
        const SizedBox(height: 20),
        for (int i = 0; i < categories.length; i++) ...[
          HomeScroll(selectedCategory: categories[i]),
          const SizedBox(height: 20),
        ],
        _buildFooter(),
      ],
    );
  }

  PreferredSizeWidget _buildAppBar(bool isSmallScreen) {
    return AppBar(
      toolbarHeight: 70,
      elevation: 30,
      shadowColor: Colors.black,
      backgroundColor: Colors.grey.shade50,
      centerTitle: true,
      title: isSmallScreen
          ? const Text('  Durust News',
              style: TextStyle(fontFamily: 'Funky02', fontSize: 24))
          : _buildFullAppBarTitle(),
    );
  }

  Widget _buildFullAppBarTitle() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FaIcon(FontAwesomeIcons.github, size: 30),
        FaIcon(FontAwesomeIcons.meta, size: 30),
        FaIcon(FontAwesomeIcons.xTwitter, size: 30),
        Expanded(
          child: Center(
            child: Text('Durust News',
                style: TextStyle(fontFamily: 'Funky02', fontSize: 40)),
          ),
        ),
        Icon(Icons.account_circle, size: 40),
        Icon(Icons.support_agent_rounded, size: 40),
        Icon(Icons.help_sharp, size: 40),
      ],
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Menu',
                style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Profile'),
            onTap: () {
              // Handle the action
            },
          ),
          ListTile(
            leading: const Icon(Icons.support_agent_rounded),
            title: const Text('Support'),
            onTap: () {
              // Handle the action
            },
          ),
          ListTile(
            leading: const Icon(Icons.help_sharp),
            title: const Text('Help'),
            onTap: () {
              // Handle the action
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.lightBlueAccent,
        fontSize: 35,
        fontFamily: 'Funky02',
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: 800,
      height: 100,
      alignment: Alignment.bottomCenter,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: const Text(
        'Designed By Alkaif',
        style: TextStyle(fontFamily: 'Funky01', fontSize: 45),
      ),
    );
  }
}
