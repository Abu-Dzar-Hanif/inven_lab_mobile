class BarangModel {
  String? no;
  String? id_barang;
  String? nama_barang;
  String? nama_jenis;
  String? nama_brand;
  BarangModel(this.no, this.id_barang, this.nama_barang, this.nama_jenis,
      this.nama_brand);
  BarangModel.fromJson(Map<String, dynamic> json) {
    no = json['no'];
    id_barang = json['id_barang'];
    nama_barang = json['nama_barang'];
    nama_jenis = json['nama_jenis'];
    nama_brand = json['nama_brand'];
  }
}
