import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomTabPage extends StatefulWidget {
  const CustomTabPage({super.key});

  @override
  State<CustomTabPage> createState() => _CustomTabPageState();
}

class _CustomTabPageState extends State<CustomTabPage> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(title: Text("My Custom View")),
          body: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _index = 1;
                    });
                  },
                  icon: Icon(Icons.home),
                  label: Text("Home"),
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _index = 2;
                      });
                    },
                    icon: Icon(Icons.shopify),
                    label: Text("My Orders")),
                ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _index = 3;
                      });
                    },
                    icon: Icon(Icons.account_box_rounded),
                    label: Text("Profile")),
              ],
            ),
            // Expanded(
            //     child: Column(
            //   children: [
            //     Visibility(
            //         visible: _index == 1,
            //         child: Container(
            //           child: Center(
            //             child: Text(
            //               "Button 1",
            //               style: TextStyle(fontSize: 30),
            //             ),
            //           ),
            //         )),
            //     Visibility(
            //         visible: _index == 2,
            //         child: Container(
            //             child: Center(
            //           child: Text(
            //             "Button 2",
            //             style: TextStyle(fontSize: 30),
            //           ),
            //         ))),
            //     Visibility(
            //         visible: _index == 3,
            //         child: Container(
            //             child: Center(
            //           child: Text(
            //             "Button 3",
            //             style: TextStyle(fontSize: 30),
            //           ),
            //         ))),
            //   ],
            // ))

            Expanded(
                child: IndexedStack(
              index: _index,
              children: [
                Container(),
                _widgetTab1(),
                _widgetTab2(),
                _widgetTab3()
              ],
            ))
          ]),
        ),
        onWillPop: _onWillPop);
  }

  Future<bool> _onWillPop() async {
    if (_index > 1) {
      setState(() {
        _index -= 1;
      });
      return false;
    }
    return true;
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
}


/** Option 1
 * Define 3 Widgets.
 * Put them on single Column
 * Add Visiblity widgets based on index.
 * Define setState inside the 3 buttons
 */



 