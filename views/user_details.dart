import 'package:flutter/material.dart';
import 'package:network_flutter/models/user_model.dart';

class UserDetails extends StatefulWidget {
   User userData;
   UserDetails({super.key,required this.userData});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userData.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Name: ${widget.userData.name}'),
            Text('Username: ${widget.userData.username}'),
            Text('Email: ${widget.userData.email}'),
            Text('Phone: ${widget.userData.phone}'),
            Text('Website: ${widget.userData.website}'),
            Text('Company: ${widget.userData.company.name}'),
            Text('Address: ${widget.userData.address.street}, ${widget.userData.address.suite}, ${widget.userData.address.city}, ${widget.userData.address.zipcode}'),
          ],
        ),
      ),
    );
  }
}
