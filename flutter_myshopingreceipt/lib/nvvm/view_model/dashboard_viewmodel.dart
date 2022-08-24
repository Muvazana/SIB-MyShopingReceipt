import 'package:flutter_myshopingreceipt/nvvm/model/item_model.dart';
import 'package:flutter_myshopingreceipt/services.dart';
import 'package:flutter_myshopingreceipt/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class DashboardViewModel extends ChangeNotifier {
  int _totalBelanja = 0;

  int get getTotalBelanja => _totalBelanja;

  Future<List<ItemModel>> getDummyItem() async {
    var data = await Future<List<ItemModel>>.delayed(
      const Duration(seconds: 1),
      () => ItemModel.dataDummyList(count: 0),
    );
    this._totalBelanja = data.map((e) => e.total).fold(0, (p, e) => p + e);
    notifyListeners();
    return data;
  }

  Future<List<ItemModel>> getItemListData() async {
    var res = await AppSharedPreferences.getItemList();
    var itemList = <ItemModel>[];
    if (res is ServicesSuccess) {
      itemList = ItemModel.itemListFromMap(json.decode(res.response));
    }
    this._totalBelanja = itemList.length > 0
        ? itemList.map((e) => e.total).fold(0, (p, e) => p + e)
        : 0;
    notifyListeners();
    return itemList;
  }
}
