import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:parkline/api/environment.dart';
import 'package:parkline/models/parkingslots.dart';
import 'package:parkline/models/response_api.dart';
import 'package:parkline/models/parqueo.dart';
import 'package:http/http.dart' as http;

class SlotsProvider {
  String _url = 'parkiate-ki-default-rtdb.firebaseio.com/Parking_Status';

  String _api = '/Parking_Status';

  BuildContext context;

  Future init(BuildContext context) {
    this.context = context;
  }

  // Obtener en base a keyword (busqueda de parqueo)
  Future<Parkingslots> buscar() async {
    
    try {
      Uri url = Uri.https(_url, 'parqueo1.json');




      final res = await http.get(url);
      final data = json.decode(res.body);
      print(data);

      Parkingslots slots = Parkingslots.fromJson(data);
      print(slots);
      return slots;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  
}
