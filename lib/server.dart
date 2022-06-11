import 'dart:io';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_hotreload/shelf_hotreload.dart';
import 'package:shelf_router/shelf_router.dart';

void start() async {
  final db = await Db.create(
      'mongodb+srv://AhmetBilalTuran:Ab!159357!Ab@cluster0.zujm3.mongodb.net/mydatabase?retryWrites=true&w=majority');
  await db.open();
  final coll = db.collection('User');

  print('Database Opened');

  const port = 8081;
  final rout = Router();

  rout.get('/', (Request req) {
    return Response.ok('hi');
  });

  final handler = Pipeline().addMiddleware(logRequests()).addHandler(rout);

  withHotreload(() => serve(handler, InternetAddress.anyIPv4, port));
}
