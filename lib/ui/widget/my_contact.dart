import 'package:contact_app/db/contact_database.dart';
import 'package:contact_app/model/contact.dart';
import 'package:contact_app/ui/widget/edit_contact.dart';
import 'package:flutter/material.dart';

class MyContact extends StatefulWidget {
  const MyContact({super.key});

  @override
  State<MyContact> createState() => _MyContactState();
}

class _MyContactState extends State<MyContact> {
  static const _avatarColors = [
    Color(0xFFE6E9FF),
    Color(0xFFFFE8DC),
    Color(0xFFDDF4E8),
    Color(0xFFFFE6EF),
    Color(0xFFE1F1FA),
    Color(0xFFFFF1D6),
  ];

  String _searchQuery = '';

  Future<void> _editContact(Contact contact) async {
    final contactUpdated = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => EditContact(contact: contact)),
    );

    if (contactUpdated == true && mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFFF7F8FC),
      child: FutureBuilder<List<Contact>>(
        future: DatabaseHelper.instance.getContact(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF5265D8)),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text('Could not load contacts: ${snapshot.error}'),
              ),
            );
          }

          final contacts = snapshot.data ?? [];
          final query = _searchQuery.trim().toLowerCase();
          final filteredContacts = contacts.where((contact) {
            return contact.name.toLowerCase().contains(query) ||
                contact.phoneNumber.toLowerCase().contains(query);
          }).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Contact',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: const Color(0xFF7F4B8A),
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${contacts.length} ${contacts.length == 1 ? 'contact' : 'contacts'}',
                      style: const TextStyle(
                        color: Color(0xFF7D8295),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      onChanged: (value) =>
                          setState(() => _searchQuery = value),
                      decoration: InputDecoration(
                        hintText: 'Search name or number',
                        hintStyle: const TextStyle(color: Color(0xFF969BAD)),
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: Color(0xFF858BA0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Color(0xFFEBEDF3),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Color(0xFF7886E8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (contacts.isEmpty)
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(28),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 88,
                            height: 88,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE9ECFF),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.people_alt_outlined,
                              size: 42,
                              color: Color(0xFF6878E5),
                            ),
                          ),
                          const SizedBox(height: 18),
                          const Text(
                            'No contacts yet',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF20243A),
                            ),
                          ),
                          const SizedBox(height: 7),
                          const Text(
                            'Add New Contact',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF7D8295),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              else if (filteredContacts.isEmpty)
                const Expanded(
                  child: Center(
                    child: Text(
                      'No Contacts',
                      style: TextStyle(color: Color(0xFF7D8295)),
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                    itemCount: filteredContacts.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final contact = filteredContacts[index];
                      final colorIndex =
                          (contact.name.hashCode & 0x7fffffff) %
                          _avatarColors.length;

                      return Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(18),
                          onTap: () => _editContact(contact),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 13,
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: _avatarColors[colorIndex],
                                  child: Text(
                                    contact.name.isNotEmpty
                                        ? contact.name[0].toUpperCase()
                                        : '?',
                                    style: const TextStyle(
                                      color: Color(0xFF343A60),
                                      fontSize: 19,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        contact.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Color(0xFF25293D),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        contact.phoneNumber,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Color(0xFF7D8295),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                IconButton(
                                  onPressed: () => _editContact(contact),
                                  tooltip: 'Edit ${contact.name}',
                                  icon: const Icon(Icons.edit_outlined),
                                  color: const Color(0xFF6878E5),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
