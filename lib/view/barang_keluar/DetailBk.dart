import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:inven_lab/model/BarangKeluarModel.dart';
import 'package:inven_lab/model/api.dart';

class DetailBk extends StatefulWidget {
  final VoidCallback reload;
  final BarangKeluarModel model;
  DetailBk(this.model, this.reload);
  @override
  State<DetailBk> createState() => _DetailBkState();
}

class _DetailBkState extends State<DetailBk> {
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
                "Detal Barang Keluar " +
                    widget.model.id_barang_keluar.toString(),
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            )
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: SafeArea(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: <TableRow>[
                    TableRow(children: <Widget>[
                      ListTile(title: Text("Nama Barang")),
                      ListTile(
                          title: Text(
                        widget.model.nama_barang.toString() +
                            "( " +
                            widget.model.nama_brand.toString() +
                            " )",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal),
                      )),
                    ]),
                    TableRow(children: <Widget>[
                      ListTile(title: Text("Jumlah Masuk")),
                      ListTile(
                          title: Text(
                        widget.model.jumlah_keluar.toString(),
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal),
                      )),
                    ]),
                    TableRow(children: <Widget>[
                      ListTile(title: Text("Tgl Masuk")),
                      ListTile(
                          title: Text(
                        widget.model.tgl_keluar.toString(),
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal),
                      )),
                    ]),
                    TableRow(children: <Widget>[
                      ListTile(title: Text("Keterangan")),
                      ListTile(
                          title: Text(
                        widget.model.keterangan.toString(),
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal),
                      )),
                    ]),
                    TableRow(children: <Widget>[
                      ListTile(title: Text("User Input")),
                      ListTile(
                          title: Text(
                        widget.model.nama.toString(),
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal),
                      )),
                    ]),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
