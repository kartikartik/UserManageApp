import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_manage_app/bloc/user_offline/user_offline_bloc.dart';
import 'package:user_manage_app/bloc/user_offline/user_offline_event.dart';
import 'package:user_manage_app/bloc/user_offline/user_offline_state.dart';
import 'package:user_manage_app/model/user_offline_model.dart';
import 'package:user_manage_app/widgets/helper.dart';

class UserOfflineAddScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobController = TextEditingController();

  UserOfflineAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userofflineBloc = BlocProvider.of<UserOfflineBloc>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Create User')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocListener<UserOfflineBloc, UserOfflineState>(
          listener: (context, state) {
            if (state is UserLoading) {
              // Show loading indicator
              showDialog(
                context: context,
                barrierDismissible: false,
                builder:
                    (context) => Center(child: CircularProgressIndicator()),
              );
            } else if (state is UserError) {
              Navigator.of(context).pop(); // Dismiss loading dialog
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            } else {
              Navigator.of(context).pop();
              // Show success message
              CustomToast.show(message: 'Offline User created successfully!');

              nameController.clear();
              jobController.clear();
            }
          },
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: jobController,
                decoration: InputDecoration(labelText: 'Job'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final user = UserOfflineModel(
                    name: nameController.text,
                    job: jobController.text,
                  );
                  userofflineBloc.add(AddUser(user));
                },
                child: Text('Create User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
