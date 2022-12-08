import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../routes/index.dart' as route;

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group('GET /', () {
    test(
      'json test',
      () {
        const jsonTest = '{"brand":"Toyota"}';
        final json = jsonDecode(jsonTest) as Map<String, dynamic>?;
        expect(json!.isNotEmpty, true);
      },
    );

    test('responds with a 200 and "Welcome to Dart Frog!".', () {
      final context = _MockRequestContext();
      final response = route.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.ok));
      expect(
        response.body(),
        completion(equals('Welcome to Dart Frog!')),
      );
    });
  });
}
