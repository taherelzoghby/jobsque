// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:hive/hive.dart';

import 'package:jobsque/core/consts/strings.dart';

part 'apply_user_model.g.dart';

@HiveType(typeId: 1)
class ApplyUser extends HiveObject {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? email;
  @HiveField(2)
  String? phone;
  @HiveField(3)
  String? typeOfWork;
  @HiveField(4)
  File? cv;
  @HiveField(5)
  File? otherFiles;
  @HiveField(6)
  String? userId;
  @HiveField(7)
  String? jobId;
  @HiveField(8)
  String? status;
  @HiveField(9)
  bool? reviewed;
  @HiveField(10)
  String? updatedAt;
  @HiveField(11)
  String? createdAt;
  @HiveField(12)
  int? id;
  @HiveField(13)
  String? cvFile;
  @HiveField(14)
  String? cvOtherFile;
  @HiveField(15)
  dynamic accept;

  ApplyUser({
    this.name,
    this.email,
    this.phone,
    this.typeOfWork,
    this.cv,
    this.otherFiles,
    this.userId,
    this.jobId,
    this.status,
    this.reviewed,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.cvFile,
    this.cvOtherFile,
    this.accept,
  });

  factory ApplyUser.fromJson(Map<String, dynamic> json) => ApplyUser(
        name: json['name'],
        email: json['email'],
        phone: json['mobile'],
        typeOfWork: json['work_type'],
        cv: File(json['cv_file']),
        otherFiles: File(json['other_file']),
        userId: json['user_id'].toString(),
        jobId: json['jobs_id'].toString(),
        reviewed: json['reviewed'],
        updatedAt: json['updated_at'],
        createdAt: json['created_at'],
        id: json['id'],
        status: StringsEn.completed,
        accept: json['accept'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.phone;
    data['work_type'] = this.typeOfWork;
    data['cv_file'] = this.cv;
    data['other_file'] = this.otherFiles;
    data['jobs_id'] = this.jobId;
    data['user_id'] = this.userId;
    return data;
  }
}
