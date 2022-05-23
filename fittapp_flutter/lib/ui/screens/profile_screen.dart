import 'package:fitapp_flutter/bloc/user/user_bloc.dart';
import 'package:fitapp_flutter/models/exercise_response.dart';
import 'package:fitapp_flutter/repository/user_repository/user_repository.dart';
import 'package:fitapp_flutter/repository/user_repository/user_repository_impl.dart';
import 'package:fitapp_flutter/ui/widgets/error_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserRepository userRepository;
  

  @override
  void initState() {
    super.initState();
    userRepository = UserRepositoryImpl();
    
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) {
        return UserBloc(userRepository)..add(const FetchUserWithType());
      },
      child: Scaffold(body: _createSeeProfile(context)),
    ));
  }

  Widget _createSeeProfile(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserFetchedError) {
          return ErrorPage(
            message: state.message,
            retry: () {
              context.watch<UserBloc>().add(const FetchUserWithType());
            },
          );
        } else if (state is UserFetched) {
          return _createProfile(context, state.usuarioDTO);
        } else {
          return const Text('Not support');
        }
      },
    );
  }

  Widget _createProfile(BuildContext context, UsuarioDTO usuarioDTO) {
    final contentWidth = MediaQuery.of(context).size.width;
    final contentHeight = MediaQuery.of(context).size.height;

    String imageUrlAvatar =
        usuarioDTO.avatar.replaceAll("http://localhost:8080", Constant.apiUrl);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  Icon(Icons.lock),
                  SizedBox(width: 4.0),
                  Text(
                    usuarioDTO.nick,
                    style: TextStyle(color: Color.fromARGB(255, 255, 254, 254)),
                  ),
                  SizedBox(width: 12.0),
                  Container(
                    alignment: Alignment.center,
                    width: 35.0,
                    height: 25.0,
                  )
                ],
              ),
            ),
            Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.add_box_outlined),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.send),
                    )
                  ],
                ))
          ],
        )),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: new CircleAvatar(
                            backgroundImage: NetworkImage(imageUrlAvatar),
                            radius: 55.0,
                          ),
                        ),
                   
                        Column(
                          children: [
                            Text(
                              usuarioDTO.numeroSeguidores.toString(),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              "Seguidores",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              usuarioDTO.numeroSeguidos.toString(),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              "Seguidos",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Container(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Pablo Segura Velasco",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0))),
                            Text("Sevilla",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0))),
                          ])),
                  SizedBox(height: 12.0),
                 
                  SizedBox(height: 24.0),
                  Container(
                   
                  ),
                  Divider(
                    color: Colors.grey[800],
                    thickness: 2.0,
                  ),
                  SizedBox(height: 12.0),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 200.0,
                          child: Icon(Icons.grid_on_outlined,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        Container(
                          width: 150.0,
                          child: Icon(Icons.portrait_outlined,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 60.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }




}
