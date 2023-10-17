import 'package:hive/hive.dart';
import 'contact_model.dart';

class ContactAdapter extends TypeAdapter<Contact> {
  @override
  int get typeId => 0; // Deve ser um ID exclusivo para o modelo Contact

  @override
  Contact read(BinaryReader reader) {
    return Contact(
      name: reader.read(),
      phoneNumber: reader.read(),
      email: reader.read(),
      photo: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Contact obj) {
    writer.write(obj.name);
    writer.write(obj.phoneNumber);
    writer.write(obj.email);
    writer.write(obj.photo);
  }
}
