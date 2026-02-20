// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expenses_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExpensesState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpensesState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExpensesState()';
}


}

/// @nodoc
class $ExpensesStateCopyWith<$Res>  {
$ExpensesStateCopyWith(ExpensesState _, $Res Function(ExpensesState) __);
}


/// Adds pattern-matching-related methods to [ExpensesState].
extension ExpensesStatePatterns on ExpensesState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ExpensesStateInitial value)?  initial,TResult Function( ExpensesStateLoading value)?  loading,TResult Function( ExpensesStateLoaded value)?  loaded,TResult Function( ExpensesStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ExpensesStateInitial() when initial != null:
return initial(_that);case ExpensesStateLoading() when loading != null:
return loading(_that);case ExpensesStateLoaded() when loaded != null:
return loaded(_that);case ExpensesStateError() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ExpensesStateInitial value)  initial,required TResult Function( ExpensesStateLoading value)  loading,required TResult Function( ExpensesStateLoaded value)  loaded,required TResult Function( ExpensesStateError value)  error,}){
final _that = this;
switch (_that) {
case ExpensesStateInitial():
return initial(_that);case ExpensesStateLoading():
return loading(_that);case ExpensesStateLoaded():
return loaded(_that);case ExpensesStateError():
return error(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ExpensesStateInitial value)?  initial,TResult? Function( ExpensesStateLoading value)?  loading,TResult? Function( ExpensesStateLoaded value)?  loaded,TResult? Function( ExpensesStateError value)?  error,}){
final _that = this;
switch (_that) {
case ExpensesStateInitial() when initial != null:
return initial(_that);case ExpensesStateLoading() when loading != null:
return loading(_that);case ExpensesStateLoaded() when loaded != null:
return loaded(_that);case ExpensesStateError() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<ExpenseCategoryModel> categories,  List<ExpenseModel> expenses,  int selectedMonth,  int selectedYear,  String? selectedCategoryId)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ExpensesStateInitial() when initial != null:
return initial();case ExpensesStateLoading() when loading != null:
return loading();case ExpensesStateLoaded() when loaded != null:
return loaded(_that.categories,_that.expenses,_that.selectedMonth,_that.selectedYear,_that.selectedCategoryId);case ExpensesStateError() when error != null:
return error(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<ExpenseCategoryModel> categories,  List<ExpenseModel> expenses,  int selectedMonth,  int selectedYear,  String? selectedCategoryId)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case ExpensesStateInitial():
return initial();case ExpensesStateLoading():
return loading();case ExpensesStateLoaded():
return loaded(_that.categories,_that.expenses,_that.selectedMonth,_that.selectedYear,_that.selectedCategoryId);case ExpensesStateError():
return error(_that.message);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<ExpenseCategoryModel> categories,  List<ExpenseModel> expenses,  int selectedMonth,  int selectedYear,  String? selectedCategoryId)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case ExpensesStateInitial() when initial != null:
return initial();case ExpensesStateLoading() when loading != null:
return loading();case ExpensesStateLoaded() when loaded != null:
return loaded(_that.categories,_that.expenses,_that.selectedMonth,_that.selectedYear,_that.selectedCategoryId);case ExpensesStateError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ExpensesStateInitial implements ExpensesState {
  const ExpensesStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpensesStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExpensesState.initial()';
}


}




/// @nodoc


class ExpensesStateLoading implements ExpensesState {
  const ExpensesStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpensesStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExpensesState.loading()';
}


}




/// @nodoc


class ExpensesStateLoaded implements ExpensesState {
  const ExpensesStateLoaded({required final  List<ExpenseCategoryModel> categories, required final  List<ExpenseModel> expenses, required this.selectedMonth, required this.selectedYear, this.selectedCategoryId}): _categories = categories,_expenses = expenses;
  

 final  List<ExpenseCategoryModel> _categories;
 List<ExpenseCategoryModel> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

 final  List<ExpenseModel> _expenses;
 List<ExpenseModel> get expenses {
  if (_expenses is EqualUnmodifiableListView) return _expenses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_expenses);
}

 final  int selectedMonth;
 final  int selectedYear;
 final  String? selectedCategoryId;

/// Create a copy of ExpensesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpensesStateLoadedCopyWith<ExpensesStateLoaded> get copyWith => _$ExpensesStateLoadedCopyWithImpl<ExpensesStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpensesStateLoaded&&const DeepCollectionEquality().equals(other._categories, _categories)&&const DeepCollectionEquality().equals(other._expenses, _expenses)&&(identical(other.selectedMonth, selectedMonth) || other.selectedMonth == selectedMonth)&&(identical(other.selectedYear, selectedYear) || other.selectedYear == selectedYear)&&(identical(other.selectedCategoryId, selectedCategoryId) || other.selectedCategoryId == selectedCategoryId));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_expenses),selectedMonth,selectedYear,selectedCategoryId);

