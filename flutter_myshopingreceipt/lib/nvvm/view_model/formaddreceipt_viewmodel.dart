import 'package:flutter_myshopingreceipt/components/loading_custom.dart';
import 'package:flutter_myshopingreceipt/components/snackbar_custom.dart';
import 'package:flutter_myshopingreceipt/nvvm/model/form_add_receipt_services.dart.dart';
import 'package:flutter_myshopingreceipt/nvvm/model/item_model.dart';
import 'package:flutter_myshopingreceipt/services.dart';
import 'package:flutter_myshopingreceipt/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class FormAddReceiptViewModel extends ChangeNotifier {
  // DateTime? _date;
  String? _imagePath;
  ItemModel? _itemModel;

  // DateTime? get getDate => _date;
  // String? get getImagePath => _imagePath;
  bool get isStateCheck => _itemModel == null;

  void setImagePath(String imagePath) {
    _imagePath = imagePath;
    notifyListeners();
  }

  void onAddReceipt(BuildContext context, String date) async {
    LoadingCustom.show(context);
    await Future.delayed(Duration(seconds: 2));
    if (date.isEmpty) {
      SnackbarCustom.show(
        context,
        snackbarCustomModel: SnackbarCustomModel(
          title: "Form Require",
          message: "Tanggal tidak boleh Kosong!",
          //  + response.errorResponse.toString(),
          status: SnackbarCustomEnum.ERROR,
        ),
      );
    } else if (_imagePath == null || _imagePath!.isEmpty) {
      SnackbarCustom.show(
        context,
        snackbarCustomModel: SnackbarCustomModel(
          title: "Form Require",
          message: "Struk tidak boleh kosong!",
          //  + response.errorResponse.toString(),
          status: SnackbarCustomEnum.ERROR,
        ),
      );
    } else {
      var dateParsed = new DateFormat("dd-MM-yyyy").parse(date);
      var imagePath = _imagePath!;
      var res = await FormAddReceiptServices.getExtractedStruk(imagePath);
      if (res is ServicesSuccess) {
        var items = await AppSharedPreferences.getItemList();
        if (items is ServicesSuccess) {
          var itemList = ItemModel.itemListFromMap(json.decode(items.response));
          debugPrint(itemList.length.toString() + "DATA_P_________");
          itemList.add(
            ItemModel(
              id: itemList.length + 1,
              date: dateParsed,
              total: res.response['data'] as int,
            ),
          );
          await AppSharedPreferences.saveItemList(itemList);
          SnackbarCustom.show(
            context,
            snackbarCustomModel: SnackbarCustomModel(
              title: "Extract Struk",
              message: "Extract Struk successfully!",
              status: SnackbarCustomEnum.SUCCESS,
            ),
          );
        } else {
          var itemList = <ItemModel>[];
          itemList.add(
            ItemModel(
              id: itemList.length + 1,
              date: dateParsed,
              total: res.response['data'] as int,
            ),
          );
          await AppSharedPreferences.saveItemList(itemList);
          SnackbarCustom.show(
            context,
            snackbarCustomModel: SnackbarCustomModel(
              title: "Extract Struk",
              message: "Extract Struk successfully!",
              status: SnackbarCustomEnum.SUCCESS,
            ),
          );
        }
        Navigator.of(context).pop();
      } else {
        res = res as ServicesFailure;
        SnackbarCustom.show(
          context,
          snackbarCustomModel: SnackbarCustomModel(
            title: "Extract Struk",
            message: "Extract Struk Failed!\n" + res.errorResponse.toString(),
            status: SnackbarCustomEnum.ERROR,
          ),
        );
        debugPrint(res.errorResponse);
      }
    }

    LoadingCustom.dismiss(context);
  }
}
