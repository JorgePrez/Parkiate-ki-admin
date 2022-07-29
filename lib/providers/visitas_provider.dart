import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:parkline/api/environment.dart';
import 'package:parkline/models/response_api.dart';
import 'package:parkline/models/visitas_app.dart';
import 'package:http/http.dart' as http;
import 'package:parkline/models/servicioadminimagen.dart';
import 'package:parkline/models/serviciotrue.dart';

class VisitasProvider {
  String _url = Enviroment.API_PARKIATE_KI2;

  String _api = '/Parkiate-web/backend';

  //ejemplo url: {{url2}}/Parkiate-web/backend/getbypark.php?id_parqueo_app=86BE48

  BuildContext context;

  Future init(BuildContext context) {
    this.context = context;
  }

  Future<List<Visitasapp>> getbypark(String id_parqueo) async {
    try {
      Uri url =
          Uri.http(_url, '$_api/getbypark.php?id_parqueo_app=$id_parqueo');
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'ngrok-skip-browser-warning': '40'
      };

      final res = await http.get(url, headers: headers);

      final data = json.decode(res.body);
      Visitasapp user = Visitasapp.fromJsonList(data);
      return user.toList;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

/*

  Future<User> getById(String id) async {
    try {
      Uri url = Uri.http(_url, '$_api/findById/$id');
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser.sessionToken
      };
      final res = await http.get(url, headers: headers);

      if (res.statusCode == 401) {
        // NO AUTORIZADO
        Fluttertoast.showToast(msg: 'Tu sesion expiro');
        new SharedPref().logout(context, sessionUser.id);
      }

      final data = json.decode(res.body);
      User user = User.fromJson(data);
      return user;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }*/
}