@override
String toString() {
  return 'ExpensesState.loaded(categories: $categories, expenses: $expenses, selectedMonth: $selectedMonth, selectedYear: $selectedYear, selectedCategoryId: $selectedCategoryId)';
}


}

/// @nodoc
abstract mixin class $ExpensesStateLoadedCopyWith<$Res> implements $ExpensesStateCopyWith<$Res> {
  factory $ExpensesStateLoadedCopyWith(ExpensesStateLoaded value, $Res Function(ExpensesStateLoaded) _then) = _$ExpensesStateLoadedCopyWithImpl;
@useResult
$Res call({
 List<ExpenseCategoryModel> categories, List<ExpenseModel> expenses, int selectedMonth, int selectedYear, String? selectedCategoryId
});




}
/// @nodoc
class _$ExpensesStateLoadedCopyWithImpl<$Res>
    implements $ExpensesStateLoadedCopyWith<$Res> {
  _$ExpensesStateLoadedCopyWithImpl(this._self, this._then);

  final ExpensesStateLoaded _self;
  final $Res Function(ExpensesStateLoaded) _then;

/// Create a copy of ExpensesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? categories = null,Object? expenses = null,Object? selectedMonth = null,Object? selectedYear = null,Object? selectedCategoryId = freezed,}) {
  return _then(ExpensesStateLoaded(
categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<ExpenseCategoryModel>,expenses: null == expenses ? _self._expenses : expenses // ignore: cast_nullable_to_non_nullable
as List<ExpenseModel>,selectedMonth: null == selectedMonth ? _self.selectedMonth : selectedMonth // ignore: cast_nullable_to_non_nullable
as int,selectedYear: null == selectedYear ? _self.selectedYear : selectedYear // ignore: cast_nullable_to_non_nullable
as int,selectedCategoryId: freezed == selectedCategoryId ? _self.selectedCategoryId : selectedCategoryId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ExpensesStateError implements ExpensesState {
  const ExpensesStateError(this.message);
  

 final  String message;

/// Create a copy of ExpensesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpensesStateErrorCopyWith<ExpensesStateError> get copyWith => _$ExpensesStateErrorCopyWithImpl<ExpensesStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpensesStateError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ExpensesState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ExpensesStateErrorCopyWith<$Res> implements $ExpensesStateCopyWith<$Res> {
  factory $ExpensesStateErrorCopyWith(ExpensesStateError value, $Res Function(ExpensesStateError) _then) = _$ExpensesStateErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ExpensesStateErrorCopyWithImpl<$Res>
    implements $ExpensesStateErrorCopyWith<$Res> {
  _$ExpensesStateErrorCopyWithImpl(this._self, this._then);

  final ExpensesStateError _self;
  final $Res Function(ExpensesStateError) _then;

/// Create a copy of ExpensesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ExpensesStateError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ExpenseSummaryState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseSummaryState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExpenseSummaryState()';
}


}

/// @nodoc
class $ExpenseSummaryStateCopyWith<$Res>  {
$ExpenseSummaryStateCopyWith(ExpenseSummaryState _, $Res Function(ExpenseSummaryState) __);
}


/// Adds pattern-matching-related methods to [ExpenseSummaryState].
extension ExpenseSummaryStatePatterns on ExpenseSummaryState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ExpenseSummaryStateInitial value)?  initial,TResult Function( ExpenseSummaryStateLoading value)?  loading,TResult Function( ExpenseSummaryStateLoaded value)?  loaded,TResult Function( ExpenseSummaryStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ExpenseSummaryStateInitial() when initial != null:
return initial(_that);case ExpenseSummaryStateLoading() when loading != null:
return loading(_that);case ExpenseSummaryStateLoaded() when loaded != null:
return loaded(_that);case ExpenseSummaryStateError() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ExpenseSummaryStateInitial value)  initial,required TResult Function( ExpenseSummaryStateLoading value)  loading,required TResult Function( ExpenseSummaryStateLoaded value)  loaded,required TResult Function( ExpenseSummaryStateError value)  error,}){
final _that = this;
switch (_that) {
case ExpenseSummaryStateInitial():
return initial(_that);case ExpenseSummaryStateLoading():
return loading(_that);case ExpenseSummaryStateLoaded():
return loaded(_that);case ExpenseSummaryStateError():
return error(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ExpenseSummaryStateInitial value)?  initial,TResult? Function( ExpenseSummaryStateLoading value)?  loading,TResult? Function( ExpenseSummaryStateLoaded value)?  loaded,TResult? Function( ExpenseSummaryStateError value)?  error,}){
final _that = this;
switch (_that) {
case ExpenseSummaryStateInitial() when initial != null:
return initial(_that);case ExpenseSummaryStateLoading() when loading != null:
return loading(_that);case ExpenseSummaryStateLoaded() when loaded != null:
return loaded(_that);case ExpenseSummaryStateError() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( ExpenseSummaryModel summary)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ExpenseSummaryStateInitial() when initial != null:
return initial();case ExpenseSummaryStateLoading() when loading != null:
return loading();case ExpenseSummaryStateLoaded() when loaded != null:
return loaded(_that.summary);case ExpenseSummaryStateError() when error != null:
return error(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( ExpenseSummaryModel summary)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case ExpenseSummaryStateInitial():
return initial();case ExpenseSummaryStateLoading():
return loading();case ExpenseSummaryStateLoaded():
return loaded(_that.summary);case ExpenseSummaryStateError():
return error(_that.message);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( ExpenseSummaryModel summary)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case ExpenseSummaryStateInitial() when initial != null:
return initial();case ExpenseSummaryStateLoading() when loading != null:
return loading();case ExpenseSummaryStateLoaded() when loaded != null:
return loaded(_that.summary);case ExpenseSummaryStateError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ExpenseSummaryStateInitial implements ExpenseSummaryState {
  const ExpenseSummaryStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseSummaryStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExpenseSummaryState.initial()';
}


}




/// @nodoc


class ExpenseSummaryStateLoading implements ExpenseSummaryState {
  const ExpenseSummaryStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseSummaryStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExpenseSummaryState.loading()';
}


}




/// @nodoc


class ExpenseSummaryStateLoaded implements ExpenseSummaryState {
  const ExpenseSummaryStateLoaded(this.summary);
  

 final  ExpenseSummaryModel summary;

/// Create a copy of ExpenseSummaryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseSummaryStateLoadedCopyWith<ExpenseSummaryStateLoaded> get copyWith => _$ExpenseSummaryStateLoadedCopyWithImpl<ExpenseSummaryStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseSummaryStateLoaded&&(identical(other.summary, summary) || other.summary == summary));
}


@override
int get hashCode => Object.hash(runtimeType,summary);

@override
String toString() {
  return 'ExpenseSummaryState.loaded(summary: $summary)';
}


}

