import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class AppApi {
  AppApi(this.store);

  DbCollection store;

  Handler get router {
    final app = Router();

    app.get('/logindb', (Request req) async {});

    return app;
  }
}
