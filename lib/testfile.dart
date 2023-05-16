import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Testfile extends StatelessWidget {

  Future<List> myapi() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/comments');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    List mylist = json.decode(response.body);

    return mylist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Testing")),
      body: FutureBuilder(
        future: myapi(),
        builder: (context, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text("${snapshot.data![index]['name']}"),
                subtitle: Text("${snapshot.data![index]['email']}"),
              ),
            );
          },
          );
        }else if(snapshot.hasError){
          return Center(child: Text("error"),);
        }
        else{
          return Center(child: Text("getting data"),);
        }
      },),
    );
  }
}
