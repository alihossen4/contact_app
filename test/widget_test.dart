import 'package:contact_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  testWidgets('saving a contact returns to the list and displays it', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1000, 1400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MyApp());
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 500)),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    final contactName = 'Ada Lovelace ${DateTime.now().microsecondsSinceEpoch}';
    await tester.enterText(find.byType(TextField).at(0), contactName);
    await tester.enterText(find.byType(TextField).at(1), '555-0100');
    await tester.enterText(find.byType(TextField).at(2), 'ada@example.com');
    await tester.enterText(find.byType(TextField).at(3), 'London');
    final saveContact = tester.widget<FilledButton>(find.byType(FilledButton)).onPressed!;
    await tester.runAsync(
      () => (saveContact as Future<void> Function())(),
    );
    await tester.pumpAndSettle();

    expect(find.text('My Contacts'), findsOneWidget);
    expect(find.text(contactName), findsOneWidget);
    expect(find.text('ada@example.com'), findsOneWidget);
  });
}
