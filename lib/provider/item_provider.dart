import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:folkatech_test/model/item_model.dart';
import 'package:http/http.dart' as http;

class ItemProvider extends ChangeNotifier {
  List<Item> listItem = [];
  int requestStatus = 0;

  void loadData() async {
    requestStatus = 0;
    notifyListeners();

    //http Request for fetch data Item
    const String url =
        "https://mocki.io/v1/52c41978-6e31-4ea3-b917-01899e3ed373";

    try {
      var request = await http.get(
        Uri.parse(url),
        headers: {
          'content-type': 'application/json',
        },
      );

      print('GET REQUEST TO $url');
      print('----------------response------------------');
      print(request.body);
      print('------------------------------------------');

      if (request.statusCode == 200) {
        List<Item> listData = [];
        final dataRaw = json.decode(request.body);
        for (var i = 0; i < dataRaw.length; i++) {
          listData.add(Item.fromJson(dataRaw[i]));
        }
        requestStatus = 1;
        listItem = listData;

        notifyListeners();
      } else {
        requestStatus = 2;

        notifyListeners();
      }
    } catch (e) {
      print(e);
      requestStatus = 2;

      notifyListeners();
    }

    requestStatus = 1;
    notifyListeners();
  }
}
