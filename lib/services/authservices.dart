import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  Dio dio = new Dio();

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

  Future<List> getfavorites(username) async {
    //try {
    final res =
        await dio.post('http://mobileapp-server.herokuapp.com/getfavorites',
            data: {
              "username": username,
            },
            options: Options(contentType: Headers.formUrlEncodedContentType));
    return res.data['array'];
    /* } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.response!.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } */
  }

  Future<List> getsubscriptions(username) async {
    //try {
    final res =
        await dio.post('http://mobileapp-server.herokuapp.com/getsubscriptions',
            data: {
              "username": username,
            },
            options: Options(contentType: Headers.formUrlEncodedContentType));
    return res.data['array'];
    /* } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.response!.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } */
  }

  Future<List> getallmangas() async {
    final res =
        await dio.get('http://mobileapp-server.herokuapp.com/getallmangas');
    return res.data['array'];
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
