import 'package:contact_app/main.dart';
import 'package:contact_app/db/contact_database.dart';
import 'package:contact_app/model/contact.dart';
import 'package:contact_app/ui/widget/edit_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  testWidgets('contact list opens the add contact form', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Contacts'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('New contact'), findsOneWidget);
  });

  testWidgets('edit contact form starts with the selected contact details', (
    WidgetTester tester,
  ) async {
    final contact = Contact(
      id: 12,
      name: 'Alex Example',
      phoneNumber: '555-0123',
      email: 'alex@example.com',
      address: 'Main Street',
    );

    await tester.pumpWidget(MaterialApp(home: EditContact(contact: contact)));

    expect(find.text('Edit contact'), findsOneWidget);
    expect(find.text('Save changes'), findsOneWidget);
    expect(
      tester.widget<TextField>(find.byType(TextField).at(0)).controller!.text,
      'Alex Example',
    );
    expect(
      tester.widget<TextField>(find.byType(TextField).at(1)).controller!.text,
      '555-0123',
    );
  });

  test('editing a contact persists the changed details', () async {
    final marker = DateTime.now().microsecondsSinceEpoch.toString();
    final database = DatabaseHelper.instance;
    final id = await database.insertContact(
      Contact(
        name: 'Test contact $marker',
        phoneNumber: '555-0100',
        email: 'before-$marker@example.com',
        address: 'Old address',
      ).toMap(),
    );

    try {
      final updatedCount = await database.updateContact(
        Contact(
          id: id,
          name: 'Updated contact $marker',
          phoneNumber: '555-0101',
          email: 'after-$marker@example.com',
          address: 'New address',
        ),
      );
      final savedContact = (await database.getContact()).singleWhere(
        (contact) => contact.id == id,
      );

      expect(updatedCount, 1);
      expect(savedContact.name, 'Updated contact $marker');
      expect(savedContact.phoneNumber, '555-0101');
      expect(savedContact.email, 'after-$marker@example.com');
      expect(savedContact.address, 'New address');
    } finally {
      final db = await database.database;
      await db.delete('contact_list', where: 'id = ?', whereArgs: [id]);
    }
  });
}
