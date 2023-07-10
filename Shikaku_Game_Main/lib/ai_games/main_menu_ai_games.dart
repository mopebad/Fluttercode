import 'package:flutter/material.dart';
import 'shikaku_menu.dart';

class AIGamesMenuPage extends StatefulWidget {
  const AIGamesMenuPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AIGamesMenuState createState() => _AIGamesMenuState();
}

class MenuItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget Function(BuildContext) function;

  MenuItem(this.icon, this.title, this.subtitle, this.function);  
}

class _AIGamesMenuState extends State<AIGamesMenuPage> {

  @override
  Widget build(BuildContext context) {
    var widgets = <Widget>[];
    final menu = <MenuItem>[
        MenuItem(Icons.gamepad, 'Shikaku', 'Shikaku',
          (context) => const ShikakuGameMenu()),
       
      ];

    for (var i in menu) {
      widgets.add(
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: i.function),
              );
            },
            child: ListTile(
              leading: Icon(i.icon),
              title: Text(i.title),
              subtitle: Text(i.subtitle),
            ),
          ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Game Menu'),
      ),
      body: ListView(
        children: widgets,
      ),
    );
  }
}