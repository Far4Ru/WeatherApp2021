import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'about.dart';
import 'favourite.dart';
import 'search.dart';
import 'settings.dart';
import 'week.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _bottomPanelHeight = 300;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String title = "Город";
  void _changeBottomPanelState() {
    setState(() {
      _bottomPanelHeight = _bottomPanelHeight == 300 ? 550 : 300;
    });
  } // Bottom Panel
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.lightBlue,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const Padding(padding: EdgeInsets.only(top: 30, left: 20, bottom: 20),
                child: Text(
                  'Weather App',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 24,
                    fontFamily: 'Manrope',
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Настройки'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=> const SettingsPage(),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.favorite_border),
                title: const Text('Избранное'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=> const FavouritePage(),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.account_circle),
                title: const Text('О приложении'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=> const AboutPage(),
                  ),
                ),
              ),
            ],
          ),
        ), // Left Panel
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/image0.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 30.0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          title,
                          style: const TextStyle(
                              fontSize: 32.0,
                              fontFamily: 'Manrope',
                              color: Colors.white
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Text(
                          '10˚c',
                          style: TextStyle(
                              fontSize: 72.0,
                              fontFamily: 'Manrope',
                              color: Colors.white
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Text(
                          '23 сент. 2021',
                          style: TextStyle(
                              fontSize: 22.0,
                              fontFamily: 'Manrope',
                              color: Colors.white
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 42, left: 20),
              child: NeumorphicButton(
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                child: const Icon(
                  Icons.dehaze,
                  color: Colors.white,
                ),
                style: const NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.circle(),
                  depth: 1,
                  color: Color(0xFF0256FF),
                  lightSource: LightSource.top,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top:42, left: 340),
              child: NeumorphicButton(
                onPressed: () => _toSearchPage(context),
                child: const Icon(
                  Icons.add_circle_outline,
                  color: Colors.white,
                ),
                style: const NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.circle(),
                  depth: 1,
                  color: Color(0xFF0256FF),
                  lightSource: LightSource.top,
                ),
              ),
            ),
            Positioned(
                bottom: 00,
                width: MediaQuery.of(context).size.width,
                height: _bottomPanelHeight,
                child: Container (
                    decoration: const BoxDecoration(
                      color: Color(0xFFE2EBFF),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          bottomRight: Radius.circular(0.0),
                          topLeft: Radius.circular(20.0),
                          bottomLeft: Radius.circular(0.0)),
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          GestureDetector(
                            onVerticalDragStart: (details){
                              _changeBottomPanelState();
                            },
                            child: Container(
                              height: 30,
                              width: MediaQuery.of(context).size.width * 0.8,
                              color: const Color(0xFFE2EBFF),
                              child: SizedBox(
                                height: 30,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                    children: [
                                      Container(
                                          width: 80,
                                          height: 3.3,
                                          margin: const EdgeInsets.only(top: 10),
                                          decoration: const BoxDecoration(
                                            color: Colors.blue,
                                          )
                                      ),
                                    ]
                                ),
                              ),
                            ),
                          ),
                          if (_bottomPanelHeight > 400) const Text(
                            '23 сентября',
                            style: TextStyle(
                                fontSize: 22.0,
                                fontFamily: 'Manrope',
                                color: Colors.black
                            ),
                          ),
                          SizedBox(
                            height: 180.0,
                            width: MediaQuery.of(context).size.width,
                            child: ListView (
                                scrollDirection: Axis.horizontal,
                                semanticChildCount: 4,
                                children: [
                                  Container(
                                      height: 120,
                                      width: 70,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFE2EBFF),
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10.0),
                                            bottomRight: Radius.circular(10.0),
                                            topLeft: Radius.circular(10.0),
                                            bottomLeft: Radius.circular(10.0)
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: Offset(0, 2), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      margin: const EdgeInsets.only(top:20, left: 20, bottom: 20, right: 10),
                                      child: Column (
                                        children: [
                                          const Text(
                                            '06:00',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontFamily: 'Roboto',
                                                color: Colors.black
                                            ),
                                          ),
                                          Tab(icon: Image.asset("assets/icon_lightning.png", width: 40, height: 40,)),
                                          const Text(
                                            '10 \u00B0C',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontFamily: 'Roboto',
                                                color: Colors.black
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                  Container(
                                      height: 120,
                                      width: 70,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFE2EBFF),
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10.0),
                                            bottomRight: Radius.circular(10.0),
                                            topLeft: Radius.circular(10.0),
                                            bottomLeft: Radius.circular(10.0)
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            spreadRadius: 2,
                                            blurRadius: 3,
                                            offset: Offset(0, 2), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      margin: const EdgeInsets.only(top:20, left: 20, bottom: 20, right: 10),
                                      child: Column (
                                        children: [
                                          const Text(
                                            '12:00',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontFamily: 'Roboto',
                                                color: Colors.black
                                            ),
                                          ),
                                          Tab(icon: Image.asset("assets/icon_sun.png", width: 40, height: 40,)),
                                          const Text(
                                            '10 \u00B0C',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontFamily: 'Roboto',
                                                color: Colors.black
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                  Container(
                                      height: 120,
                                      width: 70,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFE2EBFF),
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10.0),
                                            bottomRight: Radius.circular(10.0),
                                            topLeft: Radius.circular(10.0),
                                            bottomLeft: Radius.circular(10.0)
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: Offset(0, 2), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      margin: const EdgeInsets.only(top:20, left: 20, bottom: 20, right: 10),
                                      child: Column (
                                        children: [
                                          const Text(
                                            '18:00',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontFamily: 'Roboto',
                                                color: Colors.black
                                            ),
                                          ),
                                          Tab(icon: Image.asset("assets/icon_rain_heavy.png", width: 40, height: 40,)),
                                          const Text(
                                            '10 \u00B0C',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontFamily: 'Roboto',
                                                color: Colors.black
                                            ),
                                          ),

                                        ],
                                      )
                                  ),
                                  Container(
                                      height: 120,
                                      width: 70,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFE0E9FD),
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10.0),
                                            bottomRight: Radius.circular(10.0),
                                            topLeft: Radius.circular(10.0),
                                            bottomLeft: Radius.circular(10.0)
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: Offset(0, 2), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      margin: const EdgeInsets.only(top:20, left: 20, bottom: 20, right: 10),
                                      child: Column (
                                        children: [
                                          const Text(
                                            '00:00',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontFamily: 'Roboto',
                                                color: Colors.black
                                            ),
                                          ),
                                          Tab(icon: Image.asset("assets/icon_rain.png", width: 40, height: 40,)),
                                          const Text(
                                            '10 \u00B0C',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontFamily: 'Roboto',
                                                color: Colors.black
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                ]
                            ),
                          ),
                          if (_bottomPanelHeight > 400) SizedBox (
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                Row (
                                  children: [
                                    Container(
                                        height: 70,
                                        width: 150,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFE2EBFF),
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10.0),
                                              bottomRight: Radius.circular(10.0),
                                              topLeft: Radius.circular(10.0),
                                              bottomLeft: Radius.circular(10.0)
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              spreadRadius: 1,
                                              blurRadius: 3,
                                              offset: Offset(0, 2), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        margin: const EdgeInsets.only(top:20, left: 20, bottom: 20, right: 10),
                                        child: Row (
                                          children: [
                                            Tab(icon: Image.asset("assets/thermometer.png", width: 40, height: 40,)),
                                            const Text(
                                              '8',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontFamily: 'Roboto',
                                                  color: Colors.black
                                              ),
                                            ),
                                            const Text(
                                              '\u00B0C',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontFamily: 'Roboto',
                                                  color: Colors.black
                                              ),
                                            ),

                                          ],
                                        )
                                    ),
                                    Container(
                                        height: 70,
                                        width: 150,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFE2EBFF),
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10.0),
                                              bottomRight: Radius.circular(10.0),
                                              topLeft: Radius.circular(10.0),
                                              bottomLeft: Radius.circular(10.0)
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              spreadRadius: 2,
                                              blurRadius: 3,
                                              offset: Offset(0, 2), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        margin: const EdgeInsets.only(top:20, left: 20, bottom: 20, right: 10),
                                        child: Row (
                                          children: [
                                            Tab(icon: Image.asset("assets/humidity.png", width: 40, height: 40,)),
                                            const Text(
                                              '87',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontFamily: 'Roboto',
                                                  color: Colors.black
                                              ),
                                            ),
                                            const Text(
                                              '%',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontFamily: 'Roboto',
                                                  color: Colors.black
                                              ),
                                            ),
                                          ],
                                        )
                                    )
                                  ],
                                ),
                                Row (
                                  children: [
                                    Container(
                                        height: 70,
                                        width: 150,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFE2EBFF),
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10.0),
                                              bottomRight: Radius.circular(10.0),
                                              topLeft: Radius.circular(10.0),
                                              bottomLeft: Radius.circular(10.0)
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              spreadRadius: 1,
                                              blurRadius: 3,
                                              offset: Offset(0, 2), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        margin: const EdgeInsets.only(top:20, left: 20, bottom: 20, right: 10),
                                        child: Row (
                                          children: [
                                            Tab(icon: Image.asset("assets/breeze.png", width: 40, height: 40,)),
                                            const Text(
                                              '9',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontFamily: 'Roboto',
                                                  color: Colors.black
                                              ),
                                            ),
                                            const Text(
                                              'м/с',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontFamily: 'Roboto',
                                                  color: Colors.black
                                              ),
                                            ),

                                          ],
                                        )
                                    ),
                                    Container(
                                        height: 70,
                                        width: 150,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFE2EBFF),
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10.0),
                                              bottomRight: Radius.circular(10.0),
                                              topLeft: Radius.circular(10.0),
                                              bottomLeft: Radius.circular(10.0)
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              spreadRadius: 2,
                                              blurRadius: 3,
                                              offset: Offset(0, 2), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        margin: const EdgeInsets.only(top:20, left: 20, bottom: 20, right: 10),
                                        child: Row (
                                          children: [
                                            Tab(icon: Image.asset("assets/barometer.png", width: 40, height: 40,)),
                                            const Text(
                                              '761',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontFamily: 'Roboto',
                                                  color: Colors.black
                                              ),
                                            ),
                                            const Text(
                                              'мм.рт.ст.',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontFamily: 'Roboto',
                                                  color: Colors.black
                                              ),
                                            ),
                                          ],
                                        )
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () => _toWeekPage(context),
                            child: const Text('Прогноз на неделю', style: TextStyle(color: Color(0xFF038CFE))),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(width: 1.5, color: Color(0xFF038CFE)),
                            ),
                          ),
                        ],
                      ),
                    )
                )
            ),
          ],
        )
    );
  }
  void _toSearchPage(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const MySearchPage()
        )
    );
    setState(
            () {
          title = result;
        }
    );
  }
  void _toWeekPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const WeekPage()));
  }
}