import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'contact_list_screen.dart';
import 'contact_model.adapter.dart';
import 'contact_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(ContactAdapter());
  await Hive.openBox('contacts');
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AddContactScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AddContactScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController photoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Contato'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16.0),
            TextFormField(
              keyboardType: TextInputType.name,
              controller: nameController,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                labelText: 'Nome',
                labelStyle: const TextStyle(color: Colors.blue),
                hintText: 'Informe seu nome',
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12.0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: phoneNumberController,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                labelText: 'Telefone',
                labelStyle: const TextStyle(color: Colors.blue),
                hintText: 'Informe seu telefone',
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12.0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                labelText: 'E-mail',
                labelStyle: const TextStyle(color: Colors.blue),
                hintText: 'Informe seu e-mail',
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12.0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: photoController,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                labelText: 'Foto',
                labelStyle: const TextStyle(color: Colors.blue),
                hintText: 'Selecione sua foto',
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12.0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
                child: Container(
              height: 45,
              width: 250,
              margin: const EdgeInsets.only(top: 30.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                onPressed: () {
                  final contact = Contact(
                    name: nameController.text,
                    phoneNumber: phoneNumberController.text,
                    email: emailController.text,
                    photo: photoController.text,
                  );
                  final contactsBox = Hive.box('contacts');
                  try {
                    contactsBox.add(contact);
                    showToast(context, 'Contato Salvo com sucesso!');
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => ContactListScreen()));
                  } catch (e) {
                    showToast(context,
                        'Ocorreu um erro ao incluir o novo vontato: $e');
                  }
                  //Navigator.pop(context);
                },
                child: Text(
                  "Adicionar Contato".toUpperCase(),
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}

void showToast(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
          fontFamily: 'Roboto',
        ),
      ),
      backgroundColor: Colors.blue
          .withOpacity(0.7), // Define a cor de fundo com 50% de transparência
    ),
  );
}
