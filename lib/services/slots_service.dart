import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:parkline/models/slots.dart';

class SlotsService extends ChangeNotifier {
  final String _baseUrl = 'parkiate-ki-default-rtdb.firebaseio.com/Parking_Status';
  final List<Slots> slots = [];
  bool isLoading = true;
  final storage = new FlutterSecureStorage();

  ParqueosService() {
    this.loadSlots();
  }

  Future<List<Slots>> loadSlots() async {
    this.isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, '-Mq73KmXyn-fx7tlnIQn.json');

    /* final url = Uri.https(_baseUrl, 'parqueos.json',
        {'auth': await storage.read(key: 'token') ?? ''});*/
    final resp = await http.get(url);

    final Map<String, dynamic> slotsMap = json.decode(resp.body);
        print("sasaadasdasdasd");

    print(slotsMap);

    //se me hace mas facil que no fuera un mapa sino fuera un listado

    slotsMap.forEach((key, value) {
      final tempslot = Slots.fromMap(value);
      tempslot.id = key;
      this.slots.add(tempslot);
    });

    // print(this.parqueos[0].nombreParqueo);

    //this.isLoading = false;
    notifyListeners();

    return this.slots;
  }
}
