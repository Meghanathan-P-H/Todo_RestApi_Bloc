import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/bloc/todo_bloc.dart';
import 'package:to_do_app/core/theme/app_colors.dart';
import 'package:to_do_app/screens/add_todo.dart';
import 'package:to_do_app/screens/details_todo.dart';
import 'package:to_do_app/screens/widget/alert_dialogs.dart';
import 'package:to_do_app/screens/widget/todo_items.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  void initState() {
    super.initState();
    context.read<TodoBloc>().add(FetchSuccessEvent());
  }

  late String id;
  late Map note;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Visibility(
            visible: true,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ScreenAdd()));
              },
              backgroundColor: AppColors.appColor,
              shape: CircleBorder(),
              elevation: 2,
              child: Icon(
                Icons.add,
                color: AppColors.whiteColor,
              ),
            )),
        appBar: AppBar(
          title: const Text(
            'NOTES',
            style: TextStyle(
                letterSpacing: 5,
                fontWeight: FontWeight.bold,
                color: AppColors.whiteColor),
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<TodoBloc, TodoState>(
            buildWhen: (previous, current) => current is! HomeActionState,
            listenWhen: (previos, current) => current is HomeActionState,
            listener: (context, state) {
              if (state is FromNavigationState) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ScreenAdd(),
                    ));
              } else if (state is ShowPopupMessageState) {
                showDeleteConfirmationDialog(context, state.id);
                print('this $id');
              } else if (state is UpdateNavigationState) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ScreenUpdate(id: state.id, map: state.map),
                    ));
              }
            },
            builder: (context, state) {
              if (state is SuccessState) {
                return ListView.builder(
                  itemCount: state.notesList.length,
                  itemBuilder: (context, index) {
                    note = state.notesList[index] as Map;
                    id = note['_id'];
                    // print('id is working $id');
                    return TodoItems(
                      id: id,
                      note: note,
                    );
                  },
                );
              } else if (state is LoadingState) {
                return const SizedBox.expand(
                    child: Center(child: CircularProgressIndicator()));
              } else {
                return const SizedBox.expand(
                  child: Center(
                      child: Text(
                    'empty notes',
                    style: TextStyle(
                        color: Colors.brown,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
                );
              }
            }));
  }
}