/// @nodoc
abstract mixin class $ExpenseSummaryStateLoadedCopyWith<$Res> implements $ExpenseSummaryStateCopyWith<$Res> {
  factory $ExpenseSummaryStateLoadedCopyWith(ExpenseSummaryStateLoaded value, $Res Function(ExpenseSummaryStateLoaded) _then) = _$ExpenseSummaryStateLoadedCopyWithImpl;
@useResult
$Res call({
 ExpenseSummaryModel summary
});


$ExpenseSummaryModelCopyWith<$Res> get summary;

}
/// @nodoc
class _$ExpenseSummaryStateLoadedCopyWithImpl<$Res>
    implements $ExpenseSummaryStateLoadedCopyWith<$Res> {
  _$ExpenseSummaryStateLoadedCopyWithImpl(this._self, this._then);

  final ExpenseSummaryStateLoaded _self;
  final $Res Function(ExpenseSummaryStateLoaded) _then;

/// Create a copy of ExpenseSummaryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? summary = null,}) {
  return _then(ExpenseSummaryStateLoaded(
null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as ExpenseSummaryModel,
  ));
}

/// Create a copy of ExpenseSummaryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExpenseSummaryModelCopyWith<$Res> get summary {
  
  return $ExpenseSummaryModelCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}

/// @nodoc


class ExpenseSummaryStateError implements ExpenseSummaryState {
  const ExpenseSummaryStateError(this.message);
  

 final  String message;

/// Create a copy of ExpenseSummaryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseSummaryStateErrorCopyWith<ExpenseSummaryStateError> get copyWith => _$ExpenseSummaryStateErrorCopyWithImpl<ExpenseSummaryStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseSummaryStateError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ExpenseSummaryState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ExpenseSummaryStateErrorCopyWith<$Res> implements $ExpenseSummaryStateCopyWith<$Res> {
  factory $ExpenseSummaryStateErrorCopyWith(ExpenseSummaryStateError value, $Res Function(ExpenseSummaryStateError) _then) = _$ExpenseSummaryStateErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ExpenseSummaryStateErrorCopyWithImpl<$Res>
    implements $ExpenseSummaryStateErrorCopyWith<$Res> {
  _$ExpenseSummaryStateErrorCopyWithImpl(this._self, this._then);

  final ExpenseSummaryStateError _self;
  final $Res Function(ExpenseSummaryStateError) _then;

/// Create a copy of ExpenseSummaryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ExpenseSummaryStateError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ExpenseDetailState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseDetailState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExpenseDetailState()';
}


}

/// @nodoc
class $ExpenseDetailStateCopyWith<$Res>  {
$ExpenseDetailStateCopyWith(ExpenseDetailState _, $Res Function(ExpenseDetailState) __);
}


