import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'home.dart';

class AboutPage extends StatelessWidget {

  const AboutPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = NeumorphicTheme.currentTheme(context);
    final baseColor = theme.baseColor;
    final accentColor = theme.accentColor;
    return Scaffold(
        body: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: baseColor,
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
                    SizedBox(
                        child: Text(
                          'О разработчике',
                          style: TextStyle(
                              fontSize: 28.0,
                              fontFamily: 'Roboto',
                              color: accentColor
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
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0)
                  ),
                  boxShadow: [
                    const BoxShadow(
                      color: Colors.grey,
                    ),
                    BoxShadow(
                      color: baseColor,
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
                        child: Text("Weather App",
                          style: TextStyle(
                              fontSize: 26.0,
                              fontFamily: 'Roboto',
                              color: accentColor,
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
                    decoration: BoxDecoration(
                      color: baseColor,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(30.0),
                          bottomRight: Radius.circular(0.0),
                          topLeft: Radius.circular(30.0),
                          bottomLeft: Radius.circular(0.0)
                      ),
                      boxShadow: const [
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
                          child: Text("by ITMO University",
                            style: TextStyle(
                                fontSize: 22.0,
                                fontFamily: 'Roboto',
                                color: accentColor,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Text("Версия 0.1",
                          style: TextStyle(
                              fontSize: 14.0,
                              fontFamily: 'Roboto',
                              color: accentColor,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5.0),
                          child: Text("от 30 сентября 2021",
                            style: TextStyle(
                                fontSize: 14.0,
                                fontFamily: 'Roboto',
                                color: accentColor,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 260.0),
                          child: Text("2021",
                            style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'Roboto',
                                color: accentColor,
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