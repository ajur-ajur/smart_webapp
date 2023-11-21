import 'dart:convert';
import 'package:flutter/services.dart';

//Nah kalau ini dia ngebaca file JSON akun (assets/data/accounts.JSON)
late List<Map<String, String>> accounts;

Future<List> accountList() async {
  final String data = await rootBundle.loadString('assets/data/accounts.json');
  final dynamic jsonData = json.decode(data);
  accounts = List<Map<String, String>>.from(jsonData['accounts']);
  return accounts;
}
