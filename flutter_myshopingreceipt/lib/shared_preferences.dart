import 'dart:convert';

import 'package:flutter_myshopingreceipt/const/general.dart';
import 'package:flutter_myshopingreceipt/nvvm/model/item_model.dart';
import 'package:flutter_myshopingreceipt/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  static Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  static Future<Object> saveItemList(List<ItemModel> items) async {
    var pref = await _pref;
    return await pref
        .setString(
          AppConst.PREF_ITEMLIST_KEY,
          json.encode(
            ItemModel.itemListToMap(items),
          ),
        )
        .then(
          (value) => ServicesSuccess(
            code: AppConst.CODE_PROCESS_SUCCESS,
            response: "Save user data success!",
          ),
          onError: (error) => ServicesFailure(
            code: AppConst.CODE_UNKWON_ERROR,
            errorResponse: "Unknwon Error!",
          ),
        );
  }

  static Future<Object> getItemList() async {
    var pref = await _pref;
    var data = pref.getString(AppConst.PREF_ITEMLIST_KEY);
    if (data != null)
      return ServicesSuccess(
        code: AppConst.CODE_PROCESS_SUCCESS,
        response: json.decode(data),
      );
    return ServicesFailure(
      code: AppConst.CODE_NULL_RESPONSE,
      errorResponse: "Item List not found!",
    );
  }
}