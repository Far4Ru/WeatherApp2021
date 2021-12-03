import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../models/locations.dart';
import 'home.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class FavouritePage extends StatefulWidget {

  const FavouritePage({Key? key}) : super(key: key);

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {

  List<LocationsHive> items = [];

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
          // TODO: - Update by Hive values
          Container(
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
                    SizedBox(
                        child: Text(
                          'Избранное',
                          style: TextStyle(
                              fontSize: 28.0,
                              fontFamily: 'Roboto',
                              color: accentColor
                          ),
                        )
                    )
                  ],
                ),
                ValueListenableBuilder(
                valueListenable: Hive.box<LocationsHive>('box_for_locations').listenable(),
                builder: (context, Box<LocationsHive> box, _) {
                  items = box.values.where((element) => element.favourite).toList();
                  return SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            decoration: const BoxDecoration(
                            ),
                            child: Column(
                              children: <Widget>[
                                Neumorphic(
                                  margin: const EdgeInsets.only(
                                      left: 8, right: 8, top: 10),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 5),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(left: 8,
                                              right: 8,
                                              top: 10,
                                              bottom: 10),
                                          child: Text(
                                            items[index]
                                                .name,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 24,color: accentColor
                                            ),
                                            maxLines: 1,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              items[index].favouriteChange();
                                              items.removeAt(index);
                                            });
                                          },
                                          child: Neumorphic(
                                            child: const Icon(
                                              Icons.close,
                                              color: Color(0xFF323232),
                                              size: 45.0,
                                            ),
                                            style: const NeumorphicStyle(
                                              shape: NeumorphicShape.flat,
                                              depth: 8,
                                              // intensity: 0.65,
                                              color: Color(0xFFC8DAFF),
                                              // lightSource: LightSource.top,
                                            ),
                                          ),
                                        ),
                                      ]
                                  ),
                                  style: NeumorphicStyle(
                                    shape: NeumorphicShape.flat,
                                    depth: -4,
                                    // intensity: 0.65,
                                    color: baseColor,
                                    // lightSource: LightSource.top,
                                    // boxShape: NeumorphicBoxShape.stadium(),
                                  ),
                                ),
                              ],
                            )
                        );
                      },
                    ),
                  );

                }
                )
              ],
            ),
          ),
        ]
      ),
    );
  }

  void _navigateToPreviousPage(BuildContext context) {
    Navigator.of(context).pop(MaterialPageRoute(builder: (context) => const MyHomePage(title: "Погода")));
  }
}