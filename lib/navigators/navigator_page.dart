import 'package:chatting_app_clone/pages/chat_page.dart';
import 'package:chatting_app_clone/pages/login_page.dart';
import 'package:chatting_app_clone/pages/profile_page.dart';
import 'package:flutter/material.dart';

import '../common.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({Key? key}) : super(key: key);

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

int _currentIndex = 0;

List<Widget> get _bodies => <Widget>[
  const ProfilePage(),
  const ChatPage(),
];

final List<BottomNavigationBarItem> _items = <BottomNavigationBarItem>[
  const BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: '프로필'),
  const BottomNavigationBarItem(icon: Icon(Icons.list_alt_outlined), label: '채팅',),
];

class _NavigatorPageState extends State<NavigatorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodies[_currentIndex],
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  Widget bottomNavigationBar() => BottomNavigationBar(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: CustomTextStyle.w600(context, scale: 0.012, height: 2.0),
      unselectedLabelStyle: CustomTextStyle.w600(context, scale: 0.012, height: 2.0),
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.blue,
      currentIndex: _currentIndex,
      onTap: (int index) => setState(() {
        _currentIndex = index;
      }),
      items: _items
  );
}

