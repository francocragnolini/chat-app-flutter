import 'dart:convert';

import 'package:chat_app/models/login_response.dart';
import 'package:chat_app/models/usario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../global/environment.dart';

class AuthService with ChangeNotifier {
  // propiedad usuario de tipo Usuario(modelo)
  Usuario? usuario;

  // para evitar realizar otra peticion hasta obtener una respuesta
  bool _autenticando = false;

  // GETTERS
  bool get autenticando => _autenticando;

  // SETTERS
  set autenticando(bool valor) {
    _autenticando = valor;
    notifyListeners();
  }

  //Metodo: retorna un future:
  // toma dos argumentos: password, email de los inputs
  //
  Future<bool> login(String email, String password) async {
    // anular el boton para mandar no mandar otro request
    autenticando = true;

    // se almacena los parametros en el objeto data
    final data = {
      "email": email,
      "password": password,
    };

    // parseo de el enpoint(String) a Uri
    final uri = Uri.parse("${Environment.apiUrl}/login");

    // se realiza el post usando el paquete http
    final resp = await http.post(uri,
        body: jsonEncode(data), headers: {"Content-Type": "application/json"});

    print(resp.body);

    autenticando = false;

    // si la respuesta es correcta
    if (resp.statusCode == 200) {
      // transformo la respuesta del backend(json) a dart
      final loginResponse = loginResponseFromJson(resp.body);
      // instancio el modelo usuario
      usuario = loginResponse.usuario;

      //TODO: guardar token en lugar seguro

      return true;
    } else {
      return false;
    }
  }
}
