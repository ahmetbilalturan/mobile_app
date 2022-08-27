import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  // ignore: unnecessary_new
  Dio dio = new Dio();

  uploadprofilepicture(filepath, userid) async {
    var formdata = FormData.fromMap(
      {"image": await MultipartFile.fromFile(filepath), "userid": userid},
    );
    try {
      return await dio.post('http://10.0.2.2:8080/uploadProfilePicture',
          data: formdata);
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.response!.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  login(username, password) async {
    try {
      return await dio.post('http://mobileapp-server.herokuapp.com/login',
          data: {
            "username": username,
            "password": password,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.response!.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  adduser(username, password, email) async {
    try {
      return await dio.post('http://mobileapp-server.herokuapp.com/adduser',
          data: {
            "username": username,
            "password": password,
            "email": email,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.response!.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  getinfo(usertoken) async {
    try {
      return await dio.get('http://mobileapp-server.herokuapp.com/getinfo',
          options: Options(headers: {"Authorization": 'Bearer $usertoken'}));
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.response!.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  // ignore: no_leading_underscores_for_local_identifiers
  getonefromallmangas(_id) async {
    try {
      final res = await dio.post(
        'http://mobileapp-server.herokuapp.com/findfromallmangas',
        data: {
          "_id": _id,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      return res.data['manga'];
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.response!.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<List> getfavorites(int userID) async {
    try {
      final res =
          await dio.post('http://mobileapp-server.herokuapp.com/getfavorites',
              data: {
                "userID": userID,
              },
              options: Options(contentType: Headers.formUrlEncodedContentType));
      return res.data['array'];
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.response!.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      rethrow;
    }
  }

  Future<List> getsubscriptions(userID) async {
    try {
      final res = await dio.post(
          'http://mobileapp-server.herokuapp.com/getsubscriptions',
          data: {
            "userID": userID,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
      return res.data['array'];
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.response!.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      rethrow;
    }
  }

  Future<List> gethomepagecontent(collectionname) async {
    try {
      final res = await dio.post(
          'http://mobileapp-server.herokuapp.com/gethomepagecontent',
          data: {'collectionName': collectionname});
      return res.data['mangaIDs'];
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.response!.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      rethrow;
    }
  }

  addtofavorites(userID, int id) async {
    try {
      return await dio.post(
          'http://mobileapp-server.herokuapp.com/addtofavorites',
          data: {'userID': userID, 'mangaID': id},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.response!.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  checkifitsinfavorites(int userid, int id) async {
    try {
      return await dio.post(
          'http://mobileapp-server.herokuapp.com/checkifitsinfavorites',
          data: {'userID': userid, 'mangaID': id},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.response!.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<List> gethomepage() async {
    try {
      final res =
          await dio.get('http://mobileapp-server.herokuapp.com/gethomepage');
      return res.data['array'];
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.response!.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      rethrow;
    }
  }

  removefromfavorites(userID, int id) async {
    try {
      return await dio.post(
          'http://mobileapp-server.herokuapp.com/removefromfavorites',
          data: {'userID': userID, 'mangaID': id},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.response!.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<List> getallmangas() async {
    final res =
        await dio.get('http://mobileapp-server.herokuapp.com/getallmangas');

    if (res.statusCode == 200) {
      return res.data['array'];
    } else {
      throw Exception();
    }
  }

  Future<List> getgenre(String genre) async {
    final res = await dio.get('http://mobileapp-server.herokuapp.com/getgenre',
        queryParameters: {'mangagenre': genre});

    if (res.statusCode == 200) {
      return res.data['array'];
    } else {
      throw Exception();
    }
  }

  Future<List> getchapters(int mangaid) async {
    final res = await dio.get(
        'http://mobileapp-server.herokuapp.com/getchapters',
        queryParameters: {'mangaID': mangaid});

    if (res.statusCode == 200) {
      return res.data['array'];
    } else {
      throw Exception();
    }
  }

  Future<List> getartistsmangas(int artistID) async {
    try {
      final res = await dio.post(
        'http://mobileapp-server.herokuapp.com/getartistsmangas',
        data: {'mangaArtistID': artistID},
      );
      if (res.data['success']) {
        return res.data['array'];
      } else {
        Fluttertoast.showToast(
          msg: res.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return List.empty();
      }
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.response!.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      rethrow;
    }
  }

  Future<List> getchapterpages(int mangaID, int chapterID) async {
    try {
      final res = await dio.post(
          'http://mobileapp-server.herokuapp.com/getchapterpages',
          data: {'mangaID': mangaID, 'chapterID': chapterID},
          options: Options(contentType: Headers.formUrlEncodedContentType));
      return res.data['pages'];
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.response!.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      rethrow;
    }
  }

  Future<List> getartist(String artist) async {
    final res = await dio.get('http://mobileapp-server.herokuapp.com/getartist',
        queryParameters: {'mangaartist': artist});
    if (res.statusCode == 200) {
      return res.data['array'];
    } else {
      throw Exception();
    }
  }

  tryserver() async {
    try {
      return await dio.get('http://mobileapp-server.herokuapp.com/testserver');
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.response!.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
