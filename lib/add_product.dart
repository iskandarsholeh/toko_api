import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:modul6/bmi_result.dart';
import 'package:http/http.dart' as http;
class AddEvent extends StatelessWidget {

  final _formkey =  GlobalKey<FormState>();
  TextEditingController _namaController = TextEditingController();
  TextEditingController _keteranganController = TextEditingController();
  TextEditingController _stokController = TextEditingController();
  TextEditingController _imageURLController = TextEditingController();
  TextEditingController _hargaController = TextEditingController();
  TextEditingController _adminController = TextEditingController();
  Future saveEvent() async{
    final response = await http.post(Uri.parse("http://127.0.0.1:8000/api/produk"), body: {
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
                controller: _namaController,
                decoration: InputDecoration(labelText: "Nama"),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Silahkan Tambahkan Nama Produk";
                  }
                },
              ),
              TextFormField(
                controller: _keteranganController,
                decoration: InputDecoration(labelText: "Keterangan"),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Silahkan Tambahkan keterangan Produk";
                  }
                },
              ),
              TextFormField(
                controller: _stokController,
                decoration: InputDecoration(labelText: "stok"),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Silahkan Tambahkan Stok";
                  }
                },
              ),
              TextFormField(
                controller: _hargaController,
                decoration: InputDecoration(labelText: "Harga"),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Silahkan Tambahkan Harga";
                  }
                },
              ),
              TextFormField(
                controller: _adminController,
                decoration: InputDecoration(labelText: "Admin"),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Silahkan Tambahkan Admin";
                  }
                },
              ),
              TextFormField(
                controller: _imageURLController,
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
                  saveEvent().then((value) => {
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