import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import '../screens/product_list.dart';
import '/product.dart';
import 'package:hive/hive.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../product.dart';

import 'contact_chooser.dart';

class ProductCard extends StatefulWidget {
  final Product item;

  ProductCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final TextEditingController controllerName = new TextEditingController();

  final TextEditingController controllerType = new TextEditingController();

  final TextEditingController controllerPrice = new TextEditingController();

  final TextEditingController controllerWith = new TextEditingController();

  Future<Contact> chooseAContact(BuildContext context) async {
    var contact = await Navigator.push(
        context, MaterialPageRoute(builder: (_) => ContactChooser()));

    if (contact == null) {
      await showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text('Please Choose A Contact!'),
                content: Text('Please'),
              ));

      return await chooseAContact(context);
    }

    return contact;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("${AppLocalizations.of(context)!.add.toString()}"),
          backgroundColor: Colors.pinkAccent[100],
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(25),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("${AppLocalizations.of(context)!.name.toString()}: ",
                          style: TextStyle(fontSize: 18)),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextField(
                          controller: controllerName,
                          textInputAction: TextInputAction.next,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("${AppLocalizations.of(context)!.type.toString()}: ",
                          style: TextStyle(fontSize: 18)),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextField(
                            controller: controllerType,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress),
                      )
                    ],
                  ),
                  SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                          "${AppLocalizations.of(context)!.price.toString()}: ",
                          style: TextStyle(fontSize: 18)),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextField(
                          controller: controllerPrice,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                          "${AppLocalizations.of(context)!.with2.toString()}: ",
                          style: TextStyle(fontSize: 18)),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextField(
                            controller: controllerWith,
                            textInputAction: TextInputAction.next),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      RaisedButton.icon(
                        onPressed: () async {
                          var contact = await chooseAContact(context);
                          setState(() {
                            widget.item.product_with = contact.displayName!;
                            controllerWith.text = contact.displayName!;
                          });
                        },
                        icon: Icon(Icons.contacts),
                        label: Text(widget.item.product_with != null
                            ? widget.item.product_with
                            : "anonim"),
                      ),
                      SizedBox(height: 100),
                      MaterialButton(
                          color: Colors.pinkAccent[100],
                          child: Text("Ok",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                          onPressed: () async {
                            var getName = controllerName.text;
                            var getType = controllerType.text;
                            var getPrice = controllerPrice.text;
                            var getWith = controllerWith.text;
                            if (getName.isNotEmpty &
                                getType.isNotEmpty &
                                getPrice.isNotEmpty) {
                              Product productInfo = Product(
                                  product_name: getName,
                                  product_type: getType,
                                  product_price: getPrice,
                                  product_with: getWith);

                              var box = await Hive.openBox<Product>('product2');
                              box.add(productInfo);
                            }
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ProductListScreen()),
                                (r) => false);
                          })
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
