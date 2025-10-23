// lib/web/components/sidebar.dart
import 'package:flutter/material.dart';
import 'package:flutter_game_app/web/components/header.dart';
import 'package:flutter_game_app/web/views/chat_bot_view.dart';
import 'package:flutter_game_app/web/views/home_view.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250.0,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 50,
            child: const DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(color: Color.fromARGB(255, 44, 4, 4)),
              child: Center(
                child: Text(
                  'Shadow Of Mind',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.white),
            title: const Text('Home', style: TextStyle(color: Colors.white)),
            selected: _selectedIndex == 0,
            onTap: () {
              _onItemTapped(0);
              Navigator.pop(context);
              MaterialPageRoute<void>(
                builder: (context) => Header(title: 'Home'),
              );
              Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (context) => const HomeView()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text(
              'Wikipedia',
              style: TextStyle(color: Colors.white),
            ),
            selected: _selectedIndex == 1,
            onTap: () {
              _onItemTapped(1);
              Navigator.pop(context);
              MaterialPageRoute<void>(
                builder: (context) => Header(title: 'Wikipedia'),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.download),
            title: const Text('Download Page'),
            selected: _selectedIndex == 2,
            onTap: () {
              _onItemTapped(2);
              Navigator.pop(context);
              MaterialPageRoute<void>(
                builder: (context) => Header(title: 'Download'),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.assistant),
            title: const Text('Chat Bot'),
            selected: _selectedIndex == 3,
            onTap: () {
              _onItemTapped(3);
              Navigator.pop(context);
              MaterialPageRoute<void>(
                builder: (context) => Header(title: 'ChatBot'),
              );
              Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (context) => const ChatBot()),
              );
            },
          ),
        ],
      ),
    );
  }
}
