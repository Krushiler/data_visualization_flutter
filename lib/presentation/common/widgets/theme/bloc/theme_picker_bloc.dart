import 'package:bloc/bloc.dart';
import 'package:data_visualization/data/repository/config_repository.dart';
import 'package:data_visualization/domain/model/config/theme_config.dart';
import 'package:data_visualization/presentation/util/bloc_transformer_util.dart';
import 'package:data_visualization/presentation/util/subscription_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_picker_event.dart';

part 'theme_picker_state.dart';

part 'theme_picker_bloc.freezed.dart';

class ThemePickerBloc extends Bloc<ThemePickerEvent, ThemePickerState> with SubscriptionBloc {
  final ConfigRepository _configRepository;

  ThemePickerBloc(this._configRepository) : super(const ThemePickerState()) {
    on<ThemeChanged>((event, emit) {
      emit(state.copyWith(theme: event.theme));
      add(_UpdateThemeRequested(event.theme));
    });

    on<_UpdateThemeRequested>((event, emit) {
      _configRepository.applyThemeConfig(event.theme);
    }, transformer: debounceSequential(const Duration(milliseconds: 500)));

    on<_RemoteThemeUpdated>((event, emit) {
      emit(state.copyWith(theme: event.theme));
    });

    subscribe(_configRepository.watchThemeConfig(), (event) {
      add(ThemePickerEvent.remoteThemeUpdated(event));
    });
  }
}
