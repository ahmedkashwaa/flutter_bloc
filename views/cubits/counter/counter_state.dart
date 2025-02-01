part of 'counter_cubit.dart';

@immutable
sealed class CounterState {}

final class CounterInitial extends CounterState {}
final class CounterReachedTen extends CounterState {}
final class CounterReachedNegativeTen extends CounterState {}
final class CounterUpdate extends CounterState {
  final int counter;
  CounterUpdate(this.counter);
}
