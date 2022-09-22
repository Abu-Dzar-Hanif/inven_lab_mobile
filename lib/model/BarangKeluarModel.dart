class BarangKeluarModel {
  String? no;
  String? id_bk;
  String? id_barang_keluar;
  String? nama_barang;
  String? nama_brand;
  String? jumlah_keluar;
  String? tgl_keluar;
  String? keterangan;
  String? nama;
  BarangKeluarModel(
      this.no,
      this.id_bk,
      this.id_barang_keluar,
      this.nama_barang,
      this.nama_brand,
      this.jumlah_keluar,
      this.tgl_keluar,
      this.keterangan,
      this.nama);
  BarangKeluarModel.fromJson(Map<String, dynamic> json) {
    no = json['no'];
    id_bk = json['id_bk'];
    id_barang_keluar = json['id_barang_keluar'];
    nama_barang = json['nama_barang'];
    nama_brand = json['nama_brand'];
    jumlah_keluar = json['jumlah_keluar'];
    tgl_keluar = json['tgl_keluar'];
    keterangan = json['keterangan'];
    nama = json['nama'];
  }
}
