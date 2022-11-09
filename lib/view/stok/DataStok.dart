import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:inven_lab/Loadingpage.dart';
import 'dart:convert';
import 'package:inven_lab/model/StokModel.dart';
import 'package:inven_lab/model/api.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class DataStok extends StatefulWidget {
  @override
  State<DataStok> createState() => _DataStokState();
}

class _DataStokState extends State<DataStok> {
  var loading = false;
  final list = [];
  Future<void>? _launched;
  final Uri _urlpdf = Uri.parse(BaseUrl.urlStokPdf);
  final Uri _urlcsv = Uri.parse(BaseUrl.urlStokCsv);
  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();

  getPref() async {
    _lihatData();
  }

  Future<void> _lihatData() async {
    list.clear();
    setState(() {
      loading = true;
    });
    final response = await http.get(Uri.parse(BaseUrl.urlDataStok));
    if (response.contentLength == 2) {
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new StokModel(
            api['no'],
            api['id_barang'],
            api['nama_barang'],
            api['nama_jenis'],
            api['nama_brand'],
            api['stok']);
        list.add(ab);
      });
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
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
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 41, 69, 91),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                "Data Stok Barang",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => setState(() {
              _launched = _launchInBrowser(_urlpdf);
            }),
            child: FaIcon(FontAwesomeIcons.filePdf),
            backgroundColor: Color.fromARGB(255, 204, 0, 0),
          ),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            onPressed: () => setState(() {
              _launched = _launchInBrowser(_urlcsv);
            }),
            child: FaIcon(FontAwesomeIcons.fileCsv),
            backgroundColor: Color.fromARGB(255, 0, 128, 0),
          ),
        ],
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
                            Table(
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              children: <TableRow>[
                                TableRow(children: <Widget>[
                                  ListTile(title: Text("Kode Barang")),
                                  ListTile(
                                      title: Text(
                                    x.id_barang.toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  )),
                                ]),
                                TableRow(children: <Widget>[
                                  ListTile(title: Text("Nama Barang")),
                                  ListTile(
                                      title: Text(
                                    x.nama_barang.toString() +
                                        "( " +
                                        x.nama_brand.toString() +
                                        " )",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  )),
                                ]),
                                TableRow(children: <Widget>[
                                  ListTile(title: Text("Stok")),
                                  ListTile(
                                      title: Text(
                                    x.stok.toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  )),
                                ]),
                              ],
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