/// Adds pattern-matching-related methods to [ExpenseDetailState].
extension ExpenseDetailStatePatterns on ExpenseDetailState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ExpenseDetailStateInitial value)?  initial,TResult Function( ExpenseDetailStateLoading value)?  loading,TResult Function( ExpenseDetailStateLoaded value)?  loaded,TResult Function( ExpenseDetailStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ExpenseDetailStateInitial() when initial != null:
return initial(_that);case ExpenseDetailStateLoading() when loading != null:
return loading(_that);case ExpenseDetailStateLoaded() when loaded != null:
return loaded(_that);case ExpenseDetailStateError() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ExpenseDetailStateInitial value)  initial,required TResult Function( ExpenseDetailStateLoading value)  loading,required TResult Function( ExpenseDetailStateLoaded value)  loaded,required TResult Function( ExpenseDetailStateError value)  error,}){
final _that = this;
switch (_that) {
case ExpenseDetailStateInitial():
return initial(_that);case ExpenseDetailStateLoading():
return loading(_that);case ExpenseDetailStateLoaded():
return loaded(_that);case ExpenseDetailStateError():
return error(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ExpenseDetailStateInitial value)?  initial,TResult? Function( ExpenseDetailStateLoading value)?  loading,TResult? Function( ExpenseDetailStateLoaded value)?  loaded,TResult? Function( ExpenseDetailStateError value)?  error,}){
final _that = this;
switch (_that) {
case ExpenseDetailStateInitial() when initial != null:
return initial(_that);case ExpenseDetailStateLoading() when loading != null:
return loading(_that);case ExpenseDetailStateLoaded() when loaded != null:
return loaded(_that);case ExpenseDetailStateError() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( ExpenseModel expense)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ExpenseDetailStateInitial() when initial != null:
return initial();case ExpenseDetailStateLoading() when loading != null:
return loading();case ExpenseDetailStateLoaded() when loaded != null:
return loaded(_that.expense);case ExpenseDetailStateError() when error != null:
return error(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( ExpenseModel expense)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case ExpenseDetailStateInitial():
return initial();case ExpenseDetailStateLoading():
return loading();case ExpenseDetailStateLoaded():
return loaded(_that.expense);case ExpenseDetailStateError():
return error(_that.message);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( ExpenseModel expense)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case ExpenseDetailStateInitial() when initial != null:
return initial();case ExpenseDetailStateLoading() when loading != null:
return loading();case ExpenseDetailStateLoaded() when loaded != null:
return loaded(_that.expense);case ExpenseDetailStateError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ExpenseDetailStateInitial implements ExpenseDetailState {
  const ExpenseDetailStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseDetailStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExpenseDetailState.initial()';
}


}




/// @nodoc


class ExpenseDetailStateLoading implements ExpenseDetailState {
  const ExpenseDetailStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseDetailStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExpenseDetailState.loading()';
}


}




/// @nodoc


class ExpenseDetailStateLoaded implements ExpenseDetailState {
  const ExpenseDetailStateLoaded(this.expense);
  

 final  ExpenseModel expense;

/// Create a copy of ExpenseDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseDetailStateLoadedCopyWith<ExpenseDetailStateLoaded> get copyWith => _$ExpenseDetailStateLoadedCopyWithImpl<ExpenseDetailStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseDetailStateLoaded&&(identical(other.expense, expense) || other.expense == expense));
}


@override
int get hashCode => Object.hash(runtimeType,expense);

@override
String toString() {
  return 'ExpenseDetailState.loaded(expense: $expense)';
}


}

/// @nodoc
abstract mixin class $ExpenseDetailStateLoadedCopyWith<$Res> implements $ExpenseDetailStateCopyWith<$Res> {
  factory $ExpenseDetailStateLoadedCopyWith(ExpenseDetailStateLoaded value, $Res Function(ExpenseDetailStateLoaded) _then) = _$ExpenseDetailStateLoadedCopyWithImpl;
@useResult
$Res call({
 ExpenseModel expense
});


$ExpenseModelCopyWith<$Res> get expense;

}
/// @nodoc
class _$ExpenseDetailStateLoadedCopyWithImpl<$Res>
    implements $ExpenseDetailStateLoadedCopyWith<$Res> {
  _$ExpenseDetailStateLoadedCopyWithImpl(this._self, this._then);

  final ExpenseDetailStateLoaded _self;
  final $Res Function(ExpenseDetailStateLoaded) _then;

/// Create a copy of ExpenseDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? expense = null,}) {
  return _then(ExpenseDetailStateLoaded(
null == expense ? _self.expense : expense // ignore: cast_nullable_to_non_nullable
as ExpenseModel,
  ));
}

/// Create a copy of ExpenseDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExpenseModelCopyWith<$Res> get expense {
  
  return $ExpenseModelCopyWith<$Res>(_self.expense, (value) {
    return _then(_self.copyWith(expense: value));
  });
}
}

