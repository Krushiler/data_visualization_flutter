import 'package:bloc/bloc.dart';
import 'package:data_visualization/data/repository/breed_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final BreedRepository _breedRepository;

  HomeCubit(this._breedRepository) : super(const HomeState());

  void init() {
    _breedRepository.fetchBreeds();
  }
}
