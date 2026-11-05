import 'package:contact_app/db/contact_database.dart';
import 'package:contact_app/model/contact.dart';
import 'package:contact_app/ui/widget/contact_form_field.dart';
import 'package:flutter/material.dart';

class EditContact extends StatefulWidget {
  const EditContact({required this.contact, super.key});

  final Contact contact;

  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final TextEditingController _addressController;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.contact.name);
    _phoneController = TextEditingController(text: widget.contact.phoneNumber);
    _emailController = TextEditingController(text: widget.contact.email);
    _addressController = TextEditingController(text: widget.contact.address);
  }

  Future<void> _saveContact() async {
    if (_isSaving) return;
    setState(() => _isSaving = true);
    try {
      final updatedCount = await DatabaseHelper.instance.updateContact(
        Contact(
          id: widget.contact.id,
          name: _nameController.text.trim(),
          phoneNumber: _phoneController.text.trim(),
          email: _emailController.text.trim(),
          address: _addressController.text.trim(),
        ),
      );
      if (!mounted) return;
      if (updatedCount == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('This contact could not be found.')),
        );
        return;
      }
      Navigator.pop(context, true);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not update contact: $error')),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final name = _nameController.text.trim();

    return Scaffold(
      backgroundColor: contactPageBackground,
      appBar: AppBar(
        backgroundColor: contactPageBackground,
        foregroundColor: const Color(0xFF20243A),
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Edit contact',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            onPressed: _isSaving ? null : _saveContact,
            tooltip: 'Save changes',
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
              child: CircleAvatar(
                radius: 46,
                backgroundColor: const Color(0xFFE6E9FF),
                child: Text(
                  name.isNotEmpty ? name[0].toUpperCase() : '?',
                  style: const TextStyle(
                    color: Color(0xFF343A60),
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Update contact details',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF20243A),
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Your changes will appear in your contact list.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF7D8295), fontSize: 14),
            ),
            const SizedBox(height: 28),
            ContactFormField(
              controller: _nameController,
              label: 'Name',
              icon: Icons.person_outline_rounded,
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 14),
            ContactFormField(
              controller: _phoneController,
              label: 'Phone number',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 14),
            ContactFormField(
              controller: _emailController,
              label: 'Email',
              icon: Icons.mail_outline_rounded,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 14),
            ContactFormField(
              controller: _addressController,
              label: 'Address',
              icon: Icons.location_on_outlined,
              keyboardType: TextInputType.streetAddress,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _isSaving ? null : _saveContact,
              icon: const Icon(Icons.check_rounded),
              label: Text(_isSaving ? 'Saving...' : 'Save changes'),
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
