import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:inven_lab/Loadingpage.dart';
import 'dart:convert';
import 'package:inven_lab/model/AdminModel.dart';
import 'package:inven_lab/model/api.dart';
import 'package:inven_lab/view/admin/UpdatePass.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profil extends StatefulWidget {
  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  String? IdUsr, ID, Nama, Levl, Usrnm;
  getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      IdUsr = pref.getString("id");
    });
  }

  var loading = false;

  final ex = List<AdminModel>.empty(growable: true);
  _countBR() async {
    setState(() {
      loading = true;
    });
    ex.clear();
    final response =
        await http.get(Uri.parse(BaseUrl.urlProfil + IdUsr.toString()));
    final data = jsonDecode(response.body);
    data.forEach((api) {
      final exp = new AdminModel(
          api['no'], api['id_admin'], api['nama'], api['username'], api['lvl']);
      ex.add(exp);
      setState(() {
        ID = exp.id_admin.toString();
        Nama = exp.nama.toString();
        Usrnm = exp.username.toString();
        Levl = exp.lvl.toString();
      });
    });
    setState(() {
      _countBR();
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
    _countBR();
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
                "Profil Anda",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            )
          ],
        ),
      ),
      body: Column(children: <Widget>[
        Container(
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
                        ListTile(title: Text("ID")),
                        ListTile(
                            title: Text(
                          ID.toString(),
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.normal),
                        )),
                      ]),
                      TableRow(children: <Widget>[
                        ListTile(title: Text("Nama")),
                        ListTile(
                            title: Text(
                          Nama.toString(),
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.normal),
                        )),
                      ]),
                      TableRow(children: <Widget>[
                        ListTile(title: Text("username")),
                        ListTile(
                            title: Text(
                          Usrnm.toString(),
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.normal),
                        )),
                      ]),
                      TableRow(children: <Widget>[
                        ListTile(title: Text("Level")),
                        ListTile(
                            title: Text(
                          Levl.toString(),
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.normal),
                        )),
                      ]),
                    ],
                  ),
                ]),
          ),
        ),
        SizedBox(
          height: 25,
        ),
        MaterialButton(
          padding: EdgeInsets.all(20.0),
          color: Color.fromARGB(255, 244, 182, 25),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => new UpdatePass()));
          },
          child: Text(
            'Ubah Password',
            style: TextStyle(color: Colors.white),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ]),
    );
  }
}
