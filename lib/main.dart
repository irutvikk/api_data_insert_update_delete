import 'package:api_data_insert_update_delete/b1_insert.dart';
import 'package:api_data_insert_update_delete/testfile.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Testfile(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api Data Operations"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStatePropertyAll(
                    Size(50, 50),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return b1insert();
                    },
                  ));
                },
                child: Text("b1 file api operations",style: TextStyle(fontSize: 20),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStatePropertyAll(
                    Size(50, 50),
                  ),
                ),
                onPressed: () {},
                child: Text("b2 file api operations",style: TextStyle(fontSize: 20),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStatePropertyAll(
                    Size(50, 50),
                  ),
                ),
                onPressed: () {},
                child: Text("b3 file api operations",style: TextStyle(fontSize: 20),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
