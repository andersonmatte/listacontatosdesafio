import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'contact_model.dart';

class ContactListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Contatos'),
      ),
      body: FutureBuilder(
        future: Hive.openBox('contacts'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final contactsBox = Hive.box('contacts');
            final contacts = contactsBox.values.toList();

            return ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index] as Contact;
                return ListTile(
                  title: Text(contact.name),
                  subtitle: Text(contact.phoneNumber),
                  leading: Image.network(contact.photo),
                );
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
