part of 'dashboard_bloc.dart';

@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState({
    @Default(true) bool isLoading,
    @Default([]) List<Breed> breeds,
  }) = _DashboardState;
}
