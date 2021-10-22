import 'package:flutter/material.dart';
// import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
// import 'package:storyswiper/storyswiper.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'home.dart';
import '../data/data.dart';

class SearchPage extends StatefulWidget {
  List<ItemDetail> items = [];

  String selected = "";
  SearchPage({Key? key, required this.items, required this.selected}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();
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
                  onPressed: () => _toHomePage(context, widget.selected),
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
              itemCount: widget.items.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    _toHomePage(
                        context,
                        widget.items[index].strTitle.toString()
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
                                    widget.items[index].strTitle,
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
                                      widget.items[index].isFavorite =
                                      !widget.items[index].isFavorite;
                                    });
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.all(0.0),
                                      child: Icon(
                                        widget.items[index].isFavorite
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
  void _toHomePage(BuildContext context , value) {
    Navigator.pop(context, [value, widget.items]);
  }
}

