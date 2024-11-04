import 'package:flutter/material.dart';

class SideBarHome extends StatefulWidget {
  const SideBarHome({super.key, required bool isExpanded});

  @override
  State<SideBarHome> createState() => _SideBarHomeState();
}

class _SideBarHomeState extends State<SideBarHome> {
  bool _isExpanded = false;

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrowScreen = constraints.maxWidth < 600;
        final sidebarWidth =
            isNarrowScreen ? 80.0 : (_isExpanded ? 250.0 : 80.0);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: sidebarWidth,
          height: constraints.maxHeight,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.lightBlueAccent, Colors.lightBlueAccent.shade700],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  children: [
                    _buildNavItem(Icons.home_rounded, 'Home'),
                    _buildNavItem(Icons.featured_play_list_outlined, 'Feed'),
                    _buildNavItem(Icons.settings, 'Settings'),
                    _buildNavItem(Icons.person, 'Account'),
                  ],
                ),
              ),
              _buildNavItem(Icons.logout, 'Logout'),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNavItem(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: _toggleExpansion,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: _isExpanded ? 20 : 0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: _isExpanded
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 30),
              if (_isExpanded) ...[
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
