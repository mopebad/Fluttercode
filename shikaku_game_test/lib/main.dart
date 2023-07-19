import 'package:flutter/material.dart';
import 'package:minigames/shikaku.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Generate the initial puzzle numbers here
  List<int> generatePuzzleNumbers() {
    return List.generate(49, (_) => 0);
  }

  @override
  Widget build(BuildContext context) {
    List<int> puzzleNumbers = generatePuzzleNumbers(); // Generate the puzzle numbers
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
      home: ShikakuGameMainScreen(puzzleNumbers: puzzleNumbers), // Pass the puzzle numbers here
    );
  }
}

class ShikakuGameMainScreen extends StatelessWidget {
  final List<int> puzzleNumbers; // Add this variable to hold the non-zero puzzle numbers

  ShikakuGameMainScreen({Key? key, required this.puzzleNumbers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShikakuGame(numbers: puzzleNumbers), // Pass the puzzleNumbers to the game screen
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreatePuzzleScreen(),
            ),
          );
        },
        label: const Text('Create Game'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.grey[800],
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
  bool showIncorrectPasswordError = false; // Added state variable

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
    List<int> puzzleNumbers = numbers.where((number) => number != 0).toList(); // Filter out the zeros
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShikakuGameMainScreen(puzzleNumbers: puzzleNumbers),
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
      body: SingleChildScrollView( // Added SingleChildScrollView widget
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ 
            Center( // Added Center widget
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Input Numbers Into The Tiles.',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontFamily: 'PlayfairDisplay',
                  ),
                ),
              ),
            ),
              
            if (numbers.contains(0)) // Check if there are any empty cells
              Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                      childAspectRatio: 1.0,
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
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: startGame,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey[800],
                      side: const BorderSide(width: 3.0, color: Colors.white),
                      padding: const EdgeInsets.all(16.0),
                    ),
                    child: const Text('Start Game', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            if (numbers.every((number) => number != 0)) // Check if all cells are filled
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    numbers = List.generate(49, (_) => 0); // Reset the numbers list
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[800],
                  side: const BorderSide(width: 3.0, color: Colors.white),
                  padding: const EdgeInsets.all(16.0),
                ),
                child: const Text('Create New Puzzle', style: TextStyle(color: Colors.white)),
              ),
          ],
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
