import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class BottomTabsPage extends StatefulWidget {
  const BottomTabsPage({super.key});

  @override
  State<BottomTabsPage> createState() => _BottomTabsPageState();
}

class _BottomTabsPageState extends State<BottomTabsPage> {
  int _index = 0;
  List<Widget> pages = [
    _widgetTab1(),
    _widgetTab2(),
    _widgetTab3(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bottom Tabs"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopify), label: "My Orders"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box_rounded), label: "Profile"),
        ],
        currentIndex: _index,
        onTap: (value) {
          setState(() {
            _index = value;
          });
        },
      ),
      body: Container(
        child: pages[_index],
      ),
    );
  }
}

Container _widgetTab3() {
  return Container(
      child: Center(
    child: Text(
      "Button 3",
      style: TextStyle(fontSize: 30),
    ),
  ));
}

Container _widgetTab2() {
  return Container(
      child: Center(
    child: Text(
      "Button 2",
      style: TextStyle(fontSize: 30),
    ),
  ));
}

Container _widgetTab1() {
  return Container(
    child: Center(
      child: Text(
        "Button 1",
        style: TextStyle(fontSize: 30),
      ),
    ),
  );
}
