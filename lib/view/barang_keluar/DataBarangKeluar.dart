import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:inven_lab/Loadingpage.dart';
import 'dart:convert';
import 'package:inven_lab/model/BarangKeluarModel.dart';
import 'package:inven_lab/model/api.dart';
import 'package:inven_lab/view/barang_keluar/DetailBk.dart';
import 'package:inven_lab/view/barang_keluar/TambahBK.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataBarangKeluar extends StatefulWidget {
  @override
  State<DataBarangKeluar> createState() => _DataBarangKeluarState();
}

class _DataBarangKeluarState extends State<DataBarangKeluar> {
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
    final response = await http.get(Uri.parse(BaseUrl.urlDataBK));
    if (response.contentLength == 2) {
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new BarangKeluarModel(
            api['no'],
            api['id_bk'],
            api['id_barang_keluar'],
            api['nama_barang'],
            api['nama_brand'],
            api['jumlah_keluar'],
            api['tgl_keluar'],
            api['keterangan'],
            api['nama']);
        list.add(ab);
      });
      setState(() {
        loading = false;
      });
    }
  }

  _proseshapus(String id) async {
    final response =
        await http.post(Uri.parse(BaseUrl.urlHapusBK), body: {"id": id});
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

  @override
  void initState() {
    super.initState();
    getPref();
  }

  alertHapus(String id) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      context: context,
      dialogType: DialogType.warning,
      headerAnimationLoop: false,
      animType: AnimType.topSlide,
      showCloseIcon: true,
      closeIcon: const Icon(Icons.close_fullscreen_outlined),
      title: 'WARNING!!',
      desc:
          'Menghapus data ini akan mengembalikan stok seperti sebelum barang ini di input, Yakin Hapus??',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        _proseshapus(id);
      },
    ).show();
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 41, 69, 91),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                "Data Barang Keluar",
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
                  builder: (context) => new TambahBK(_lihatData)));
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
                                    "( " +
                                    x.nama_brand.toString() +
                                    " )",
                              ),
                              subtitle: Padding(
                                  padding: EdgeInsets.all(1.0),
                                  child: Text(
                                    "Tgl Keluar " + x.tgl_keluar.toString(),
                                  )),
                              trailing: Wrap(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailBk(x, _lihatData)));
                                      },
                                      icon: FaIcon(
                                        FontAwesomeIcons.eye,
                                        size: 20,
                                      )),
                                  if (LvlUsr == "1") ...[
                                    IconButton(
                                        onPressed: () {
                                          alertHapus(x.id_bk);
                                        },
                                        icon: FaIcon(
                                          FontAwesomeIcons.trash,
                                          size: 20,
                                        ))
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
