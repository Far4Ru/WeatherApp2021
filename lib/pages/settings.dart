import 'package:flutter/material.dart';
// import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
// import 'package:storyswiper/storyswiper.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../data/data.dart';
import 'home.dart';

class SettingsPage extends StatefulWidget {
  final List<SettingsParameter> parameters;
  const SettingsPage({Key? key, required this.parameters}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isTempSwitched=false;

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
          Container(
            margin: const EdgeInsets.only(top: 25),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => _toHomePage(context),
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
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                      itemCount: widget.parameters.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildParameterCard(context, widget.parameters[index]);
                      }
                  ),
                ),
              ],
            ),
          ),
        ]
      ),
    );
  }

  Widget _buildParameterCard(BuildContext context, SettingsParameter parameters) {
    return Row(
        children: [
          Text(parameters.name),
          Expanded(
            child: NeumorphicToggle(
              height: 40,
              selectedIndex: parameters.selected,
              displayForegroundOnlyIfSelected: true,
              children: [
                ToggleElement(
                  background: Center(child:  Text(parameters.values[0], style: const TextStyle(fontWeight: FontWeight.w500),)),
                  foreground: Center(child: Text(parameters.values[0], style:  const TextStyle(fontWeight: FontWeight.w700, color: Colors.white),)),
                ),
                ToggleElement(
                  background: Center(child: Text(parameters.values[1], style:  const TextStyle(fontWeight: FontWeight.w500),)),
                  foreground: Center(child:  Text(parameters.values[1], style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.white),)),
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
                  parameters.selected = value;
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
    );
  }

  void _toHomePage(BuildContext context) {
    Navigator.pop(context, widget.parameters);
  }
}
