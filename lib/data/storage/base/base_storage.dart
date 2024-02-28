import 'package:rxdart/rxdart.dart';

abstract class BaseStorage<T> {
  final BehaviorSubject<T> _data = BehaviorSubject();

  Stream<T> watch() => _data.stream;

  void put(T data) {
    _data.add(data);
  }
}
