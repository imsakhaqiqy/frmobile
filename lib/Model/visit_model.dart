class VisitModel {
  String id;
  String nik;
  String tanggal;
  String jam;
  String namaLengkap;
  String telepon;
  String keterangan;
  String latitude;
  String longitude;
  String foto;
  String tandaTangan;
  String branch;
  String namaSales;

  //BUAT CONSTRUCTOR AGAR KETIKA CLASS INI DILOAD, MAKA DATA YANG DIMINTA HARUS DIPASSING SESUAI TIPE DATA YANG DITETAPKAN
  VisitModel({
    required this.id,
    required this.nik,
    required this.tanggal,
    required this.jam,
    required this.namaLengkap,
    required this.telepon,
    required this.keterangan,
    required this.latitude,
    required this.longitude,
    required this.foto,
    required this.tandaTangan,
    required this.branch,
    required this.namaSales,
  });

  //FUNGSI INI UNTUK MENGUBAH FORMAT DATA DARI JSON KE FORMAT YANG SESUAI DENGAN EMPLOYEE MODEL
  factory VisitModel.fromJson(Map<String, dynamic> json) => VisitModel(
        id: json['id'],
        nik: json['nik'],
        tanggal: json['tanggal'],
        jam: json['jam'],
        namaLengkap: json['nama_lengkap'],
        telepon: json['telepon'],
        keterangan: json['keterangan'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        foto: json['foto'],
        tandaTangan: json['tanda_tangan'],
        branch: json['branch'],
        namaSales: json['nama_sales'],
      );
}
