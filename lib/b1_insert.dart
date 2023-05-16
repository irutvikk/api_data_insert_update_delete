import 'dart:convert';

import 'package:api_data_insert_update_delete/b1_viewdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class b1insert extends StatefulWidget {
  const b1insert({Key? key}) : super(key: key);

  @override
  State<b1insert> createState() => _b1insertState();
}

class _b1insertState extends State<b1insert> {

  b1datainsert? b1;

  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController qty = TextEditingController();
  String type = "";

  @override
  Widget build(BuildContext context) {
    double th = MediaQuery.of(context).size.height;
    double tw = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 70,
              ),
              Container(
                child: Text(
                  "ADD CATEGORY",
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
              Divider(
                height: 10,
              ),
              Text(
                "Name",
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Colors.blueGrey.shade100,
                ),
                style: TextStyle(fontSize: 20),
                controller: name,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Type",
                style: TextStyle(fontSize: 20),
              ),
              Row(
                children: [
                  Radio(
                    activeColor: Colors.blueGrey.shade700,
                    value: "vegetarian",
                    groupValue: type,
                    onChanged: (value) {
                      setState(() {
                        type = value!;
                        print(type);
                      });
                    },
                  ),
                  Text(
                    "Vegetarian",
                  ),
                  Radio(
                    activeColor: Colors.blueGrey.shade700,
                    value: "non-vegetarian",
                    groupValue: type,
                    onChanged: (value) {
                      setState(() {
                        type = value!;
                        print(type);
                      });
                    },
                  ),
                  Text(
                    "Non-vegetarian",
                  ),
                ],
              ),
              Row(
                children: [
                  Radio(
                    activeColor: Colors.blueGrey.shade700,
                    value: "eggatarian",
                    groupValue: type,
                    onChanged: (value) {
                      setState(() {
                        type = value!;
                        print(type);
                      });
                    },
                  ),
                  Text(
                    "Eggatarian",
                  ),
                  Radio(
                    activeColor: Colors.blueGrey.shade700,
                    value: "vegan",
                    groupValue: type,
                    onChanged: (value) {
                      setState(() {
                        type = value!;
                        print(type);
                      });
                    },
                  ),
                  Text(
                    "Vegan",
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Description",
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.blueGrey.shade100,
                ),
                style: TextStyle(fontSize: 20),
                controller: description,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Minimum Qty",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                width: 100,
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    filled: true,
                    fillColor: Colors.blueGrey.shade100,
                  ),
                  style: TextStyle(fontSize: 20),
                  controller: qty,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
              SizedBox(height: 50,),
              GestureDetector(
                onTap: () {
                  datainsert();
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 50,right: 50),
                  height: 60,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade700,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> datainsert() async {
    String namee = name.text;
    String desc = description.text;
    String quantity = qty.text;
    String foodtype = type;
    var url = Uri.parse('http://workfordemo.in/bunch1/insert_category.php?cat_type=$foodtype&cat_name=$namee&cat_description=$desc&cat_qty=$quantity');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var dcode = jsonDecode(response.body);
    b1 = b1datainsert.fromJson(dcode);
    if(b1!.success==1){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.blueGrey.shade700,
        content: Text("Record Inserted",),
      ),);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return b1viewdata();
      },));
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.blueGrey.shade700,
        content: Text("Record Not Inserted"),
      ));
    }

    print(url);
  }
}

class b1datainsert {
  int? success;
  int? catId;
  String? catType;
  String? catName;
  String? catQty;
  String? catDescription;

  b1datainsert(
      {this.success,
        this.catId,
        this.catType,
        this.catName,
        this.catQty,
        this.catDescription});

  b1datainsert.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    catId = json['cat_id'];
    catType = json['cat_type'];
    catName = json['cat_name'];
    catQty = json['cat_qty'];
    catDescription = json['cat_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['cat_id'] = this.catId;
    data['cat_type'] = this.catType;
    data['cat_name'] = this.catName;
    data['cat_qty'] = this.catQty;
    data['cat_description'] = this.catDescription;
    return data;
  }
}