/// @nodoc


class ExpenseDetailStateError implements ExpenseDetailState {
  const ExpenseDetailStateError(this.message);
  

 final  String message;

/// Create a copy of ExpenseDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseDetailStateErrorCopyWith<ExpenseDetailStateError> get copyWith => _$ExpenseDetailStateErrorCopyWithImpl<ExpenseDetailStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseDetailStateError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ExpenseDetailState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ExpenseDetailStateErrorCopyWith<$Res> implements $ExpenseDetailStateCopyWith<$Res> {
  factory $ExpenseDetailStateErrorCopyWith(ExpenseDetailStateError value, $Res Function(ExpenseDetailStateError) _then) = _$ExpenseDetailStateErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ExpenseDetailStateErrorCopyWithImpl<$Res>
    implements $ExpenseDetailStateErrorCopyWith<$Res> {
  _$ExpenseDetailStateErrorCopyWithImpl(this._self, this._then);

  final ExpenseDetailStateError _self;
  final $Res Function(ExpenseDetailStateError) _then;

/// Create a copy of ExpenseDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ExpenseDetailStateError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$RecurringExpensesState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecurringExpensesState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RecurringExpensesState()';
}


}

/// @nodoc
class $RecurringExpensesStateCopyWith<$Res>  {
$RecurringExpensesStateCopyWith(RecurringExpensesState _, $Res Function(RecurringExpensesState) __);
}


/// Adds pattern-matching-related methods to [RecurringExpensesState].
extension RecurringExpensesStatePatterns on RecurringExpensesState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RecurringExpensesStateInitial value)?  initial,TResult Function( RecurringExpensesStateLoading value)?  loading,TResult Function( RecurringExpensesStateLoaded value)?  loaded,TResult Function( RecurringExpensesStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RecurringExpensesStateInitial() when initial != null:
return initial(_that);case RecurringExpensesStateLoading() when loading != null:
return loading(_that);case RecurringExpensesStateLoaded() when loaded != null:
return loaded(_that);case RecurringExpensesStateError() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RecurringExpensesStateInitial value)  initial,required TResult Function( RecurringExpensesStateLoading value)  loading,required TResult Function( RecurringExpensesStateLoaded value)  loaded,required TResult Function( RecurringExpensesStateError value)  error,}){
final _that = this;
switch (_that) {
case RecurringExpensesStateInitial():
return initial(_that);case RecurringExpensesStateLoading():
return loading(_that);case RecurringExpensesStateLoaded():
return loaded(_that);case RecurringExpensesStateError():
return error(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RecurringExpensesStateInitial value)?  initial,TResult? Function( RecurringExpensesStateLoading value)?  loading,TResult? Function( RecurringExpensesStateLoaded value)?  loaded,TResult? Function( RecurringExpensesStateError value)?  error,}){
final _that = this;
switch (_that) {
case RecurringExpensesStateInitial() when initial != null:
return initial(_that);case RecurringExpensesStateLoading() when loading != null:
return loading(_that);case RecurringExpensesStateLoaded() when loaded != null:
return loaded(_that);case RecurringExpensesStateError() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<RecurringExpenseModel> expenses)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RecurringExpensesStateInitial() when initial != null:
return initial();case RecurringExpensesStateLoading() when loading != null:
return loading();case RecurringExpensesStateLoaded() when loaded != null:
return loaded(_that.expenses);case RecurringExpensesStateError() when error != null:
return error(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<RecurringExpenseModel> expenses)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case RecurringExpensesStateInitial():
return initial();case RecurringExpensesStateLoading():
return loading();case RecurringExpensesStateLoaded():
return loaded(_that.expenses);case RecurringExpensesStateError():
return error(_that.message);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<RecurringExpenseModel> expenses)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case RecurringExpensesStateInitial() when initial != null:
return initial();case RecurringExpensesStateLoading() when loading != null:
return loading();case RecurringExpensesStateLoaded() when loaded != null:
return loaded(_that.expenses);case RecurringExpensesStateError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class RecurringExpensesStateInitial implements RecurringExpensesState {
  const RecurringExpensesStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecurringExpensesStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RecurringExpensesState.initial()';
}


}




/// @nodoc


class RecurringExpensesStateLoading implements RecurringExpensesState {
  const RecurringExpensesStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecurringExpensesStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RecurringExpensesState.loading()';
}


}




/// @nodoc


class RecurringExpensesStateLoaded implements RecurringExpensesState {
  const RecurringExpensesStateLoaded(final  List<RecurringExpenseModel> expenses): _expenses = expenses;
  

 final  List<RecurringExpenseModel> _expenses;
 List<RecurringExpenseModel> get expenses {
  if (_expenses is EqualUnmodifiableListView) return _expenses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_expenses);
}


