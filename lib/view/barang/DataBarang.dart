import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:inven_lab/Loadingpage.dart';
import 'dart:convert';
import 'package:inven_lab/model/BarangModel.dart';
import 'package:inven_lab/model/api.dart';
import 'package:inven_lab/view/barang/EditBarang.dart';
import 'package:inven_lab/view/barang/TambahBarang.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataBarang extends StatefulWidget {
  @override
  State<DataBarang> createState() => _DataBarangState();
}

class _DataBarangState extends State<DataBarang> {
  var loading = false;
  final list = [];
  String? LvlUsr;
  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();

  getPref() async {
    _lihatData();
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      LvlUsr = pref.getString("level");
    });
  }

  Future<void> _lihatData() async {
    list.clear();
    setState(() {
      loading = true;
    });
    final response = await http.get(Uri.parse(BaseUrl.urlDataBarang));
    if (response.contentLength == 2) {
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new BarangModel(api['no'], api['id_barang'],
            api['nama_barang'], api['nama_jenis'], api['nama_brand']);
        list.add(ab);
      });
      setState(() {
        loading = false;
      });
    }
  }

  _proseshapus(String id) async {
    final response = await http
        .post(Uri.parse(BaseUrl.urlHapusBarang), body: {"id_barang": id});
    final data = jsonDecode(response.body);
    int value = data['success'];
    String pesan = data['message'];
    if (value == 1) {
      setState(() {
        _lihatData();
      });
    } else {
      print(pesan);
      dialogHapus(pesan);
    }
  }

  dialogHapus(String pesan) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      headerAnimationLoop: false,
      title: 'ERROR',
      desc: pesan,
      btnOkOnPress: () {},
      btnOkIcon: Icons.cancel,
      btnOkColor: Colors.red,
    ).show();
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 41, 69, 91),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                "Data Barang",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // print("tambah jenis");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => new TambahBarang(_lihatData)));
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 41, 69, 91),
      ),
      body: RefreshIndicator(
          onRefresh: _lihatData,
          key: _refresh,
          child: loading
              ? LoadingPage()
              : ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, i) {
                    final x = list[i];
                    return Container(
                      margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                      child: Card(
                        color: const Color.fromARGB(255, 250, 248, 246),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                x.nama_barang.toString() +
                                    " ( " +
                                    x.nama_brand.toString() +
                                    " )",
                              ),
                              trailing: Wrap(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        // edit
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditBarang(x, _lihatData)));
                                      },
                                      icon: Icon(Icons.edit)),
                                  if (LvlUsr == "1") ...[
                                    IconButton(
                                        onPressed: () {
                                          // delete
                                          _proseshapus(x.id_barang);
                                        },
                                        icon: Icon(Icons.delete))
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )),
    );
  }
}
