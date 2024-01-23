import 'package:bloc_basic/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Counter"), centerTitle: true, backgroundColor: Colors.pink,),
      body: BlocProvider(
        create: (context) => CounterBloc()..add(CounterLoad()),
        child: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            return Center(
              child: Column(
                children: [
                  Text(state.count.toString(), style: const TextStyle(fontSize: 25),),
                  ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        IconButton(onPressed: () {
                          BlocProvider.of<CounterBloc>(context).add(CounterIncrement(1));
                        }, icon: const Icon(Icons.plus_one)),
                        IconButton(onPressed: () {
                          BlocProvider.of<CounterBloc>(context).add(CounterReset());
                        }, icon: const Icon(Icons.restore)),
                    ]
                  )
                ]
              ),
            );
          },
        ),
      ),
    );
  }
}
