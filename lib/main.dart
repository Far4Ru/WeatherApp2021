import 'package:flutter/material.dart';
// import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
// import 'package:storyswiper/storyswiper.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Weather App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

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
                MaterialPageRoute(builder: (context)=> FavouritePage(favourites: const ["ds","das"]),
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
class ItemDetail {
  String strTitle;
  var isFavorite = false;
  ItemDetail (this.strTitle, this.isFavorite);
}
class MySearchPage extends StatefulWidget {
  const MySearchPage({Key? key}) : super(key: key);
  @override
  State<MySearchPage> createState() => SearchPage();
}

class SearchPage extends State<MySearchPage> {
  final _controller = TextEditingController();

  List<ItemDetail> items = [ItemDetail("Москва", false), ItemDetail("Санкт-Петербург", true)];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 25),
            height: 35.0,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                IconButton(
                  onPressed: () => _toHomePage(context),
                  icon: const Icon(
                    Icons.keyboard_arrow_left,
                    size: 20,
                  ),
                ),
                SizedBox(
                  width: 300,
                  height: 35.0,
                  child: TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Введите название города...',
                      suffixIcon: IconButton(
                        onPressed: _controller.clear,
                        icon: const Icon(Icons.cancel),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(
                      context,
                      items[index].strTitle.toString()
                    );
                  },
                  child: Container(
                    height: 45.0,
                    decoration: const BoxDecoration(
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  items[index].strTitle,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontSize: 24),
                                  maxLines: 1,
                                ),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    items[index].isFavorite =
                                    !items[index].isFavorite;
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(0.0),
                                  child: Icon(
                                    items[index].isFavorite
                                      ? Icons.star
                                      : Icons.star_border,
                                    color: const Color(0xFF323232),
                                    size: 30.0,
                                  )
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 0.0),
                          child: Container(
                            color: Colors.grey,
                            height: 1.0,
                          ),
                        ),
                      ],
                    )
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
  void _toHomePage(BuildContext context) {
    Navigator.of(context).pop(MaterialPageRoute(builder: (context) => const MyHomePage(title: "Погода")));
  }
}

class WeekPage extends StatelessWidget {

