import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:parkline/api/environment.dart';
import 'package:parkline/models/response_api.dart';
import 'package:parkline/models/visita.dart';
import 'package:parkline/models/visita_admin.dart';
import 'package:http/http.dart' as http;

class VisitasProvider {
  String _url = Enviroment.API_PARKIATE_KI;

  String _api = '/api/visitas_app';

  BuildContext context;

  Future init(BuildContext context) {
    this.context = context;
  }

  //Trayendo el listado de reseñias por parqueo

  Future<List<Visita>> getbyuser(String id_usuario) async {
    try {
      Uri url = Uri.http(_url, '$_api/getbyuser');

      String bodyParams = json.encode({
        'id_usuario': id_usuario,
      });

      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      print(data);

      Visita visita = Visita.fromJsonList(data);
      print(visita.toList);
      return visita.toList;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<List<Visita>> getbypark(String id_parqueo) async {
    try {
      Uri url = Uri.http(_url, '$_api/getbypark');

      String bodyParams = json.encode({
        'id_parqueo': id_parqueo,
      });

      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      print(data);

      Visita visita = Visita.fromJsonList(data);
      print(visita.toList);
      return visita.toList;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<List<Visita>> getcurrents(String id_parqueo) async {
    try {
      Uri url = Uri.http(_url, '$_api/parkactuales');

      String bodyParams = json.encode({
        'id_parqueo': id_parqueo,
      });

      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      print(data);

      Visita visita = Visita.fromJsonList(data);
      print(visita.toList);
      return visita.toList;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<List<Visita_admin>> all(String id_parqueo) async {
    try {
      Uri url = Uri.http(_url, '$_api/all');

      String bodyParams = json.encode({
        'id_parqueo': id_parqueo,
      });

      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      print(data);

      Visita_admin visita = Visita_admin.fromJsonList(data);
      print(visita.toList);
      return visita.toList;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<List<Visita_admin>> allcurrent(String id_parqueo) async {
    try {
      Uri url = Uri.http(_url, '$_api/allcurrent');

      String bodyParams = json.encode({
        'id_parqueo': id_parqueo,
      });

      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      print(data);

      Visita_admin visita = Visita_admin.fromJsonList(data);
      print(visita.toList);
      return visita.toList;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}
