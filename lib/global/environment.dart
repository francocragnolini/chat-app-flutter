import 'dart:io';

class Environment {
  // Servidor api rest
  static String apiUrl = Platform.isAndroid
      ? 'http://10.0.2.2:3001/api'
      : "http://localhost:3001/api";

  // Servidor de socket
  static String socketUrl =
      Platform.isAndroid ? 'http://10.0.2.2:3001' : 'http://localhost:3001';
}
