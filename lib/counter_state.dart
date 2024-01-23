part of 'counter_bloc.dart';

@immutable
abstract class _CounterState {}

class CounterState extends _CounterState {
	CounterState({this.count = 0});

	final int count;

	CounterState copyWith({int? count}) {
		return CounterState(
			count: count ?? this.count,
		);
	}
}
