import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_algoriza/business_logic/app_cubit/app_states.dart';
import 'package:to_do_algoriza/presentation/widgets/generate_color.dart';

class TodoCubit extends Cubit<TodoStates>{


  TodoCubit() : super(InitialState());

  static TodoCubit get(context)=> BlocProvider.of(context);

  var titleController=TextEditingController();
  var deadlineController=TextEditingController();
  var startTimeController=TextEditingController();
  var endTimeController=TextEditingController();


  String remindValue='';
  void remindDropDown(value){

    remindValue=value;
    emit(RemindDropDownState());
  }

  String repeatValue='';
  void repeatDropDown(value){

    repeatValue=value;
    emit(RepeatDropDownState());
  }


  Database ?database;
  String time='${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}';
  List <Map>  allTasks=[];
  List <Map> unCompleted=[];
  List <Map> completed=[];
  List <Map> favorite=[];
  List <Map> schedule=[];




  void createDatabase() async {

    return await openDatabase(
        'todo.db',
        version: 1,
        onCreate: (database,version){
          database.execute(
              'CREATE TABLE todo (id INTEGER PRIMARY KEY , title TEXT , deadline TEXT, start TEXT, end TEXT, remind TEXT, repeat TEXT, state TEXT ,color INTEGER, favorite TEXT)'
          ).then((value) {
            print('Table Created');
            emit(CreateTableState());
          });
        },
        onOpen: (database){

          getDatabase(database).then((value){
            allTasks=value;
          }).catchError((error){
            print('error i ${error.toString()}');
          });
          print('Database Opened');
        }

    ).then((value) {
      database=value;
      print('Database Created');
      emit(CreateDatabaseSuccessState());
    }).catchError((error){
      print('error is ${error.toString()}');
      emit(CreateDatabaseErrorState());

    });
  }

  Future insertDatabase(
      {
        required String title,
        required String deadline,
        required String start,
        required String end,
        required String remind,
        required String repeat,
      }) async{

    return database?.transaction((txn) {
      return txn.rawInsert(
          'INSERT INTO todo (title,deadline,start,end,remind,repeat,state,color,favorite) VALUES ( "${title}" , "${deadline}" , "${start}" , "${end}" , "${remind}" , "${repeat}" ,"unComplete","${generateRandomColor().value}","no")'
      ).then((value) {
        print("${value} Insert Success");
        emit(InsertDatabaseSuccessState());
        getDatabase(database).then((value){
          allTasks=value;
        });
        emit(InsertDatabaseSuccessState());

      }).catchError((error){
        print('Error is ${error.toString()}');
      });

    });

  }


  Future <List<Map>> getDatabase(database)async {

    allTasks=[];
    completed=[];
    unCompleted=[];
    favorite=[];
    schedule=[];

    return await database?.rawQuery(
        'SELECT * FROM todo'
    ).then((value) {
      print(value[0]['color']);
      print(value[0]['deadline']);
      print(time);


      value.forEach((element){


        if(element['state']=='new'){
          allTasks.add(element);
        }
        else if(element['state']=='completed')
        {
          completed.add(element);
          allTasks.add(element);

        }
        else if(element['state']=='unComplete')
        {
          print('Here kgldfkgldf');

          unCompleted.add(element);
          allTasks.add(element);

        }


        if(element['favorite']=='yes')
        {
          print('Here');
          favorite.add(element);

        }

        if(element['deadline']==time){
          schedule.add(element);
          print('siiiiiiiiiiiiiiii');
          print(schedule.length);
        }


      });

      print(allTasks);
      emit(GetDatabaseSuccessState());
    }).catchError((error){
      print('GetError is ${error.toString()}');
    });
  }

  void updateDatabase(
      {
        required String S,
        required int id,
      }
      ) async{

    database?.rawUpdate(

        'UPDATE todo SET state = ? WHERE id = ?',
        ['$S', '$id']).then((value) {
      print('Update Done');
      getDatabase(database);
      emit(UpdateDatabaseSuccessState());
    }).catchError((error){
      print('error is ${error.toString()}');
    });

  }

  void updateFavorite(
      {
        required String F,
        required int id,
      }
      ) async{

    database?.rawUpdate(

        'UPDATE todo SET favorite = ? WHERE id = ?',
        ['$F', '$id']).then((value) {
      print('Update Done');
      getDatabase(database);
      emit(UpdateFavoriteSuccessState());
    }).catchError((error){
      print('error is ${error.toString()}');
    });

  }


  void deleteDatabase(
      {
        required int id,
      }
      ) async{

    database?.rawDelete(
        'DELETE FROM todo WHERE id = ?', ['$id'])
        .then((value) {
      getDatabase(database);
      emit(DeleteDatabaseSuccessState());
    }).catchError((error){
      print('error is ${error.toString()}');
    });

  }



}