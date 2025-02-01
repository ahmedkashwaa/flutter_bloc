import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  String errorMessage = "";




  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(context.tr('sign_up')),
      ),
      body: Column(
        children: [
          // i want to make form here

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
                child: Column(
              children: [
                TextFormField(
                  validator: (value){
                    // check that value is not empty and first letter is capital
                    if (value == null || value.isEmpty) {
                      errorMessage = "Please enter name";
                      return errorMessage;
                    } else if(value[0] != value[0].toUpperCase()){
                      errorMessage = "First letter should be capital";
                      return errorMessage;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: tr("name"),
                    hintText: "Enter your name"
                  ),
                ),
                TextFormField(
                  validator: (value){
                    // check that value is not empty and email is valid
                    if (value == null || value.isEmpty) {
                      errorMessage = "Please enter email";
                      return errorMessage;
                    } else if(!value.contains("@")){
                      errorMessage = "Email is not valid";
                      return errorMessage;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: tr("email"),
                    hintText: "Enter your email"
                  ),
                ),
                TextFormField(
                  validator: (value){
                    // check that value is not empty and password is atleast 6 characters long
                    if (value == null || value.isEmpty) {
                      errorMessage= "Please enter password";
                      return errorMessage;
                    } else if(value.length < 6){
                      errorMessage = "Password should be atleast 6 characters";
                      return errorMessage;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: tr("password"),
                    hintText: "Enter your password"
                  ),
                ),
                TextFormField(
                  validator: (value){
                    // check that value is not empty and matches with password
                    if (value == null || value.isEmpty) {
                      errorMessage = "Please enter password";
                      return errorMessage;
                    } else if(value.compareTo(_passwordController.text)==false){
                      errorMessage = "Password does not match";
                      return errorMessage;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: tr("confirm_password"),
                    hintText: "Enter your password again"
                  ),
                ),
                ElevatedButton(onPressed: (){
                  // check if form is valid
                  if (_formKey.currentState!.validate()) {
                    _showSuccessDialog();
                  } else {
                    _showErrorSnackBar();
                  }
                }, child: Text(tr("sign_up")))
                ,
                ElevatedButton(onPressed: (){
                  if(context.locale.toString() == "en_US"){
                    context.setLocale(Locale('ar', 'EG'));
                  } else {
                    context.setLocale(Locale('en', 'US'));
                  }
                  print(context.locale.toString());
                }, child: Text("Change Language"))
              ],
            )),
          )
        ],
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>  MyHomePage(title: "Home",),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Success'),
        content: Text('account created successfully'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              _navigateToShoppingScreen();

            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _navigateToShoppingScreen() {
    Navigator.push(context, _createRoute());

  }

  void _showErrorSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
    );
  }

}
