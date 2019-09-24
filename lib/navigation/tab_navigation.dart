import 'package:flutter/material.dart';
import 'package:flutter_trip/pages/home_page.dart';
import 'package:flutter_trip/pages/my_page.dart';
import 'package:flutter_trip/pages/search_page.dart';
import 'package:flutter_trip/pages/travel_page.dart';

///首页导航
class TabNavigation extends StatefulWidget {
  @override
  _TabNavigationState createState() => _TabNavigationState();
}

class _TabNavigationState extends State<TabNavigation> {
  final PageController _controller = PageController();
  final Color _default_color = Colors.grey;
  final Color _active_color = Colors.blue;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: <Widget>[
          HomePage(),
          SearchPage(),
          TravelPage(),
          MyPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            _controller.jumpToPage(index);
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _default_color,
              ),
              activeIcon: Icon(
                Icons.home,
                color: _active_color,
              ),
              title: Text(
                '首页',
                style: TextStyle(
                    color: _currentIndex == 0 ? _active_color : _default_color),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: _default_color,
              ),
              activeIcon: Icon(
                Icons.search,
                color: _active_color,
              ),
              title: Text('搜索',
                  style: TextStyle(
                      color:
                          _currentIndex == 1 ? _active_color : _default_color)),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.camera_alt,
                color: _default_color,
              ),
              activeIcon: Icon(
                Icons.camera_alt,
                color: _active_color,
              ),
              title: Text('旅拍',
                  style: TextStyle(
                      color:
                          _currentIndex == 2 ? _active_color : _default_color)),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.people,
                color: _default_color,
              ),
              activeIcon: Icon(
                Icons.people,
                color: _active_color,
              ),
              title: Text('我的',
                  style: TextStyle(
                      color:
                          _currentIndex == 3 ? _active_color : _default_color)),
            ),
          ]),
    );
  }

}
