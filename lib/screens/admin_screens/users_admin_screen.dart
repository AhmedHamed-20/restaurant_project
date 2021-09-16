import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/models/bloc/cubits/admin_cubit.dart';
import 'package:resturant/models/bloc/states/admin_state.dart';
import 'package:resturant/models/cach/chach.dart';

class UsersAdmin extends StatelessWidget {
  const UsersAdmin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AdminCubit.get(context);
    String token = CachFunc.getData('token');
    // Admincubit.getAllusers(token);
    return BlocConsumer<AdminCubit, AdminState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: cubit.allUser.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              NetworkImage('${cubit.allUser[index]['photo']}'),
                        ),
                        title: Text('${cubit.allUser[index]['name']}'),
                        subtitle: Text('${cubit.allUser[index]['email']}'),
                        trailing: MaterialButton(
                          onPressed: () {
                            cubit.deleteUserById(
                                token, cubit.allUser[index]['_id']);
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.orangeAccent,
                          ),
                        ),
                      );
                    }),
              )
            ],
          );
        },
        listener: (context, state) {});
  }
}
