class BarangMasukModel {
  String? no;
  String? id_bm;
  String? id_barang_masuk;
  String? nama_barang;
  String? nama_brand;
  String? jumlah_masuk;
  String? tgl_masuk;
  String? keterangan;
  String? nama;
  BarangMasukModel(
      this.no,
      this.id_bm,
      this.id_barang_masuk,
      this.nama_barang,
      this.nama_brand,
      this.jumlah_masuk,
      this.tgl_masuk,
      this.keterangan,
      this.nama);
  BarangMasukModel.fromJson(Map<String, dynamic> json) {
    no = json['no'];
    id_bm = json['id_bm'];
    id_barang_masuk = json['id_barang_masuk'];
    nama_barang = json['nama_barang'];
    nama_brand = json['nama_brand'];
    jumlah_masuk = json['jumlah_masuk'];
    tgl_masuk = json['tgl_masuk'];
    keterangan = json['keterangan'];
    nama = json['nama'];
  }
}