/// Create a copy of RecurringExpensesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecurringExpensesStateLoadedCopyWith<RecurringExpensesStateLoaded> get copyWith => _$RecurringExpensesStateLoadedCopyWithImpl<RecurringExpensesStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecurringExpensesStateLoaded&&const DeepCollectionEquality().equals(other._expenses, _expenses));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_expenses));

@override
String toString() {
  return 'RecurringExpensesState.loaded(expenses: $expenses)';
}


}

/// @nodoc
abstract mixin class $RecurringExpensesStateLoadedCopyWith<$Res> implements $RecurringExpensesStateCopyWith<$Res> {
  factory $RecurringExpensesStateLoadedCopyWith(RecurringExpensesStateLoaded value, $Res Function(RecurringExpensesStateLoaded) _then) = _$RecurringExpensesStateLoadedCopyWithImpl;
@useResult
$Res call({
 List<RecurringExpenseModel> expenses
});




}
/// @nodoc
class _$RecurringExpensesStateLoadedCopyWithImpl<$Res>
    implements $RecurringExpensesStateLoadedCopyWith<$Res> {
  _$RecurringExpensesStateLoadedCopyWithImpl(this._self, this._then);

  final RecurringExpensesStateLoaded _self;
  final $Res Function(RecurringExpensesStateLoaded) _then;

/// Create a copy of RecurringExpensesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? expenses = null,}) {
  return _then(RecurringExpensesStateLoaded(
null == expenses ? _self._expenses : expenses // ignore: cast_nullable_to_non_nullable
as List<RecurringExpenseModel>,
  ));
}


}

/// @nodoc


class RecurringExpensesStateError implements RecurringExpensesState {
  const RecurringExpensesStateError(this.message);
  

 final  String message;

/// Create a copy of RecurringExpensesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecurringExpensesStateErrorCopyWith<RecurringExpensesStateError> get copyWith => _$RecurringExpensesStateErrorCopyWithImpl<RecurringExpensesStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecurringExpensesStateError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'RecurringExpensesState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $RecurringExpensesStateErrorCopyWith<$Res> implements $RecurringExpensesStateCopyWith<$Res> {
  factory $RecurringExpensesStateErrorCopyWith(RecurringExpensesStateError value, $Res Function(RecurringExpensesStateError) _then) = _$RecurringExpensesStateErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$RecurringExpensesStateErrorCopyWithImpl<$Res>
    implements $RecurringExpensesStateErrorCopyWith<$Res> {
  _$RecurringExpensesStateErrorCopyWithImpl(this._self, this._then);

  final RecurringExpensesStateError _self;
  final $Res Function(RecurringExpensesStateError) _then;

/// Create a copy of RecurringExpensesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(RecurringExpensesStateError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$BudgetState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BudgetState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BudgetState()';
}


}

/// @nodoc
class $BudgetStateCopyWith<$Res>  {
$BudgetStateCopyWith(BudgetState _, $Res Function(BudgetState) __);
}


/// Adds pattern-matching-related methods to [BudgetState].
extension BudgetStatePatterns on BudgetState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( BudgetStateInitial value)?  initial,TResult Function( BudgetStateLoading value)?  loading,TResult Function( BudgetStateLoaded value)?  loaded,TResult Function( BudgetStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case BudgetStateInitial() when initial != null:
return initial(_that);case BudgetStateLoading() when loading != null:
return loading(_that);case BudgetStateLoaded() when loaded != null:
return loaded(_that);case BudgetStateError() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( BudgetStateInitial value)  initial,required TResult Function( BudgetStateLoading value)  loading,required TResult Function( BudgetStateLoaded value)  loaded,required TResult Function( BudgetStateError value)  error,}){
final _that = this;
switch (_that) {
case BudgetStateInitial():
return initial(_that);case BudgetStateLoading():
return loading(_that);case BudgetStateLoaded():
return loaded(_that);case BudgetStateError():
return error(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( BudgetStateInitial value)?  initial,TResult? Function( BudgetStateLoading value)?  loading,TResult? Function( BudgetStateLoaded value)?  loaded,TResult? Function( BudgetStateError value)?  error,}){
final _that = this;
switch (_that) {
case BudgetStateInitial() when initial != null:
return initial(_that);case BudgetStateLoading() when loading != null:
return loading(_that);case BudgetStateLoaded() when loaded != null:
return loaded(_that);case BudgetStateError() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<BudgetStatusModel> budgets)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case BudgetStateInitial() when initial != null:
return initial();case BudgetStateLoading() when loading != null:
return loading();case BudgetStateLoaded() when loaded != null:
return loaded(_that.budgets);case BudgetStateError() when error != null:
return error(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<BudgetStatusModel> budgets)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case BudgetStateInitial():
return initial();case BudgetStateLoading():
return loading();case BudgetStateLoaded():
return loaded(_that.budgets);case BudgetStateError():
return error(_that.message);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<BudgetStatusModel> budgets)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case BudgetStateInitial() when initial != null:
return initial();case BudgetStateLoading() when loading != null:
return loading();case BudgetStateLoaded() when loaded != null:
return loaded(_that.budgets);case BudgetStateError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class BudgetStateInitial implements BudgetState {
  const BudgetStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BudgetStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BudgetState.initial()';
}


}




