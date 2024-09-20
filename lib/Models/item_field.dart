import 'dart:convert';

class Item {

  final String itemName;
  final List<Map<String,String>> fields;

  Item({required this.itemName, required this.fields});


  

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'itemName': itemName});
    result.addAll({'fields': fields});
  
    return result;
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      itemName: map['itemName'] ?? '',
      fields: List<Map<String,String>>.from(map['fields']?.map((x) => Map<String,String>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) => Item.fromMap(json.decode(source));
}
