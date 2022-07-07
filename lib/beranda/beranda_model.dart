import 'package:flutter/material.dart';

class FieldRecruitmentService {
  IconData image;
  Color color;
  String title;

  FieldRecruitmentService(
    this.image,
    this.title,
    this.color,
  );
}

class FieldRecruitmentServiceImage {
  Image image;
  Color color;
  String title;

  FieldRecruitmentServiceImage(
    this.image,
    this.title,
    this.color,
  );
}

class Titled {
  String title;
  String image;

  Titled(
    this.title,
    this.image,
  );
}