/// @nodoc


class BudgetStateLoading implements BudgetState {
  const BudgetStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BudgetStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BudgetState.loading()';
}


}




/// @nodoc


class BudgetStateLoaded implements BudgetState {
  const BudgetStateLoaded(final  List<BudgetStatusModel> budgets): _budgets = budgets;
  

 final  List<BudgetStatusModel> _budgets;
 List<BudgetStatusModel> get budgets {
  if (_budgets is EqualUnmodifiableListView) return _budgets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_budgets);
}


/// Create a copy of BudgetState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BudgetStateLoadedCopyWith<BudgetStateLoaded> get copyWith => _$BudgetStateLoadedCopyWithImpl<BudgetStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BudgetStateLoaded&&const DeepCollectionEquality().equals(other._budgets, _budgets));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_budgets));

@override
String toString() {
  return 'BudgetState.loaded(budgets: $budgets)';
}


}

/// @nodoc
abstract mixin class $BudgetStateLoadedCopyWith<$Res> implements $BudgetStateCopyWith<$Res> {
  factory $BudgetStateLoadedCopyWith(BudgetStateLoaded value, $Res Function(BudgetStateLoaded) _then) = _$BudgetStateLoadedCopyWithImpl;
@useResult
$Res call({
 List<BudgetStatusModel> budgets
});




}
/// @nodoc
class _$BudgetStateLoadedCopyWithImpl<$Res>
    implements $BudgetStateLoadedCopyWith<$Res> {
  _$BudgetStateLoadedCopyWithImpl(this._self, this._then);

  final BudgetStateLoaded _self;
  final $Res Function(BudgetStateLoaded) _then;

/// Create a copy of BudgetState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? budgets = null,}) {
  return _then(BudgetStateLoaded(
null == budgets ? _self._budgets : budgets // ignore: cast_nullable_to_non_nullable
as List<BudgetStatusModel>,
  ));
}


}

/// @nodoc


class BudgetStateError implements BudgetState {
  const BudgetStateError(this.message);
  

 final  String message;

/// Create a copy of BudgetState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BudgetStateErrorCopyWith<BudgetStateError> get copyWith => _$BudgetStateErrorCopyWithImpl<BudgetStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BudgetStateError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'BudgetState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $BudgetStateErrorCopyWith<$Res> implements $BudgetStateCopyWith<$Res> {
  factory $BudgetStateErrorCopyWith(BudgetStateError value, $Res Function(BudgetStateError) _then) = _$BudgetStateErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$BudgetStateErrorCopyWithImpl<$Res>
    implements $BudgetStateErrorCopyWith<$Res> {
  _$BudgetStateErrorCopyWithImpl(this._self, this._then);

  final BudgetStateError _self;
  final $Res Function(BudgetStateError) _then;

/// Create a copy of BudgetState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(BudgetStateError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ExpenseTrendsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseTrendsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExpenseTrendsState()';
}


}

/// @nodoc
class $ExpenseTrendsStateCopyWith<$Res>  {
$ExpenseTrendsStateCopyWith(ExpenseTrendsState _, $Res Function(ExpenseTrendsState) __);
}