  const WeekPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 25),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => _navigateToPreviousPage(context),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                  ),
                ),
                const SizedBox(
                  child: Text(
                    'Прогноз на неделю',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontFamily: 'Roboto',
                      color: Colors.black
                    ),
                  )
                )
              ],
            ),
            Container(
              //color: Colors.lightBlueAccent,
              margin: const EdgeInsets.only(top:20, left: 20, bottom: 20, right: 10),
              decoration: const BoxDecoration(
                color: Color(0xFFE2EBFF),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0)
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 25.0, left: 30.0, bottom: 15.0),
                        child: const Text("23 сентября",
                          style: TextStyle(
                            fontSize: 28.0,
                            fontFamily: 'Roboto',
                            color: Colors.black
                          ),
                        ),
                      ),
                    ]
                  ),
                  Row(
                    children: [
                      Tab(icon: Image.asset("assets/partly_cloudy.png", width: 100, height:100)),
                    ]
                  ),
                  Row(
                    children: [
                      Tab(icon: Image.asset("assets/thermometer.png", width: 100, height:100)),
                      const Text("8\u00B0C"),
                    ]
                  ),
                  Row(
                    children: [
                      Tab(icon: Image.asset("assets/breeze.png", width: 100, height:100)),
                      const Text("9м/с"),
                    ]
                  ),
                  Row(
                    children: [
                      Tab(icon: Image.asset("assets/humidity.png", width: 100, height:100)),
                      const Text("87%"),
                    ]
                  ),
                  Row(
                    children: [
                      Tab(icon: Image.asset("assets/barometer.png", width: 100, height:100)),
                      const Text("761мм.рт.ст"),
                    ]
                  ),
                ]
              )
            ),
            Container(
              margin: const EdgeInsets.only(top:20, left: 20, bottom: 20, right: 10),
              child: OutlinedButton(
                onPressed: () => _navigateToPreviousPage(context),
                child: const Text('Вернуться на главную', style: TextStyle(color: Color(0xFF000000))),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(width: 1.5, color: Color(0xFF000000)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _navigateToPreviousPage(BuildContext context) {
    Navigator.of(context).pop(MaterialPageRoute(builder: (context) => const MyHomePage(title: "Погода")));
  }
}
class SettingsPage extends StatefulWidget {

  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _temperatureSelectedIndex = 0;
  int _windStrengthSelectedIndex = 0;
  int _pressureSelectedIndex = 0;
  bool isTempSwitched=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 25),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => _navigateToPreviousPage(context),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                  ),
                ),
                const SizedBox(
                  child: Text(
                    'Настройки',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontFamily: 'Roboto',
                      color: Colors.black
                    ),
                  )
                )
              ],
            ),
            Container(
              //color: Colors.lightBlueAccent,
              margin: const EdgeInsets.only(top:20, left: 20, bottom: 20, right: 10),
              decoration: const BoxDecoration(
                color: Color(0xFFE2EBFF),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0)
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text("Температура"),
                      Expanded(
                        child: NeumorphicToggle(
                          height: 40,
                          selectedIndex: _temperatureSelectedIndex,
                          displayForegroundOnlyIfSelected: true,
                          children: [
                            ToggleElement(
                              background: const Center(child:  Text("\u00B0C", style: TextStyle(fontWeight: FontWeight.w500),)),
                              foreground: const Center(child: Text("\u00B0C", style:  TextStyle(fontWeight: FontWeight.w700, color: Colors.white),)),
                            ),
                            ToggleElement(
                              background: const Center(child: Text("\u00B0F", style:  TextStyle(fontWeight: FontWeight.w500),)),
                              foreground: const Center(child:  Text("\u00B0F", style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),)),
                            ),
                          ],
                          thumb: Neumorphic(
                            style: NeumorphicStyle(
                              color: const Color(0xFF4B5F88),
                              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _temperatureSelectedIndex = value;
                              // print("_firstSelected: $_selectedIndex");
                            });
                          },
                          style: NeumorphicToggleStyle(
                            disableDepth: true,
                            borderRadius: BorderRadius.circular(40),
                            // lightSource: LightSource.top,
                            backgroundColor: const Color(0xFFE2EBFF),
                          ),
                        ),
                      )
                    ]
                  ),
                  Row(
                    children: [
                      const Text("Сила ветра"),
                      Expanded(
                        child: NeumorphicToggle(
                          height: 40,
                          selectedIndex: _windStrengthSelectedIndex,
                          displayForegroundOnlyIfSelected: true,
                          children: [
                            ToggleElement(
                              background: const Center(child:  Text("м/с", style: TextStyle(fontWeight: FontWeight.w500),)),
                              foreground: const Center(child: Text("м/с", style:  TextStyle(fontWeight: FontWeight.w700, color: Colors.white),)),
                            ),
                            ToggleElement(
                              background: const Center(child: Text("км/ч", style:  TextStyle(fontWeight: FontWeight.w500),)),
                              foreground: const Center(child:  Text("км/ч", style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),)),
                            ),
                          ],
                          thumb: Neumorphic(
                            style: NeumorphicStyle(
                              color: const Color(0xFF4B5F88),
                              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _windStrengthSelectedIndex = value;
                              // print("_firstSelected: $_selectedIndex");
                            });
                          },
                          style: NeumorphicToggleStyle(
                            disableDepth: true,
                            borderRadius: BorderRadius.circular(40),
                            // lightSource: LightSource.top,
                            backgroundColor: const Color(0xFFE2EBFF),
                          ),
                        ),
                      )
                    ]
                  ),
                  Row(
                    children: [
                      const Text("Давление"),
                      Expanded(
                        child: NeumorphicToggle(
                          height: 40,
                          selectedIndex: _pressureSelectedIndex,
                          displayForegroundOnlyIfSelected: true,
                          children: [
                            ToggleElement(
                              background: const Center(child:  Text("мм.рт.ст.", style: TextStyle(fontWeight: FontWeight.w500),)),
                              foreground: const Center(child: Text("мм.рт.ст.", style:  TextStyle(fontWeight: FontWeight.w700, color: Colors.white),)),
                            ),
                            ToggleElement(
                              background: const Center(child: Text("гПа", style:  TextStyle(fontWeight: FontWeight.w500),)),
                              foreground: const Center(child:  Text("гПа", style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),)),
                            ),
                          ],
                          thumb: Neumorphic(
                            style: NeumorphicStyle(
                              color: const Color(0xFF4B5F88),
                              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _pressureSelectedIndex = value;
                              // print("_firstSelected: $_selectedIndex");
                            });
                          },
                          style: NeumorphicToggleStyle(
                            disableDepth: true,
                            borderRadius: BorderRadius.circular(40),
                            // lightSource: LightSource.top,
                            backgroundColor: const Color(0xFFE2EBFF),
                          ),
                        ),
                      )
                    ]
                  ),
                ]
              )
            ),
          ],
        ),
      ),
    );
  }
  void _navigateToPreviousPage(BuildContext context) {
    Navigator.of(context).pop(MaterialPageRoute(builder: (context) => const MyHomePage(title: "Погода")));
  }
}
class FavouritePage extends StatelessWidget {

