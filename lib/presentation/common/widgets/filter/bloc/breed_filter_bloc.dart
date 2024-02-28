import 'package:bloc/bloc.dart';
import 'package:data_visualization/data/repository/breed_repository.dart';
import 'package:data_visualization/domain/model/breed/breed.dart';
import 'package:data_visualization/domain/model/breed/breed_filter.dart';
import 'package:data_visualization/presentation/util/bloc_transformer_util.dart';
import 'package:data_visualization/presentation/util/subscription_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'breed_filter_bloc.freezed.dart';
part 'breed_filter_event.dart';
part 'breed_filter_state.dart';

class BreedFilterBloc extends Bloc<BreedFilterEvent, BreedFilterState> with SubscriptionBloc {
  final BreedRepository _breedRepository;

  BreedFilterBloc(this._breedRepository) : super(const BreedFilterState()) {
    on<FilterChanged>((event, emit) {
      emit(state.copyWith(breedFilter: event.breedFilter));
      add(_UpdateFilterRequested(event.breedFilter));
    });

    on<_UpdateFilterRequested>((event, emit) {
      _breedRepository.applyFilter(event.breedFilter);
    }, transformer: debounceSequential(const Duration(milliseconds: 500)));

    on<_RemoteFilterChanged>((event, emit) {
      emit(state.copyWith(breedFilter: event.breedFilter));
    });

    on<_BreedsChanged>((event, emit) {
      emit(state.copyWith(breeds: event.breeds));
    });

    subscribe(_breedRepository.watchFilter(), (filter) {
      add(_RemoteFilterChanged(filter));
    });

    subscribe(_breedRepository.watchBreeds(), (event) {
      add(_BreedsChanged(event));
    });
  }
}
