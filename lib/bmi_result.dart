import 'package:flutter/material.dart';
import 'package:modul6/home_view.dart';
import 'package:modul6/add_product.dart';
import 'package:modul6/edit_product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

// class MainPage extends StatefulWidget {
//   @override
//   _MainPageState createState() => _MainPageState();
// }
//
// class _MainPageState extends State<MainPage> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyDashboard(),
//     );
//   }
// }

class MyDashboard extends StatefulWidget {
  const MyDashboard({
    Key key,
  }) : super(key: key);

  @override
  _MyDashboardState createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  Future futureData;
  SharedPreferences logindata;
  String username, nama;
  String foto = "20210605033456.png";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
    futureData = getProduct();
  }

  final String url = 'http://127.0.0.1:8000/api/dataproduk/';

  Future getProduct() async {
    var response = await http.get(Uri.parse(url));
    return json.decode(response.body);
    // return jsonResponse.map((data) => new Data.fromJson(data)).toList();

    // final response =
    // await http.get(Uri.https('127.0.0.1:8000', 'api/dataproduk'));
    // if (response.statusCode == 200) {
    //   List jsonResponse = json.decode(response.body);
    //   return jsonResponse.map((data) => new Data.fromJson(data)).toList();
    // } else {
    //   throw Exception('Unexpected error occured!');
    // }
  }

  Future deleteProduct(String id) async {
    String uri = "http://127.0.0.1:8000/api/hapusproduk/" + id;

    var response = await http.delete(Uri.parse(uri));
    return json.decode(response.body);
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username');
      nama = logindata.getString('fullname');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddEvent()));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("CRUD   " + "Welcome : " + "$nama"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              logindata.setBool('login', true);
                      Navigator.pushReplacement(context,
                          new MaterialPageRoute(builder: (context) => MyLoginPage()));
            },
          )

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: FutureBuilder(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data['data'].length,
                  itemBuilder: (context, index) {
                    return Container(
                        height: 100,
                        child: Card(
                          elevation: 5,
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                padding: EdgeInsets.all(5),
                                height: 120,
                                width: 120,
                                child: Image.network(
                                  snapshot.data['data'][index]['foto'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Column(
                                children: [
                                  Text("Nama Produk : " +
                                      snapshot.data['data'][index]
                                          ['nama_produk']),
                                  Text("Deskrirpsi Produk : " +
                                      snapshot.data['data'][index]
                                          ['deskripsi']),
                                  Text("Stok Produk : " +
                                      snapshot.data['data'][index]['stok']
                                          .toString()),
                                  Text("Harga Produk : " +
                                      snapshot.data['data'][index]['harga']
                                          .toString()),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context, MaterialPageRoute(builder: (context) => EditEvent(product: snapshot.data['data'][index],)));
                                        },
                                        child: Icon(Icons.edit),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          deleteProduct(snapshot.data['data']
                                                      [index]['id']
                                                  .toString())
                                              .then((value) {
                                            setState(() {});
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "Event Berhasil dihapus")));
                                          });
                                        },
                                        child: Icon(Icons.delete),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ));
                  });

              // Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //
              //
              //        Text(
              //         'WELCOME  $username ' + snapshot.data['data'][0]['nama_produk'] ,
              //         style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              //       ),
              //     Text(
              //       '$nama',
              //       style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              //     ),
              //     ElevatedButton(
              //       onPressed: () {
              //         logindata.setBool('login', true);
              //         Navigator.pushReplacement(context,
              //             new MaterialPageRoute(builder: (context) => MyLoginPage()));
              //       },
              //       child: Text('LogOut'),
              //     )
              //   ],
              // );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
