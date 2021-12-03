import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:weather_app/models/locations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class SearchPage extends StatefulWidget {

  final String selected;
  const SearchPage({Key? key, required this.selected}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();

  List<LocationsHive> items = [];

  String _name = "";

  List<LocationsHive> searchItems = [];

  _changeName(){
    setState(
      () {
        _name = _controller.text;
        searchItems = items.where((element) => element.name.contains(_name)).toList();
      }
    );
  }

  @override
  void initState() {
    super.initState();
    _controller.text = _name;
    _controller.addListener(_changeName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
          ValueListenableBuilder(
            valueListenable: Hive.box<LocationsHive>('box_for_locations').listenable(),
            builder: (context, Box<LocationsHive> box, _) {
              items = box.values.toList();
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 25),
                    height: 35.0,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => _toHomePage(context, ""),
                          icon: Icon(
                            Icons.keyboard_arrow_left,
                            size: 20,
                            color: accentColor,
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
                                color: accentColor,
                              ),
                            ),
                            style: TextStyle(color: accentColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                    itemCount: searchItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          _toHomePage(
                              context,
                              searchItems[index].locationName.toString()
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
                                          searchItems[index].name,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(fontSize: 24, color: accentColor),
                                          maxLines: 1,
                                        ),
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            searchItems[index].favouriteChange();
                                          });
                                        },
                                        child: Container(
                                            margin: const EdgeInsets.all(0.0),
                                            child: Icon(
                                              searchItems[index].favourite
                                                  ? Icons.star
                                                  : Icons.star_border,
                                              color: accentColor,
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
              );
            }
          )
        ]
      )
    );
  }
  void _toHomePage(BuildContext context , value) {
    Navigator.pop(context, [value]);
  }
}

