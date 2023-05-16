import 'dart:convert';

import 'package:api_data_insert_update_delete/b1_update.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class b1viewdata extends StatefulWidget {
  const b1viewdata({Key? key}) : super(key: key);

  @override
  State<b1viewdata> createState() => _b1viewdataState();
}

class _b1viewdataState extends State<b1viewdata> {

  viewallcategory? va;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewmydata();
  }

  Future<void> viewmydata() async {
    var url = Uri.parse('http://workfordemo.in/bunch1/get_category.php');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var dcode = jsonDecode(response.body);
    va = viewallcategory.fromJson(dcode);

    Future.delayed(Duration()).then((value) {

        setState(() {
        });
    });
  }
  @override
  Widget build(BuildContext context) {
    return va != null
        ? Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Container(
                    child: Text(
                      "ALL CATEGORY",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    alignment: Alignment.center,
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade700,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Divider(),
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.all(0),
                      itemCount: va!.categoryList!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {

                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                        return b1update(va!.categoryList![index]);
                            },));
                          },
                          child: Card(
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Id : ${va!.categoryList![index].catId}"),
                                  Text("Name : ${va!.categoryList![index].catName}"),
                                  Text("Description : ${va!.categoryList![index].catDescription}"),
                                  Text("Minimum Quantity : ${va!.categoryList![index].catQty}"),
                                  Text("Date : ${va!.categoryList![index].catCreated}"),
                                ],
                              ),
                            )
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        : Container(color: Colors.white,
          child: Center(
          child: CircularProgressIndicator(),
            ),
        );
  }
}

class viewallcategory {
  int? success;
  List<CategoryList>? categoryList;

  viewallcategory({this.success, this.categoryList});

  viewallcategory.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['category_list'] != null) {
      categoryList = <CategoryList>[];
      json['category_list'].forEach((v) {
        categoryList!.add(new CategoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.categoryList != null) {
      data['category_list'] =
          this.categoryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryList {
  String? catId;
  String? catName;
  String? catQty;
  String? catDescription;
  String? catCreated;

  CategoryList(
      {
        this.catId,
      this.catName,
      this.catQty,
      this.catDescription,
      this.catCreated});

  CategoryList.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
    catName = json['cat_name'];
    catQty = json['cat_qty'];
    catDescription = json['cat_description'];
    catCreated = json['cat_created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cat_id'] = this.catId;
    data['cat_name'] = this.catName;
    data['cat_qty'] = this.catQty;
    data['cat_description'] = this.catDescription;
    data['cat_created'] = this.catCreated;
    return data;
  }
}
