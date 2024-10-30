import 'package:chat_box/core/app_constants.dart';
import 'package:chat_box/presentation/pages/calls_page.dart';
import 'package:chat_box/presentation/pages/contacts_page.dart';
import 'package:chat_box/presentation/pages/messages_page.dart';
import 'package:chat_box/presentation/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: [
            MessagesPage(),
            CallsPage(),
            ContactsPage(),
            SettingsPage()
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(5),
        decoration:BoxDecoration(
          color: theme.canvasColor,
          boxShadow: [
            BoxShadow(
              color: theme.primaryColor,
              blurRadius: 1,
              spreadRadius: 0.5
            )
          ]
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          elevation: 0,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: theme.disabledColor,
          selectedItemColor: theme.primaryColor,
          unselectedLabelStyle:
              TextStyle(fontFamily: "Caros"), 
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset("${AppConstants.iconsPath}message.svg",
            color: _getFilteredColor(context,0)),
              label: 'Message',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("${AppConstants.iconsPath}call.svg",color:_getFilteredColor(context,1)),
              label: 'Calls',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("${AppConstants.iconsPath}user.svg",color: _getFilteredColor(context,2)),
              label: 'Contacts',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("${AppConstants.iconsPath}settings.svg",color: _getFilteredColor(context,3)),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
  _getFilteredColor(BuildContext context,int index){
    final theme = Theme.of(context);
    return _currentIndex == index?theme.primaryColor: theme.disabledColor;
  }
}
