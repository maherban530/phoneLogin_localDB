import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_bakers/Widgets/manage_product.dart';

import 'Providers/product_provider.dart';
import 'Widgets/hot_product_widget.dart';
import 'Widgets/recent_order_widget.dart';
import 'Widgets/total_widget.dart';
import 'details.dart';
import 'login.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // String apiData;
  // var apiDatalength;
  // void apiDataGet() async {
  //   http.Response response =
  //       await http.get("https://api.androidhive.info/contacts/");

  //   if (response.statusCode == 200) {
  //     apiData = response.body;
  //     setState(() {
  //       apiDatalength = jsonDecode(apiData)['contacts'];
  //     });
  //   } else {
  //     print(response.statusCode);
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   // apiDataGet();
  // }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProductProvider>(context, listen: false).getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    // if (apiDatalength == null) {
    //   return Center(child: CircularProgressIndicator());
    // }
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Dashboard",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        automaticallyImplyLeading: false,
        centerTitle: false,
        actions: [
          InkWell(
            onTap: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              prefs.setBool('sessiondata', false);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
            child: Container(
                // height: 20,
                width: 40,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Icon(
                  Icons.close,
                  color: Colors.black,
                )),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(14),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  padding: EdgeInsets.zero,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                  childAspectRatio: 7 / 3,
                  children: List.generate(4, (index) {
                    return DashboardCardWidget();
                  })),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recent Order",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Row(
                    children: [
                      Text(
                        "View All",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.green,
                        ),
                      ),
                      Icon(Icons.navigate_next_outlined, color: Colors.green),
                    ],
                  ),
                ],
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return RecentOrderWidget(index: index);
                  }),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Manage Products",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Row(
                    children: [
                      Icon(Icons.add, color: Colors.green),
                      Text(
                        "Add",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Consumer<ProductProvider>(builder: (context, value, child) {
                if (value.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final productData = value.productList;
                return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: productData?.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return ManageProductWidget(
                          product: productData!.data![index]);
                    });
              }),
              SizedBox(height: 30),
              Text(
                "Hot Products",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 10),
              GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  padding: EdgeInsets.zero,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                  childAspectRatio: 7 / 9,
                  children: List.generate(5, (index) {
                    return HotProductWidget();
                  })),
            ],
          ),
        ),
      ),
      // ListView.builder(
      //     shrinkWrap: true,
      //     itemCount: apiDatalength.length,
      //     itemBuilder: (context, index) {
      //       return GestureDetector(
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => Details()),
      //           );
      //         },
      //         child: Card(
      //           margin: const EdgeInsets.all(10.0),
      //           child: Padding(
      //             padding: const EdgeInsets.all(10.0),
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Text(apiDatalength[index]['id']),
      //                 Text(apiDatalength[index]['name']),
      //                 Text(apiDatalength[index]['email']),
      //                 Text(apiDatalength[index]['address']),
      //                 Text(apiDatalength[index]['gender']),
      //                 Text(apiDatalength[index]['phone']['mobile']),
      //                 Text(apiDatalength[index]['phone']['home']),
      //                 Text(apiDatalength[index]['phone']['office']),
      //               ],
      //             ),
      //           ),
      //         ),
      //       );
      //     }),
    );
  }
}
