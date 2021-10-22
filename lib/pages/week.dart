import 'package:flutter/material.dart';
// import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
// import 'package:storyswiper/storyswiper.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'home.dart';

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

