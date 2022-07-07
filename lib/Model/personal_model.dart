class PersonalModel {
  String id;
  String nomorKtp;
  String namaLengkap;
  String tempatLahir;
  String tanggalLahir;
  String kotaKab;
  String telepon;
  String email;
  String pendidikan;
  String pengalamanMarketing;
  String perusahaan;
  String perusahaan1;
  String posisi1;
  String masuk1;
  String keluar1;
  String perusahaan2;
  String posisi2;
  String masuk2;
  String keluar2;
  String pasfoto;
  String cv;
  String ktp;
  String jawaban1;
  String jawaban2;
  String jawaban3;
  String jawaban4;
  String jawaban5;

  //BUAT CONSTRUCTOR AGAR KETIKA CLASS INI DILOAD, MAKA DATA YANG DIMINTA HARUS DIPASSING SESUAI TIPE DATA YANG DITETAPKAN
  PersonalModel({
    required this.id,
    required this.nomorKtp,
    required this.namaLengkap,
    required this.tempatLahir,
    required this.tanggalLahir,
    required this.kotaKab,
    required this.telepon,
    required this.email,
    required this.pendidikan,
    required this.pengalamanMarketing,
    required this.perusahaan,
    required this.perusahaan1,
    required this.posisi1,
    required this.masuk1,
    required this.keluar1,
    required this.perusahaan2,
    required this.posisi2,
    required this.masuk2,
    required this.keluar2,
    required this.pasfoto,
    required this.cv,
    required this.ktp,
    required this.jawaban1,
    required this.jawaban2,
    required this.jawaban3,
    required this.jawaban4,
    required this.jawaban5,
  });

  //FUNGSI INI UNTUK MENGUBAH FORMAT DATA DARI JSON KE FORMAT YANG SESUAI DENGAN EMPLOYEE MODEL
  factory PersonalModel.fromJson(Map<String, dynamic> json) => PersonalModel(
        id: json['id'],
        nomorKtp: json['nik'],
        namaLengkap: json['nama'],
        tempatLahir: json['tempat_lahir'],
        tanggalLahir: json['tanggal_lahir'],
        kotaKab: json['kota'],
        telepon: json['telepon'],
        email: json['email'],
        pendidikan: json['pendidikan'],
        pengalamanMarketing: json['pengalaman_marketing'],
        perusahaan: json['perusahaan'],
        perusahaan1: json['perusahaan1'],
        posisi1: json['posisi1'],
        masuk1: json['masuk1'],
        keluar1: json['keluar1'],
        perusahaan2: json['perusahaan2'],
        posisi2: json['posisi2'],
        masuk2: json['masuk2'],
        keluar2: json['keluar2'],
        pasfoto: json['pas_foto'],
        cv: json['cv'],
        ktp: json['ktp'],
        jawaban1: json['a'],
        jawaban2: json['b'],
        jawaban3: json['c'],
        jawaban4: json['d'],
        jawaban5: json['e'],
      );
}
