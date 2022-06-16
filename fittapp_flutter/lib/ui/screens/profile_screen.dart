import 'package:fitapp_flutter/bloc/user/user_bloc.dart';
import 'package:fitapp_flutter/models/exercise/exercise_response.dart';
import 'package:fitapp_flutter/models/user/user_dto.dart';
import 'package:fitapp_flutter/repository/DietRepository/diet_repository.dart';
import 'package:fitapp_flutter/repository/DietRepository/diet_repository_impl.dart';
import 'package:fitapp_flutter/repository/ExerciseRepository/exercise_repository.dart';
import 'package:fitapp_flutter/repository/ExerciseRepository/exercise_repository_impl.dart';
import 'package:fitapp_flutter/repository/user_repository/user_repository.dart';
import 'package:fitapp_flutter/repository/user_repository/user_repository_impl.dart';
import 'package:fitapp_flutter/ui/widgets/error_page.dart';
import 'package:fitapp_flutter/ui/widgets/home_app_bar.dart';
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
  late ExerciseRepository exerciseRepository;
  late DietRepository dietRepository;
  

  @override
  void initState() {
    super.initState();
    userRepository = UserRepositoryImpl();
    exerciseRepository = ExerciseRepositoryImpl();
    dietRepository = DietRepositoryImpl();
    
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

 _createExerciseUser(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state is UserInitial) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is UserFetched) {
        return _buildExerciseUser(context, state.usuarioDTO);
      } else {
        return const Text('Not support');
      }
    });
  }

   _buildExerciseUser(BuildContext context, UsuarioDTO user) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: GridView.count(
        crossAxisCount: 3,
        children: List.generate(user.listFavExercises.length, (index) {
          String urlExercise = user.listFavExercises
              .elementAt(index)
              .imagen;
       
               String urlTitle = user.listFavExercises
              .elementAt(index)
              .title;
           
          return GestureDetector(
            child: Card(

              child: Column(
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: Image.network(
                      urlExercise,
                    
                  fit: BoxFit.fill,
                    ),
                    
                    
                    
                  ),
                  Text(urlTitle)
                ],
              ),
              
            ),
          );
        }),
      ),
    );
  }

   _createDietUser(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state is UserInitial) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is UserFetched) {
        return _buildDietUser(context, state.usuarioDTO);
      } else {
        return const Text('Not support');
      }
    });
  }

   _buildDietUser(BuildContext context, UsuarioDTO user) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: GridView.count(
        crossAxisCount: 3,
        children: List.generate(user.listFavDiets.length, (index) {
          String urlDiet = user.listFavDiets
              .elementAt(index)
              .imagen;
              
                String urlTitle = user.listFavDiets
              .elementAt(index)
              .title;
            
          return Container(
            child: Card(

              child: Column(
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: Image.network(
                      urlDiet,
                    
                    fit: BoxFit.fill,
                    ),
                    
                    
                  ),
                  Text(urlTitle)
                ],
              ),
              
            ),
          );
        }),
      ),
    );
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
        usuarioDTO.avatar;

    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(0.0),
            child: ListView(
              
              children: [
                
                Container(
                  color: Colors.white,
                  child: Column(
                    
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            
                            child: Row(
                              
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Container(
                                  
                                    child: new CircleAvatar(
                                      backgroundImage: NetworkImage(imageUrlAvatar),
                                      radius: 80.0,
                                    ),
                                  ),
                                ),
                           
                         
                              ],
                            ),
                          ),
                          SizedBox(height: 12.0),
                          Center(
                            child: Container(
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(usuarioDTO.nickname,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 30,
                                              fontStyle: FontStyle.italic,
                                               ),
                                              ),

                                           Text(usuarioDTO.email,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontStyle: FontStyle.italic,
                                               ),
                                              ),

                                             
                                     
                                    ])),
                          ),
                        
                                   
                                   Divider(
                            color: Colors.grey[800],
                            thickness: 2.0,
                          ),
                    
                             Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'MIS EJERCICIOS',
                              style: TextStyle(
                                fontSize: 12,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 4
                                  ..color = Colors.red[700]!,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'MIS EJERCICIOS',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.red[100],
                              ),
                            ),
                          ),
                    
                        ],
                                  ),
                                   Container(
                            width: 350,
                            height: 350,
                           child: _createExerciseUser(context),    
                                  ),
                    
                    
                             Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'MIS PLATOS',
                              style: TextStyle(
                                fontSize: 12,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 4
                                  ..color = Colors.red[700]!,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'MIS PLATOS',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.red[100],
                              ),
                            ),
                          ),
                        ],
                                  ),
                            Container(
                           width: 350,
                            height: 350,
                           child: _createDietUser(context),    
                                  ),
                    
                        
                    
                    
                                  
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }




}
