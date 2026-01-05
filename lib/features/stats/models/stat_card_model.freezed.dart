// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stat_card_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StatCardModel {

 String get type; DateTime? get date; String get title; int? get amount; String? get description; String get id;
/// Create a copy of StatCardModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatCardModelCopyWith<StatCardModel> get copyWith => _$StatCardModelCopyWithImpl<StatCardModel>(this as StatCardModel, _$identity);

  /// Serializes this StatCardModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatCardModel&&(identical(other.type, type) || other.type == type)&&(identical(other.date, date) || other.date == date)&&(identical(other.title, title) || other.title == title)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.description, description) || other.description == description)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,date,title,amount,description,id);

@override
String toString() {
  return 'StatCardModel(type: $type, date: $date, title: $title, amount: $amount, description: $description, id: $id)';
}


}

/// @nodoc
abstract mixin class $StatCardModelCopyWith<$Res>  {
  factory $StatCardModelCopyWith(StatCardModel value, $Res Function(StatCardModel) _then) = _$StatCardModelCopyWithImpl;
@useResult
$Res call({
 String type, DateTime? date, String title, int? amount, String? description, String id
});




}
/// @nodoc
class _$StatCardModelCopyWithImpl<$Res>
    implements $StatCardModelCopyWith<$Res> {
  _$StatCardModelCopyWithImpl(this._self, this._then);

  final StatCardModel _self;
  final $Res Function(StatCardModel) _then;

/// Create a copy of StatCardModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? date = freezed,Object? title = null,Object? amount = freezed,Object? description = freezed,Object? id = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _StatCardModel implements StatCardModel {
  const _StatCardModel({required this.type, this.date, required this.title, this.amount, this.description, required this.id});
  factory _StatCardModel.fromJson(Map<String, dynamic> json) => _$StatCardModelFromJson(json);

@override final  String type;
@override final  DateTime? date;
@override final  String title;
@override final  int? amount;
@override final  String? description;
@override final  String id;

/// Create a copy of StatCardModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatCardModelCopyWith<_StatCardModel> get copyWith => __$StatCardModelCopyWithImpl<_StatCardModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StatCardModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatCardModel&&(identical(other.type, type) || other.type == type)&&(identical(other.date, date) || other.date == date)&&(identical(other.title, title) || other.title == title)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.description, description) || other.description == description)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,date,title,amount,description,id);

@override
String toString() {
  return 'StatCardModel(type: $type, date: $date, title: $title, amount: $amount, description: $description, id: $id)';
}


}

/// @nodoc
abstract mixin class _$StatCardModelCopyWith<$Res> implements $StatCardModelCopyWith<$Res> {
  factory _$StatCardModelCopyWith(_StatCardModel value, $Res Function(_StatCardModel) _then) = __$StatCardModelCopyWithImpl;
@override @useResult
$Res call({
 String type, DateTime? date, String title, int? amount, String? description, String id
});




}
/// @nodoc
class __$StatCardModelCopyWithImpl<$Res>
    implements _$StatCardModelCopyWith<$Res> {
  __$StatCardModelCopyWithImpl(this._self, this._then);

  final _StatCardModel _self;
  final $Res Function(_StatCardModel) _then;

/// Create a copy of StatCardModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? date = freezed,Object? title = null,Object? amount = freezed,Object? description = freezed,Object? id = null,}) {
  return _then(_StatCardModel(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
