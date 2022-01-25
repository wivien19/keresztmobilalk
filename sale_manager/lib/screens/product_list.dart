import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:sale_manager/providers/counter_provider.dart';
import 'package:sale_manager/screens/info.dart';
import 'package:sale_manager/screens/my_location.dart';
import 'package:sale_manager/screens/photo_taker.dart';
import 'package:sale_manager/screens/profile_picture.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '/screens/add_product.dart';
import '/product.dart';
import 'package:hive/hive.dart';

class ProductListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProductListScreenState();
  }
}

class ProductListScreenState extends State<ProductListScreen> {
  List<Product> listProducts = [];
  Color _color = Colors.white;

  void getProducts() async {
    final box = await Hive.openBox<Product>('product2');
    setState(() {
      listProducts = box.values.toList();
    });
  }

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.sales.toString(), textAlign: TextAlign.left,),
          backgroundColor: Colors.pinkAccent[100],
          actions: <Widget>[
            IconButton(
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                icon: Icon(Icons.delete),
                color: _color,
                onPressed: () {
                  setState(() => _color = Colors.green);
                }),
            Text("${context.watch<Counter>().count}"),
            IconButton(
                icon: Icon(Icons.camera_alt),
                onPressed: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => TakeProfilePictureScreen()));
                }),
            IconButton(
              icon: Icon(Icons.person),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ProfilePicture()));
              },
            ),
            IconButton(
              icon: Icon(Icons.location_on),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => MyLocation()));
              },
            ),
            IconButton(
              icon: Icon(Icons.add),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ProductCard(
                            item: Product(
                                product_name: "",
                                product_type: "",
                                product_price: "",
                                product_with: ""))));
              },
            ),
            IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Infos()));
              },
            ),
          ],
        ),
        body: Container(
            padding: EdgeInsets.all(15),
            child: ListView.builder(
                itemCount: listProducts.length,
                itemBuilder: (context, position) {
                  Product getProduct = listProducts[position];
                  var name = getProduct.product_name;
                  var type = getProduct.product_type;
                  var price = getProduct.product_price;
                  var withP = getProduct.product_with;
                  return Card(
                    elevation: 8,
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  " ${AppLocalizations.of(context)!.type.toString()} : $type  | ${AppLocalizations.of(context)!.price.toString()}: $price \$",
                                  style: TextStyle(fontSize: 18),
                                  maxLines: 2,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text("${name} ",
                                    style: TextStyle(fontSize: 18)),
                                Text("${withP} ",
                                    style: TextStyle(fontSize: 18))
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              AnimatedContainer(
                                  duration: Duration(seconds: 1),
                                  color: _color,
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.pinkAccent[100],
                                      ),
                                      onPressed: () {
                                        final box =
                                            Hive.box<Product>('product2');
                                        box.deleteAt(position);
                                        setState(() =>
                                            {listProducts.removeAt(position)});
                                        setState(() => _color = Colors.black);
                                        context.read<Counter>().increment();
                                      }))
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                })),
      ),
    );
  }
}