/// Adds pattern-matching-related methods to [ExpenseTrendsState].
extension ExpenseTrendsStatePatterns on ExpenseTrendsState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ExpenseTrendsStateInitial value)?  initial,TResult Function( ExpenseTrendsStateLoading value)?  loading,TResult Function( ExpenseTrendsStateLoaded value)?  loaded,TResult Function( ExpenseTrendsStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ExpenseTrendsStateInitial() when initial != null:
return initial(_that);case ExpenseTrendsStateLoading() when loading != null:
return loading(_that);case ExpenseTrendsStateLoaded() when loaded != null:
return loaded(_that);case ExpenseTrendsStateError() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ExpenseTrendsStateInitial value)  initial,required TResult Function( ExpenseTrendsStateLoading value)  loading,required TResult Function( ExpenseTrendsStateLoaded value)  loaded,required TResult Function( ExpenseTrendsStateError value)  error,}){
final _that = this;
switch (_that) {
case ExpenseTrendsStateInitial():
return initial(_that);case ExpenseTrendsStateLoading():
return loading(_that);case ExpenseTrendsStateLoaded():
return loaded(_that);case ExpenseTrendsStateError():
return error(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ExpenseTrendsStateInitial value)?  initial,TResult? Function( ExpenseTrendsStateLoading value)?  loading,TResult? Function( ExpenseTrendsStateLoaded value)?  loaded,TResult? Function( ExpenseTrendsStateError value)?  error,}){
final _that = this;
switch (_that) {
case ExpenseTrendsStateInitial() when initial != null:
return initial(_that);case ExpenseTrendsStateLoading() when loading != null:
return loading(_that);case ExpenseTrendsStateLoaded() when loaded != null:
return loaded(_that);case ExpenseTrendsStateError() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<ExpenseTrendModel> trends)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ExpenseTrendsStateInitial() when initial != null:
return initial();case ExpenseTrendsStateLoading() when loading != null:
return loading();case ExpenseTrendsStateLoaded() when loaded != null:
return loaded(_that.trends);case ExpenseTrendsStateError() when error != null:
return error(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<ExpenseTrendModel> trends)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case ExpenseTrendsStateInitial():
return initial();case ExpenseTrendsStateLoading():
return loading();case ExpenseTrendsStateLoaded():
return loaded(_that.trends);case ExpenseTrendsStateError():
return error(_that.message);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<ExpenseTrendModel> trends)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case ExpenseTrendsStateInitial() when initial != null:
return initial();case ExpenseTrendsStateLoading() when loading != null:
return loading();case ExpenseTrendsStateLoaded() when loaded != null:
return loaded(_that.trends);case ExpenseTrendsStateError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ExpenseTrendsStateInitial implements ExpenseTrendsState {
  const ExpenseTrendsStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseTrendsStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExpenseTrendsState.initial()';
}


}




/// @nodoc


class ExpenseTrendsStateLoading implements ExpenseTrendsState {
  const ExpenseTrendsStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseTrendsStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExpenseTrendsState.loading()';
}


}




/// @nodoc


class ExpenseTrendsStateLoaded implements ExpenseTrendsState {
  const ExpenseTrendsStateLoaded(final  List<ExpenseTrendModel> trends): _trends = trends;
  

 final  List<ExpenseTrendModel> _trends;
 List<ExpenseTrendModel> get trends {
  if (_trends is EqualUnmodifiableListView) return _trends;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_trends);
}


/// Create a copy of ExpenseTrendsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseTrendsStateLoadedCopyWith<ExpenseTrendsStateLoaded> get copyWith => _$ExpenseTrendsStateLoadedCopyWithImpl<ExpenseTrendsStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseTrendsStateLoaded&&const DeepCollectionEquality().equals(other._trends, _trends));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_trends));

@override
String toString() {
  return 'ExpenseTrendsState.loaded(trends: $trends)';
}


}

/// @nodoc
abstract mixin class $ExpenseTrendsStateLoadedCopyWith<$Res> implements $ExpenseTrendsStateCopyWith<$Res> {
  factory $ExpenseTrendsStateLoadedCopyWith(ExpenseTrendsStateLoaded value, $Res Function(ExpenseTrendsStateLoaded) _then) = _$ExpenseTrendsStateLoadedCopyWithImpl;
@useResult
$Res call({
 List<ExpenseTrendModel> trends
});




}
/// @nodoc
class _$ExpenseTrendsStateLoadedCopyWithImpl<$Res>
    implements $ExpenseTrendsStateLoadedCopyWith<$Res> {
  _$ExpenseTrendsStateLoadedCopyWithImpl(this._self, this._then);

  final ExpenseTrendsStateLoaded _self;
  final $Res Function(ExpenseTrendsStateLoaded) _then;

/// Create a copy of ExpenseTrendsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? trends = null,}) {
  return _then(ExpenseTrendsStateLoaded(
null == trends ? _self._trends : trends // ignore: cast_nullable_to_non_nullable
as List<ExpenseTrendModel>,
  ));
}


}

/// @nodoc


class ExpenseTrendsStateError implements ExpenseTrendsState {
  const ExpenseTrendsStateError(this.message);
  

 final  String message;

/// Create a copy of ExpenseTrendsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseTrendsStateErrorCopyWith<ExpenseTrendsStateError> get copyWith => _$ExpenseTrendsStateErrorCopyWithImpl<ExpenseTrendsStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseTrendsStateError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ExpenseTrendsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ExpenseTrendsStateErrorCopyWith<$Res> implements $ExpenseTrendsStateCopyWith<$Res> {
  factory $ExpenseTrendsStateErrorCopyWith(ExpenseTrendsStateError value, $Res Function(ExpenseTrendsStateError) _then) = _$ExpenseTrendsStateErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ExpenseTrendsStateErrorCopyWithImpl<$Res>
    implements $ExpenseTrendsStateErrorCopyWith<$Res> {
  _$ExpenseTrendsStateErrorCopyWithImpl(this._self, this._then);

  final ExpenseTrendsStateError _self;
  final $Res Function(ExpenseTrendsStateError) _then;

/// Create a copy of ExpenseTrendsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ExpenseTrendsStateError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