  var favourites = ["cs"];

  FavouritePage({Key? key, required this.favourites}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 25),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => _navigateToPreviousPage(context),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                  ),
                ),
                const SizedBox(
                  child: Text(
                    'Избранное',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontFamily: 'Roboto',
                      color: Colors.black
                    ),
                  )
                )
              ],
            ),
            Container(
              //color: Colors.lightBlueAccent,
              margin: const EdgeInsets.only(top:20, left: 20, bottom: 20, right: 10),
              decoration: const BoxDecoration(
                color: Color(0xFFE2EBFF),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0)
                ),
              ),
              child: ListView.builder(
                itemCount: favourites.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 45.0,
                    decoration: const BoxDecoration(
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  favourites[index],
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontSize: 24),
                                  maxLines: 1,
                                ),
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                },
                                child: Container(
                                    margin: const EdgeInsets.all(0.0),
                                    child: const Icon(
                                      Icons.star,
                                      color: Color(0xFF323232),
                                      size: 30.0,
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 0.0),
                          child: Container(
                            color: Colors.grey,
                            height: 1.0,
                          ),
                        ),
                      ],
                    )
                  );
                },
              )
            ),
          ],
        ),
      ),
    );
  }
  void _navigateToPreviousPage(BuildContext context) {
    Navigator.of(context).pop(MaterialPageRoute(builder: (context) => const MyHomePage(title: "Погода")));
  }
}
class AboutPage extends StatelessWidget {

  const AboutPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: const Color(0xFFDEE9FF),
          ),
          SizedBox(
            height: 100,
            child: Row(
              children: [
                IconButton(
                  onPressed: () => _navigateToPreviousPage(context),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                  ),
                ),
                const SizedBox(
                  child: Text(
                    'О разработчике',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontFamily: 'Roboto',
                      color: Colors.black
                    ),
                  )
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top:150, left: 100),
            width: 200,
            height: 50,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
                topLeft: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0)
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                ),
                BoxShadow(
                  color: Color(0xFFDEE9FF),
                  spreadRadius: -0.2,
                  blurRadius: 4.0,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 3.0, left: 25.0),
                  child: const Text("Weather App",
                    style: TextStyle(
                      fontSize: 26.0,
                      fontFamily: 'Roboto',
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ]
            ),
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            height: 400,
            child: Container (
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color(0xFFE2EBFF),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30.0),
                  bottomRight: Radius.circular(0.0),
                  topLeft: Radius.circular(30.0),
                  bottomLeft: Radius.circular(0.0)
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 2,
                    blurRadius: 20,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 30.0, bottom:10),
                    child: const Text("by ITMO University",
                      style: TextStyle(
                        fontSize: 22.0,
                        fontFamily: 'Roboto',
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  const Text("Версия 0.1",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'Roboto',
                      color: Color(0xFF4A4A4A),
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: const Text("от 30 сентября 2021",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: 'Roboto',
                        color: Color(0xFF4A4A4A),
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 260.0),
                    child: const Text("2021",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Roboto',
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
            )
          )
        ]
      )
    );
  }
  void _navigateToPreviousPage(BuildContext context) {
    Navigator.of(context).pop(MaterialPageRoute(builder: (context) => const MyHomePage(title: "Погода")));
  }
}