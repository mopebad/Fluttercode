import 'package:flutter/material.dart';
import 'package:minigames/shikaku.dart';


void main() async {
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
          title: const Text('Create Shikaku Puzzle'),
          backgroundColor: Colors.grey[800], // Set the background color to grey
        ),
        backgroundColor: Colors.grey[800], // Set the background color to grey
        body: Center(
          child: SizedBox(
            width: 800, // Set the desired width
            height: 900, // Set the desired height
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
  bool isAdmin = false;
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

  void submitPassword(String password) {
    if (password == '1234') {
      setState(() {
        isAdmin = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.grey[800],
          elevation: 0,
        ),
      ),
      backgroundColor: Colors.grey[800],
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                isAdmin
                    ? 'Input Numbers Into The Tiles. Make The Puzzle Is Solveable.'
                    : 'Enter Password.',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontFamily: 'PlayfairDisplay',
                  fontStyle: FontStyle.italic
                ),
              ),
            ),
            if (!isAdmin)
              Column(
                children: [
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3.0, color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3.0, color: Colors.white),
                      ),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
  onPressed: () {
    submitPassword(passwordController.text);
  },
  style: ElevatedButton.styleFrom(
    primary: Colors.grey[800],
    side: const BorderSide(width: 3.0, color: Colors.white),
    padding: const EdgeInsets.all(20.0),
  ),
  child: const Text(
    'Submit',
    style: TextStyle(
      color: Colors.white,
      fontFamily: 'PlayfairDisplay', // Added font family
    ),
  ),
),

                  const SizedBox(height: 20.0),
                  ElevatedButton(
  onPressed: startGame,
  style: ElevatedButton.styleFrom(
    primary: Colors.grey[800],
    side: const BorderSide(width: 3.0, color: Colors.white),
    padding: const EdgeInsets.all(20.0),
  ),
  child: const Text(
    'Continue to Puzzle',
    style: TextStyle(
      color: Colors.white,
      fontFamily: 'PlayfairDisplay', // Added font family
    ),
  ),
),
                ],
              ),
            Visibility(
              visible: isAdmin,
              child: Column(
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
        style: const TextStyle(color: Colors.white),
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