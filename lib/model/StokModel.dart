class StokModel {
  String? no;
  String? nama_barang;
  String? nama_jenis;
  String? nama_brand;
  String? stok;
  StokModel(
      this.no, this.nama_barang, this.nama_jenis, this.nama_brand, this.stok);
  StokModel.fromJson(Map<String, dynamic> json) {
    no = json['no'];
    nama_barang = json['nama_barang'];
    nama_jenis = json['nama_jenis'];
    nama_brand = json['nama_brand'];
    stok = json['stok'];
  }
}
