import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'counter_event.dart';
part 'counter_state.dart';

const counterStatePrefs = "counter_state";

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState()) {
    // Sequential ensures all events are run.
    on<CounterIncrement>(counterIncrement,    transformer: sequential());
    on<CounterReset>(counterReset,            transformer: sequential());

    on<CounterLoad>(loadState);
    
    // Restartable tells the bloc to restart the event if another is run.
    // This ensures all saves are run as fast as possible.
    // OBS: If data was sent from the event, you should consider using sequential instead. 
    // I chose to use restartable because data is stored in state, and as such will always be up to date.
    on<CounterSave>(saveState, transformer: restartable());
  }

  Future counterIncrement(CounterIncrement event, Emitter<CounterState> emit) async {
    emit(state.copyWith(count: state.count + event.amount));

    add(CounterSave());

  }
  void counterReset(CounterReset event, Emitter<CounterState> emit) {
    emit(state.copyWith(count: 0));
    
    add(CounterSave());
  }

  Future saveState(event, Emitter<CounterState> emit) async {
    if (event is CounterLoad) return;

    final prefs = await SharedPreferences.getInstance();

    prefs.setInt(counterStatePrefs, state.count);
  }

  Future loadState(event, Emitter<CounterState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    
    if (prefs.containsKey(counterStatePrefs)) {
      emit(state.copyWith(count: prefs.getInt(counterStatePrefs)));
    }
  }
}