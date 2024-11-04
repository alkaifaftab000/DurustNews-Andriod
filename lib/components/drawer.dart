import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget _buildDrawer(bool isExpanded) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    width: isExpanded ? 300 : 80,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200.withOpacity(0.8),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: isExpanded ? 120 : 80,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: isExpanded
                      ? const Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                      : const FaIcon(
                    FontAwesomeIcons.bars,
                    color: Colors.blue,
                    size: 30,
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.account_circle, color: Colors.blue),
                      title: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: isExpanded ? 18 : 0,
                          fontWeight: FontWeight.bold,
                        ),
                        child: const Text('Profile'),
                      ),
                      onTap: () {
                        // Handle the action
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.support_agent_rounded, color: Colors.blue),
                      title: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: isExpanded ? 18 : 0,
                          fontWeight: FontWeight.bold,
                        ),
                        child: const Text('Support'),
                      ),
                      onTap: () {
                        // Handle the action
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.help_sharp, color: Colors.blue),
                      title: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: isExpanded ? 18 : 0,
                          fontWeight: FontWeight.bold,
                        ),
                        child: const Text('Help'),
                      ),
                      onTap: () {
                        // Handle the action
                      },
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
}