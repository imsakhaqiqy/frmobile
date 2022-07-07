class CheckInModel {
  String id;
  String nik;
  String tanggal;
  String jamMasuk;
  String absen;
  String alasan;
  String status;
  String latitude;
  String longitude;
  String path;
  String branch;
  String namaSales;

  //BUAT CONSTRUCTOR AGAR KETIKA CLASS INI DILOAD, MAKA DATA YANG DIMINTA HARUS DIPASSING SESUAI TIPE DATA YANG DITETAPKAN
  CheckInModel({
    required this.id,
    required this.nik,
    required this.tanggal,
    required this.jamMasuk,
    required this.absen,
    required this.alasan,
    required this.status,
    required this.latitude,
    required this.longitude,
    required this.path,
    required this.branch,
    required this.namaSales,
  });

  //FUNGSI INI UNTUK MENGUBAH FORMAT DATA DARI JSON KE FORMAT YANG SESUAI DENGAN EMPLOYEE MODEL
  factory CheckInModel.fromJson(Map<String, dynamic> json) => CheckInModel(
        id: json['id'],
        nik: json['nik'],
        tanggal: json['tanggal'],
        jamMasuk: json['jam_masuk'],
        absen: json['absen'],
        alasan: json['alasan'],
        status: json['status'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        path: json['path'],
        branch: json['branch'],
        namaSales: json['nama_sales'],
      );
}
