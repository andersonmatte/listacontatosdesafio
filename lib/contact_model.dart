import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Contact {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String phoneNumber;

  @HiveField(2)
  late String email;

  @HiveField(3)
  late String photo;

  Contact({required this.name, required this.phoneNumber, required this.email, required this.photo});
}
