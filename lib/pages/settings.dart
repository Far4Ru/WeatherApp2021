import 'package:flutter/material.dart';
// import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
// import 'package:storyswiper/storyswiper.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'home.dart';
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