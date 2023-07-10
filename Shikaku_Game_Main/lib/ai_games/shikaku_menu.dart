import 'package:flutter/material.dart';
import 'shikaku.dart';


class ShikakuGameMenu extends StatefulWidget {
  const ShikakuGameMenu({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ShikakuGameMenuState createState() => _ShikakuGameMenuState();
}

class _ShikakuGameMenuState extends State<ShikakuGameMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: const Text('List of Shikaku Game'),
  backgroundColor: Colors.grey[800],
),
      body: ListView(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ShikakuGame(numbers: [
                  4, 0, 0, 0,
                  4, 0, 0, 0,
                  4, 0, 0, 0,
                  4, 0, 0, 0,
                  ])),
              );
            },
            child: const ListTile(
              leading: Icon(Icons.gamepad),
              title: Text('Game 1'),
              subtitle: Text('A very simple game'),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ShikakuGame(numbers: [
                  4, 0, 3, 0, 0,
                  0, 0, 3, 0, 0,
                  0, 2, 3, 0, 0,
                  0, 0, 0, 2, 4,
                  2, 0, 0, 2, 0,
                  ])),
              );
            },
            child: const ListTile(
              leading: Icon(Icons.gamepad),
              title: Text('Game 2'),
              subtitle: Text('5x5 puzzle id 2,000,000'),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ShikakuGame(numbers:[
                  0, 0, 0, 0, 0, 0,
                  0, 0, 0, 0, 0, 0,
                  0, 0, 0, 0, 0, 0,
                  0, 0, 0, 0, 12, 0,
                  0, 15, 0, 0, 3, 0,
                  4, 0, 0, 0, 0, 2
                  ])),
              );
            },
            child: const ListTile(
              leading: Icon(Icons.gamepad),
              title: Text('Game 3'),
              subtitle: Text('6x6 puzzle ai generated with brute force'),
            ),            
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ShikakuGame(numbers: [
                  3, 0, 0, 3, 0, 0, 4,
                  0, 4, 0, 0, 4, 0, 0,
                  0, 0, 0, 0, 0, 6, 0,
                  2, 0, 0, 0, 0, 0, 0,
                  0, 0, 4, 0, 0, 4, 0,
                  0, 6, 0, 2, 0, 0, 3,
                  0, 0, 0, 0, 4, 0, 0
                  ])),
              );
            },
            child: const ListTile(
              leading: Icon(Icons.gamepad),
              title: Text('Game 4'),
              subtitle: Text('7x7 puzzle ai generated with brute force'),
            ),            
          ),
        ],
      ),
    );
  }
}
