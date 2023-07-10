import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shikaku_game/main.dart';

void main() {
  testWidgets('Shikaku game test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: ShikakuGame(numbers: [1])));

    
    // Tap a cell and verify that it updates.
    await tester.tap(find.byType(GestureDetector).first);
    await tester.pump();

  

    // Tap another cell and verify that it updates.
    await tester.tap(find.byType(GestureDetector).at(1));
    await tester.pump();

    // Verify that both cells are updated with non-zero values.
    expect(find.text('0'), findsNWidgets(23));
    expect(find.text('1'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
  });
}
