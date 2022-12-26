import 'package:flutter/material.dart';

import '../Models/product_model.dart';

class ManageProductWidget extends StatelessWidget {
  const ManageProductWidget({Key? key, required this.product})
      : super(key: key);
  final Data product;

  @override
  Widget build(BuildContext context) {
    // List<Data>? product;
    return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: MediaQuery.of(context).size.height / 13,
                width: MediaQuery.of(context).size.height / 13,
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Image.network(
                  product.images![0].varImageUrl!,
                  fit: BoxFit.cover,
                )),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.varTitle ?? ''),
                  Text("subtitle"),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(child: Text(product.newPrice ?? '')),
                      Container(
                          margin: EdgeInsets.zero,
                          padding: EdgeInsets.all(4),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Icon(Icons.edit_location_alt_sharp,
                              color: Colors.green.shade900)),
                      SizedBox(width: 8),
                      Container(
                          margin: EdgeInsets.zero,
                          padding: EdgeInsets.all(4),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Icon(Icons.dangerous,
                              color: Colors.red.shade900)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
