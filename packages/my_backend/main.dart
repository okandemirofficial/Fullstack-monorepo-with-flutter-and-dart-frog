import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'services/isar_service.dart';

Future<HttpServer> run(
  Handler handler,
  InternetAddress ip,
  int port,
) async {
  await IsarService.initAsync();

  return serve(handler, ip, port);
}
