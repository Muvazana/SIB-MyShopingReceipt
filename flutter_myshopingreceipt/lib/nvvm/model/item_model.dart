import 'dart:convert';
import 'dart:math';

class ItemModel {
  int? id;
  DateTime date;
  int total;

  ItemModel({
    required this.id,
    required this.date,
    required this.total,
  });

  factory ItemModel.fromMap(Map<String, dynamic> data) => ItemModel(
        id: int.parse(data["id"]),
        date: DateTime.parse(data["date"]),
        total: int.parse(data["total"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id.toString(),
        "date": date.toString(),
        "total": total.toString(),
      };

  static List<ItemModel> dataDummyList({int count = 5}) => List.generate(
        count,
        (index) =>
            ItemModel(id: index, date: DateTime.now(), total: index * 10000),
      );

  static List<ItemModel> itemListFromMap(List<dynamic> str) =>
      List<ItemModel>.from(str.map((x) => ItemModel.fromMap(x)));

  static String itemListToMap(List<ItemModel> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
