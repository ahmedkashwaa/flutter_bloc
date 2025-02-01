import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterInitial());
  int _counter = 0;
  void increment() {
    _counter++;
    emit(CounterUpdate(_counter));
    if (_counter == 10) {
      emit(CounterReachedTen());
    } else if (_counter == -10) {
      emit(CounterReachedNegativeTen());
    }
  }
  void decrement() {
    _counter--;
    emit(CounterUpdate(_counter));
    if (_counter == -10) {
      emit(CounterReachedNegativeTen());
    } else if (_counter == 10) {
      emit(CounterReachedTen());
  }
}
}
