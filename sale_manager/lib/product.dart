import 'dart:collection';
import 'package:hive/hive.dart';

part 'product.g.dart';

@HiveType(typeId: 1,adapterName: "ProductAdapter")
class Product {
  List<Product> _items = [];
  UnmodifiableListView<Product> get items => UnmodifiableListView(_items);
  @HiveField(0)
  String product_name;

  @HiveField(1)
  String product_type;

  @HiveField(2)
  String product_price;

  @HiveField(3)
  String product_with;

  Product({required this.product_name,required this.product_type,required this.product_price, required this.product_with});
}