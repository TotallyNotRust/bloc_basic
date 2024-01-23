part of 'counter_bloc.dart';

@immutable
abstract class CounterEvent {}

class CounterIncrement implements CounterEvent {
  CounterIncrement(this.amount);
  final int amount;
}

class CounterReset implements CounterEvent {}
class CounterSave implements CounterEvent {}
class CounterLoad implements CounterEvent {}