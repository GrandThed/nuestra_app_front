// To parse this JSON data, do
//
//     final statCardModel = statCardModelFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'stat_card_model.freezed.dart';
part 'stat_card_model.g.dart';

StatCardModel statCardModelFromJson(String str) =>
    StatCardModel.fromJson(json.decode(str));

String statCardModelToJson(StatCardModel data) => json.encode(data.toJson());

@freezed
abstract class StatCardModel with _$StatCardModel {
  const factory StatCardModel({
    required String type,
    DateTime? date,
    required String title,
    int? amount,
    String? description,
    required String id,
  }) = _StatCardModel;
  factory StatCardModel.fromJson(Map<String, dynamic> json) =>
      _$StatCardModelFromJson(json);
}
