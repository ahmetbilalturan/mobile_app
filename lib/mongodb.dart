import 'dart:developer';

import 'package:shelf_router/shelf_router.dart';
import 'package:test_app/constants.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static connect() async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    var status = db.serverStatus();
    print(status);
    print('hello');
    var coll = db.collection(COLLECTION_NAME);
    print(await coll.find('Nickname: DawnTrick').toList());

    const port = 8081;
    final app = Router();
  }
}
