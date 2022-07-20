import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';

class BankProvider extends ChangeNotifier {
  final String _baseUrl = 'banks.izaris.es';
  String currentLatitud = '';
  String currentLonitud = '';
  List<BankModel> listaBancos = [];
  late BankModel bancoSeleccionado;

 

  Future<List<BankModel>> getListBanks(String coordenadas) async {
    var url = Uri.https(_baseUrl, '/api/find-banks/3/$coordenadas');
    final response = await http.get(url);
    final List data = jsonDecode(response.body);
    listaBancos.clear();
    for (var element in data) {
      final tmp = BankModel.fromMap(element);
      listaBancos.add(tmp);
    }
    return listaBancos;
  }
}
