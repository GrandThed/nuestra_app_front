import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuestra_app/features/household/data/models/household_model.dart';

part 'household_state.freezed.dart';

@freezed
sealed class HouseholdState with _$HouseholdState {
  const factory HouseholdState.initial() = HouseholdStateInitial;
  const factory HouseholdState.loading() = HouseholdStateLoading;
  const factory HouseholdState.loaded(HouseholdModel household) = HouseholdStateLoaded;
  const factory HouseholdState.error(String message) = HouseholdStateError;
}
