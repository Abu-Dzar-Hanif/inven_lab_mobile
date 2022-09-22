class JenisModel {
  String? no;
  String? id_jenis;
  String? nama_jenis;
  JenisModel(this.no, this.id_jenis, this.nama_jenis);
  JenisModel.fromJson(Map<String, dynamic> json) {
    no = json['no'];
    id_jenis = json['id_jenis'];
    nama_jenis = json['nama_jenis'];
  }
}
