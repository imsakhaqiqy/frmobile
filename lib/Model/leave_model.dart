class LeaveModel {
  String id;
  String nik;
  String tanggalAwal;
  String tanggalAkhir;
  String tanggalKerja;
  String keterangan;
  String teleponDarurat;
  String path;
  String status;
  String createdAt;

  //BUAT CONSTRUCTOR AGAR KETIKA CLASS INI DILOAD, MAKA DATA YANG DIMINTA HARUS DIPASSING SESUAI TIPE DATA YANG DITETAPKAN
  LeaveModel({
    required this.id,
    required this.nik,
    required this.tanggalAwal,
    required this.tanggalAkhir,
    required this.tanggalKerja,
    required this.keterangan,
    required this.teleponDarurat,
    required this.path,
    required this.status,
    required this.createdAt,
  });

  //FUNGSI INI UNTUK MENGUBAH FORMAT DATA DARI JSON KE FORMAT YANG SESUAI DENGAN EMPLOYEE MODEL
  factory LeaveModel.fromJson(Map<String, dynamic> json) => LeaveModel(
        id: json['id'],
        nik: json['nik'],
        tanggalAwal: json['tanggal_awal'],
        tanggalAkhir: json['tanggal_akhir'],
        tanggalKerja: json['tanggal_kerja'],
        keterangan: json['keterangan'],
        teleponDarurat: json['telepon_darurat'],
        path: json['path'],
        status: json['status'],
        createdAt: json['created_at'],
      );
}
