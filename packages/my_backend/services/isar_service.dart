import 'package:common_models/common_models.dart';
import 'package:isar/isar.dart';

///It's a simple service which could
/// implement to structured singleton packages like get.it
class IsarService {
  // ignore: unused_element
  IsarService._();

  static late Isar isar;

  static Future<void> initAsync() async {
    isar = await Isar.open([CarSchema]);
  }
}
