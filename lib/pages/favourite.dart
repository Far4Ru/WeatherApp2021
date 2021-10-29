import 'package:flutter/material.dart';
// import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
// import 'package:storyswiper/storyswiper.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'home.dart';
import '../data/data.dart';

class FavouritePage extends StatefulWidget {

  final List<ItemDetail> items;

  const FavouritePage({Key? key, required this.items}) : super(key: key);

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
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
                    itemCount: widget.items.where((i) => i.isFavorite).toList().length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: const BoxDecoration(
                        ),
                        child: Column(
                          children: <Widget>[
                            Neumorphic(
                              margin: const EdgeInsets.only(left: 8, right: 8, top: 10),
                              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 10),
                                    child: Text(
                                      widget.items.where((i) => i.isFavorite).toList()[index].strTitle,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          fontSize: 24
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        widget.items[index].isFavorite = false;
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