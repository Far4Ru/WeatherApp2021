import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../data/data.dart';

class SearchPage extends StatefulWidget {
  final List<ItemDetail> items;

  final String selected;
  const SearchPage({Key? key, required this.items, required this.selected}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();

  String _name = "";

  List<ItemDetail> searchItems = [];

  _changeName(){
    setState(
      () {
        _name = _controller.text;
        searchItems = widget.items.where((element) => element.strTitle.contains(_name)).toList();
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
              itemCount: searchItems.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    _toHomePage(
                        context,
                        searchItems[index].strTitle.toString()
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
                                    searchItems[index].strTitle,
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
                                      searchItems[index].isFavorite =
                                      !searchItems[index].isFavorite;
                                    });
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.all(0.0),
                                      child: Icon(
                                        searchItems[index].isFavorite
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

