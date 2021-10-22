import 'package:flutter/material.dart';
// import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
// import 'package:storyswiper/storyswiper.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'home.dart';
class FavouritePage extends StatelessWidget {

  const FavouritePage({Key? key}) : super(key: key);
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
                    children: const [
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