import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:modul6/bmi_result.dart';
import 'package:http/http.dart' as http;
class EditEvent extends StatelessWidget {
final Map product;

EditEvent({@required this.product});

  final _formkey =  GlobalKey<FormState>();
  TextEditingController _namaController = TextEditingController();
  TextEditingController _keteranganController = TextEditingController();
  TextEditingController _stokController = TextEditingController();
  TextEditingController _imageURLController = TextEditingController();
  TextEditingController _hargaController = TextEditingController();
  TextEditingController _adminController = TextEditingController();
  Future updateEvent() async{
    final response = await http.put(Uri.parse("http://127.0.0.1:8000/api/editproduk/"+ product['id'].toString()), body: {
      "nama_produk":_namaController.text,
      "deskripsi":_keteranganController.text,
      "foto":_imageURLController.text,
      "stok":_stokController.text,
      "harga":_hargaController.text,
      "admin_id":_adminController.text,

    });
    print(response.body);

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Menambahkan Produk"),
      ),
      body: Center(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                controller: _namaController.. text = product['nama_produk'],
                decoration: InputDecoration(labelText: "Nama"),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Silahkan Tambahkan Nama Produk";
                  }
                },
              ),
              TextFormField(
                controller: _keteranganController.. text = product['deskripsi'],
                decoration: InputDecoration(labelText: "Keterangan"),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Silahkan Tambahkan keterangan Produk";
                  }
                },
              ),
              TextFormField(
                controller: _stokController.. text = product['stok'].toString(),
                decoration: InputDecoration(labelText: "stok"),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Silahkan Tambahkan Stok";
                  }
                },
              ),
              TextFormField(
                controller: _hargaController.. text = product['harga'].toString(),
                decoration: InputDecoration(labelText: "Harga"),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Silahkan Tambahkan Harga";
                  }
                },
              ),
              TextFormField(
                controller: _adminController.. text = product['admin_id'].toString(),
                decoration: InputDecoration(labelText: "Admin"),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Silahkan Tambahkan Admin";
                  }
                },
              ),
              TextFormField(
                controller: _imageURLController.. text = product['foto'],
                decoration: InputDecoration(labelText: "Image_Url"),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Silahkan Tambahkan Gambar Event";
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(onPressed: (){
                if(_formkey.currentState.validate()){
                  updateEvent().then((value) => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyDashboard())),
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Event Berhasil ditambah")))
                  });
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                }
              }, child: Text("Simpan"))
            ],
          ),
        ),
      ),
    );
  }
}