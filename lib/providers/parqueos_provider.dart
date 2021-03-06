import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:parkline/api/environment.dart';
//import 'package:parkline/data/slot.dart';
import 'package:parkline/models/response_api.dart';
import 'package:parkline/models/parqueo.dart';
import 'package:parkline/models/slots.dart';

import 'package:http/http.dart' as http;

class ParqueosProvider {
  String _url = Enviroment.API_PARKIATE_KI;

  String _api = '/api/parqueos';

  BuildContext context;

  Future init(BuildContext context) {
    this.context = context;
  }

  // Obtener en base a keyword (busqueda de parqueo)
  Future<List<Parqueo>> buscar(String akeyword) async {
    akeyword = '%${akeyword}%';
    try {
      Uri url = Uri.http(_url, '$_api/search');

      String bodyParams = json.encode({
        'akeyword': akeyword,
      });

      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      print(data);

      Parqueo parqueo = Parqueo.fromJsonList(data);
      //  print(parqueo.toList);
      return parqueo.toList;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  //obtener la infomracion de un parqueo por iod

  Future<ResponseApi> getparkbyid(String id_parqueo) async {
    try {
      Uri url = Uri.http(_url, '$_api/findpark');

      String bodyParams = json.encode({
        'id_parqueo': id_parqueo,
      });

      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);

      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  //Obtener informacion del parqueo con id de Firebase

  Future<ResponseApi> getparkbyidfirebase(String id_parqueo) async {
    try {
      Uri url = Uri.http(_url, '$_api/findfullpark');

      String bodyParams = json.encode({
        'id_parqueo': id_parqueo,
      });

      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);

      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<ResponseApi> getprize(String id_parqueo) async {
    try {
      Uri url = Uri.http(_url, '$_api/prize');

      String bodyParams = json.encode({
        'id_parqueo': id_parqueo,
      });

      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);

      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<ResponseApi> getslots(String id_parqueo) async {
    try {
      Uri url = Uri.http(_url, '$_api/slot');

      String bodyParams = json.encode({
        'id_parqueo': id_parqueo,
      });

      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);

      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<ResponseApi> getreviews(
      String id_parqueo, String nombre_usuario) async {
    try {
      Uri url = Uri.http(_url, '$_api/reviews');

      String bodyParams = json
          .encode({'id_parqueo': id_parqueo, 'nombre_usuario': nombre_usuario});

      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);

      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<ResponseApi> login(String email, String password) async {
    try {
      Uri url = Uri.http(_url, '$_api/login');

      String bodyParams = json.encode({'email': email, 'password': password});

      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);

      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<ResponseApi> findparkamount(
      String id_duenio, String id_parqueo) async {
    try {
      Uri url = Uri.http(_url, '$_api/findparkamount');

      String bodyParams =
          json.encode({'id_duenio': id_duenio, 'id_parqueo': id_parqueo});

      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);

      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<ResponseApi> finddueniobyemail(String correoo) async {
    try {
      Uri url = Uri.http(_url, '$_api/dueniobyemail');

      String bodyParams = json.encode({'correoo': correoo});

      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);

      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<ResponseApi> finddueniobyid(String id_duenio) async {
    try {
      Uri url = Uri.http(_url, '$_api/dueniobyid');

      String bodyParams = json.encode({'id_duenio': id_duenio});

      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);

      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  //Obteniendo todos los slots de un parqueo

  Future<List<Slot>> allslots(String id_parqueo) async {
    try {
      Uri url = Uri.http(_url, '$_api/allslots');

      String bodyParams = json.encode({
        'id_parqueo': id_parqueo,
      });

      Map<String, String> headers = {'Content-type': 'application/json'};

      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      print(data);

      Slot slot = Slot.fromJsonList(data);
      print(slot.toList);
      return slot.toList;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}
