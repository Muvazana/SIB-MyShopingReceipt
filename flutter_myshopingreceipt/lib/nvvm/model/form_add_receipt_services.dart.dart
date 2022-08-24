

import 'package:flutter_myshopingreceipt/const/general.dart';
import 'package:flutter_myshopingreceipt/services.dart';

class FormAddReceiptServices{
  static Future<Object> getExtractedStruk(String filePath) async {
    var url = Uri.parse("${AppConst.BASE_URL}/upload");
    return await AppServices.baseService(
      url: url,
      body: filePath,
    );
  }
}