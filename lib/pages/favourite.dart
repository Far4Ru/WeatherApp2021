import 'package:flutter/material.dart';
// import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
// import 'package:storyswiper/storyswiper.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'home.dart';

class FavouritePage extends StatelessWidget {

  var favourites = [];

  FavouritePage({Key? key, required this.favourites}) : super(key: key);
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
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: favourites.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 45.0,
                        decoration: const BoxDecoration(
                        ),
                        child: Column(
                          children: <Widget>[
                            Neumorphic(
                              margin: const EdgeInsets.only(left: 8, right: 8),
                              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                              child: Row(
                                children: [
                                  Text(
                                    favourites[index],
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        fontSize: 24
                                    ),
                                    maxLines: 1,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                    },
                                    child: Neumorphic(
                                      child: const Icon(
                                        Icons.close,
                                        color: Color(0xFF323232),
                                        size: 30.0,
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
                              style: const NeumorphicStyle(
                                shape: NeumorphicShape.flat,
                                depth: -4,
                                // intensity: 0.65,
                                color: Color(0xFFDEE9FF),
                                // lightSource: LightSource.top,
                                // boxShape: NeumorphicBoxShape.stadium(),
                              ),
                            ),
                          ],
                        )
                      );
                    },
                  ),
                ),
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