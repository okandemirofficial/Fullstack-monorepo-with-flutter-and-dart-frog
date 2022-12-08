import 'dart:convert';

import 'package:common_models/common_models.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:isar/isar.dart';

import '../services/isar_service.dart';

Future<Response> onRequest(RequestContext context) async {
  final controller = CarController();

  final body = await context.request.body();
  Map<String, dynamic>? json;

  print(body);

  if (body.isNotEmpty) {
    json = await jsonDecode(body) as Map<String, dynamic>?;
  }

  switch (context.request.method) {
    case HttpMethod.get:
      return controller.get();
    case HttpMethod.post:
      return controller.post(json);
    case HttpMethod.delete:
      return controller.delete(json);
    // ignore: no_default_cases
    default:
      return controller.get();
  }
}

class CarController {
  Future<Response> get() async {
    //final isar = await Isar.open([CarSchema]);
    final cars = await IsarService.isar.cars.where().findAll();
    //final cars = [Car('toyota'), Car('Hyundai')];

    return Response.json(
      body: {
        'cars': cars
            .map(
              (e) => e.toJson(),
            )
            .toList(),
      },
    );
  }

  Future<Response> post(Map<String, dynamic>? json) async {
    if (json == null) {
      return Response(statusCode: 404, body: "Car can't be null");
    } else {
      await IsarService.isar.writeTxn(() async {
        await IsarService.isar.cars.put(Car.fromJson(json));
      });

      return Response();
    }
  }

  Future<Response> delete(Map<String, dynamic>? json) async {
    if (json == null) {
      return Response(statusCode: 400, body: "Car can't be null");
    } else {
      await IsarService.isar.writeTxn(() async {
        final car = Car.fromJson(json);

        if (car.id == null) {
          return Response(statusCode: 400, body: "Car id can't be null");
        } else {
          await IsarService.isar.cars.delete(car.id!);
        }
      });

      return Response();
    }
  }
}
