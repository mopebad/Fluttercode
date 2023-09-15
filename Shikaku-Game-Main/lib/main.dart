import 'package:flutter/material.dart';
import 'package:ShikakuGame/shikaku.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Shikaku',
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3.0, color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3.0, color: Colors.white),
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Create Shikaku Puzzle',
            style: TextStyle(
              fontFamily: 'Dapifer',
              fontSize: 24, // Set the font family to 'Dapifer'
              // Set the font weight to bold
            ),
          ),
          backgroundColor: Colors.grey[800],
        ),
        backgroundColor: Colors.grey[800],
        body: Center(
          child: SizedBox(
            width: 650,
            height: 900,
            child: const CreatePuzzleScreen(),
          ),
        ),
      ),
    );
  }
}

class CreatePuzzleScreen extends StatefulWidget {
  const CreatePuzzleScreen({Key? key}) : super(key: key);

  @override
  _CreatePuzzleScreenState createState() => _CreatePuzzleScreenState();
}

class _CreatePuzzleScreenState extends State<CreatePuzzleScreen> {
  late List<int> numbers;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    numbers = List.generate(49, (_) => 0);
    passwordController = TextEditingController();
  }

  void setNumber(int index, int number) {
    setState(() {
      numbers[index] = number;
    });
  }

  void startGame() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShikakuGame(numbers: numbers),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.grey[800],
          elevation: 0,
        ),
      ),
      backgroundColor: Colors.grey[800],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          'Input Numbers Into The Tiles.',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontFamily: 'Dapifer',
                          ),
                        ),
                      ),
                    ),
                    Center(
  child: Padding(
    padding: const EdgeInsets.only(right: 0.0), // Adjust the right padding as needed
    child: Container(
      width: 500, // Set the desired width
      height: 600, // Set the desired height
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          childAspectRatio: 1,
        ),
        itemCount: numbers.length,
        itemBuilder: (context, index) {
          return NumberButton(
            number: numbers[index],
            onPressed: (number) {
              setNumber(index, number);
            },
          );
        },
      ),
    ),
  ),
),
                      const SizedBox(height: 16.0),
                      Center(
                        child: ElevatedButton(
                          onPressed: startGame,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey[800],
                            side: const BorderSide(width: 3.0, color: Colors.white),
                            padding: const EdgeInsets.all(16.0),
                          ),
                          child: const Text('Start Game', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                ),
              ),
            ),
          ], // Add a closing bracket for the "children" list of the outer Column
        ),
      ),
    );
  }
}



class NumberButton extends StatelessWidget {
  final int number;
  final ValueSetter<int> onPressed;

  const NumberButton({
    Key? key,
    required this.number,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => NumberInputDialog(
            initialValue: number,
            onChanged: onPressed,
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16.0),
        primary: Colors.grey[800],
        side: const BorderSide(width: 3.0, color: Colors.white),
      ),
      child: Text(
        number.toString(),
        style: const TextStyle(fontSize: 24.0, color: Colors.white),
      ),
    );
  }
}

class NumberInputDialog extends StatefulWidget {
  final int initialValue;
  final ValueSetter<int> onChanged;

  const NumberInputDialog({
    Key? key,
    required this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  _NumberInputDialogState createState() => _NumberInputDialogState();
}

class _NumberInputDialogState extends State<NumberInputDialog> {
  late TextEditingController _controller;
  late int _number;

  @override
  void initState() {
    super.initState();
    _number = widget.initialValue;
    _controller = TextEditingController(text: _number.toString());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[800],
      title: const Text('Enter Number', style: TextStyle(color: Colors.white)),
      content: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        style: const TextStyle(color: Colors.black), // Set the text color to black
        decoration: const InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        onChanged: (value) {
          setState(() {
            _number = int.tryParse(value) ?? 0;
          });
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            widget.onChanged(_number);
          },
          child: const Text('OK', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
