import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:async/async.dart';
import 'package:inven_lab/model/BarangModel.dart';
import 'package:inven_lab/model/BrandModel.dart';
import 'package:inven_lab/model/JenisModel.dart';
import 'package:inven_lab/model/api.dart';

class TambahBarang extends StatefulWidget {
  final VoidCallback reload;
  TambahBarang(this.reload);
  @override
  State<TambahBarang> createState() => _TambahBarangState();
}

class _TambahBarangState extends State<TambahBarang> {
  FocusNode myFocusNode = new FocusNode();
  String? barang, jenisB, brandB;
  final _key = new GlobalKey<FormState>();
  JenisModel? _currentJenis;
  final String? linkJenis = BaseUrl.urlDataJenis;
  Future<List<JenisModel>> _fetchJenis() async {
    var response = await http.get(Uri.parse(linkJenis.toString()));
    print('hasil: ' + response.statusCode.toString());
    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<JenisModel> listOfJenis = items.map<JenisModel>((json) {
        return JenisModel.fromJson(json);
      }).toList();
      return listOfJenis;
    } else {
      throw Exception('gagal');
    }
  }

  BrandModel? _currentBrand;
  final String? linkBrand = BaseUrl.urlDataBrand;
  Future<List<BrandModel>> _fetchBrand() async {
    var response = await http.get(Uri.parse(linkBrand.toString()));
    print('hasil: ' + response.statusCode.toString());
    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<BrandModel> listOfBrand = items.map<BrandModel>((json) {
        return BrandModel.fromJson(json);
      }).toList();
      return listOfBrand;
    } else {
      throw Exception('gagal');
    }
  }

  check() {
    final form = _key.currentState;
    if ((form as dynamic).validate()) {
      (form as dynamic).save();
      Simpan();
    }
  }

  Simpan() async {
    try {
      final response = await http.post(
          Uri.parse(BaseUrl.urlTambahBarang.toString()),
          body: {"nama": barang, "brand": brandB, "jenis": jenisB});
      final data = jsonDecode(response.body);
      print(data);
      int code = data['success'];
      String pesan = data['message'];
      print(data);
      if (code == 1) {
        setState(() {
          Navigator.pop(context);
          widget.reload();
        });
      } else {
        print(pesan);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(244, 244, 244, 1),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 41, 69, 91),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  "Tambah Barang",
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              )
            ],
          ),
        ),
        body: Form(
          key: _key,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              TextFormField(
                validator: (e) {
                  if ((e as dynamic).isEmpty) {
                    return "Silahkan isi nama barang";
                  }
                },
                onSaved: (e) => barang = e,
                focusNode: myFocusNode,
                decoration: InputDecoration(
                  labelText: 'Nama Barang',
                  labelStyle: TextStyle(
                      color: myFocusNode.hasFocus
                          ? Colors.blue
                          : Color.fromARGB(255, 32, 54, 70)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 32, 54, 70)),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              FutureBuilder<List<JenisModel>>(
                future: _fetchJenis(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<JenisModel>> snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                            style: BorderStyle.solid,
                            color: Color.fromARGB(255, 32, 54, 70),
                            width: 0.80),
                      ),
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                        items: snapshot.data!
                            .map((listJenis) => DropdownMenuItem(
                                  child: Text(listJenis.nama_jenis.toString()),
                                  value: listJenis,
                                ))
                            .toList(),
                        onChanged: (JenisModel? value) {
                          setState(() {
                            _currentJenis = value;
                            jenisB = _currentJenis!.id_jenis;
                          });
                        },
                        isExpanded: true,
                        hint: Text(jenisB == null
                            ? "Pilih Jenis"
                            : _currentJenis!.nama_jenis.toString()),
                      )));
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              FutureBuilder<List<BrandModel>>(
                future: _fetchBrand(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<BrandModel>> snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                            style: BorderStyle.solid,
                            color: Color.fromARGB(255, 32, 54, 70),
                            width: 0.80),
                      ),
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                        items: snapshot.data!
                            .map((listBrand) => DropdownMenuItem(
                                  child: Text(listBrand.nama_brand.toString()),
                                  value: listBrand,
                                ))
                            .toList(),
                        onChanged: (BrandModel? value) {
                          setState(() {
                            _currentBrand = value;
                            brandB = _currentBrand!.id_brand;
                          });
                        },
                        isExpanded: true,
                        hint: Text(brandB == null
                            ? "Pilih Brand"
                            : _currentBrand!.nama_brand.toString()),
                      )));
                },
              ),
              SizedBox(
                height: 25,
              ),
              MaterialButton(
                color: Color.fromARGB(255, 41, 69, 91),
                onPressed: () {
                  check();
                },
                child: Text(
                  "Simpan",
                  style: TextStyle(color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              )
            ],
          ),
        ));
  }
}
