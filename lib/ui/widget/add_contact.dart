import 'package:contact_app/db/contact_database.dart';
import 'package:contact_app/model/contact.dart';
import 'package:contact_app/ui/widget/contact_form_field.dart';
import 'package:flutter/material.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  bool _isSaving = false;

  Future<void> addContact() async {
    if (_isSaving) return;
    setState(() => _isSaving = true);
    try {
      await DatabaseHelper.instance.insertContact(
        Contact(
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          phoneNumber: numberController.text.trim(),
          address: addressController.text.trim(),
        ).toMap(),
      );
      if (!mounted) return;
      Navigator.pop(context, true);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not save contact: $error')));
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    numberController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: contactPageBackground,
      appBar: AppBar(
        backgroundColor: contactPageBackground,
        foregroundColor: const Color(0xFF20243A),
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'New contact',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            onPressed: _isSaving ? null : addContact,
            tooltip: 'Save contact',
            icon: const Icon(Icons.check_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 92,
                height: 92,
                decoration: const BoxDecoration(
                  color: Color(0xFFE6E9FF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person_add_alt_1_rounded,
                  color: contactAccent,
                  size: 42,
                ),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Create a contact',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF20243A),
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Add their details so you can find them anytime.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF7D8295), fontSize: 14),
            ),
            const SizedBox(height: 28),
            ContactFormField(
              controller: nameController,
              label: 'Name',
              icon: Icons.person_outline_rounded,
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 14),
            ContactFormField(
              controller: numberController,
              label: 'Phone number',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 14),
            ContactFormField(
              controller: emailController,
              label: 'Email',
              icon: Icons.mail_outline_rounded,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 14),
            ContactFormField(
              controller: addressController,
              label: 'Address',
              icon: Icons.location_on_outlined,
              keyboardType: TextInputType.streetAddress,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _isSaving ? null : addContact,
              icon: const Icon(Icons.check_rounded),
              label: Text(_isSaving ? 'Saving...' : 'Save contact'),
              style: FilledButton.styleFrom(
                backgroundColor: contactAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
