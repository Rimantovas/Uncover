import 'package:flutter/material.dart';
import 'package:uncoverapp/Screens/SearchPage.dart';
import 'package:uncoverapp/Screens/RelatedPage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final _search = TextEditingController();
  List<Widget> _pages = [RelatedPage(), SearchPage()];

  @override
  Widget build(BuildContext context) {
    DateTime? currentBackPressTime;

    return WillPopScope(
      onWillPop: () {
        DateTime now = DateTime.now();
        if (currentBackPressTime == null ||
            now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
          currentBackPressTime = now;
          Fluttertoast.showToast(msg: "Press again to quit");
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
              currentIndex: _currentIndex,
              onTap: (value) {
                setState(() {
                  _currentIndex = value;
                });
              },
              items: [Icons.home, Icons.search]
                  .asMap()
                  .map((key, value) => MapEntry(
                      key,
                      BottomNavigationBarItem(
                          label: "",
                          icon: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 6, horizontal: 16),
                            decoration: BoxDecoration(
                              color: _currentIndex == key
                                  ? Theme.of(context).primaryColor
                                  : Colors.transparent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                            child: Icon(value),
                          ))))
                  .values
                  .toList(),
            ),
            body: _pages[_currentIndex]),
      ),
    );
  }

  Widget searchBar() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: 40,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _search,
              onEditingComplete: () {
                //getLyricals(_search.text);
                FocusManager.instance.primaryFocus?.unfocus();
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                prefixIcon: Icon(
                  Icons.search,
                ),
                hintText: "Search lyrics",
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
              ),
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
