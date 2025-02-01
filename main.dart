import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_flutter/services/user_service.dart';
import 'package:network_flutter/views/cubits/counter/counter_cubit.dart';
import 'package:network_flutter/views/cubits/user/users_cubit.dart';
import 'package:network_flutter/views/user_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/user_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
      EasyLocalization(
          supportedLocales: [Locale('en', 'US'), Locale('ar', 'EG')],
          path: 'lang', // <-- change the path of the translation files
          fallbackLocale: Locale('en', 'US'),
          child: MyApp()
      ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home:  BlocProvider(
  create: (context) => CounterCubit(),
  child: MyHomePage(title: "Network Flutter"),
),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<User> users = [];
  bool loading = true;
  /*
  void getUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey('users')){
      final data = jsonDecode(prefs.getString('users')!);
      data.forEach((user) {
        users.add(User.fromJson(user));
      });
    }
    else {
      users = await UserService().getUsers();
    }

    setState(() {
      loading = false;

    });
  }
  */
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  //  getUsers();
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),

      ),
      body:  BlocConsumer<CounterCubit, CounterState>(
        listener: (context, state) {
          if(state is CounterReachedTen){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Counter is 10")));
            _counter = 10;
          }
          if (state is CounterReachedNegativeTen){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Counter is -10')));
            _counter = -10;
          }
        },
        builder: (context, state) {
          if(state is CounterUpdate){
            _counter = state.counter;
          }
          
          return Center(child: Text('Counter: ${_counter}'),);

        },
      )
      ,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: (){
              context.read<CounterCubit>().decrement();
            },
            tooltip: 'Decrement',
            child: const Icon(Icons.remove_rounded),
          ),
          SizedBox(width: 8,),
          FloatingActionButton(
            onPressed: (){
              context.read<CounterCubit>().increment();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),

        ],
      ),
    );
  }
  /*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body:  BlocConsumer<UsersCubit, UsersState>(
        listener: (context, state) {
          if(state is UsersError){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is UsersLoaded){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Users Loaded')));
          }
        },
      builder: (context, state) {
        if(state is UsersLoading){
          return Center(child: CircularProgressIndicator(),);
        }
        if(state is UsersLoaded){
          return  ListView.builder(
            itemCount: state.users.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setString('email', state.users[index].email);
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserDetails(userData: state.users[index])));
                },
                child: ListTile(
                  title: Text(state.users[index].name),
                  subtitle: Text(state.users[index].email),
                  trailing: Icon(Icons.person),
                ),
              );
            },
          );
        }
        if(state is UsersError){
          return Center(child: Text(state.message),);
        }
        return Container();

      },
      )
     ,
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
  */
}
