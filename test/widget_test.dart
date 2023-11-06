// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_firebase/main.dart';

// Создание классов-заглушек
class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  // Создание экземпляров мок-классов
  final MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
  final MockSharedPreferences mockSharedPreferences = MockSharedPreferences();

  // Использование этих мок-экземпляров при запуске виджета
  testWidgets('Тест виджета MyApp', (WidgetTester tester) async {
    // Построение приложения и активация кадра с мок-параметрами
    await tester.pumpWidget(MyApp(firebaseAuth: mockFirebaseAuth, prefs: mockSharedPreferences));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
