import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  // ignore: unnecessary_new
  Dio dio = new Dio();

  uploadprofilepicture(filepath) async {
    var formdata = FormData.fromMap(
      {
        "image": await MultipartFile.fromFile(filepath),
      },
    );

    try {
      return await dio.post(
          'http://mobileapp-server.herokuapp.com/uploadProfilePicture',
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

  Future<List> getfavorites(username) async {
    try {
      final res =
          await dio.post('http://mobileapp-server.herokuapp.com/getfavorites',
              data: {
                "username": username,
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

  Future<List> getsubscriptions(username) async {
    try {
      final res = await dio.post(
          'http://mobileapp-server.herokuapp.com/getsubscriptions',
          data: {
            "username": username,
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
      final res = await dio.get(
          'http://mobileapp-server.herokuapp.com/gethomepagecontent',
          queryParameters: {'collectionname': collectionname});
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

  addtofavorites(String username, int id) async {
    try {
      return await dio.post(
          'http://mobileapp-server.herokuapp.com/addtofavorites',
          data: {'username': username, '_id': id},
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

  checkifitsinfavorites(String username, int id) async {
    try {
      return await dio.post(
          'http://mobileapp-server.herokuapp.com/checkifitsinfavorites',
          data: {'username': username, 'mangaid': id},
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

  removefromfavorites(String username, int id) async {
    try {
      return await dio.post(
          'http://mobileapp-server.herokuapp.com/removefromfavorites',
          data: {'username': username, 'mangaid': id},
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
        queryParameters: {'mangaid': mangaid});

    if (res.statusCode == 200) {
      return res.data['array'];
    } else {
      throw Exception();
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
