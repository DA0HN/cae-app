import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  TextEditingController _usuario = TextEditingController();
  TextEditingController get usuario => this._usuario;

  TextEditingController _senha = TextEditingController();
  TextEditingController get senha => this._senha;

  bool _flagEntrar = false;
  bool get flagEntrar => this._flagEntrar;

  set flagEntrar(bool value) {
    _flagEntrar = value;
    update();
  }

  Future<bool> login(String user, String password) async {
    var url = 'https://cae-ifmt.herokuapp.com/login';
    var header = {"Content-Type": "application/json"};

    Map params = {"login": user, "senha": password};
    var _body = json.encode(params);

    var response = await http.post(url, body: _body, headers: header);

    Map usuario = json.decode(response.body);

    var usuarioToken = usuario["token"];

    if (response.statusCode == 200) {
      GetStorage box = GetStorage();
      box.write('token', usuarioToken);
      return true;
    } else {
      return false;
    }
  }
}
