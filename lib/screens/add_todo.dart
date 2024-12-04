import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/bloc/todo_bloc.dart';
import 'package:to_do_app/core/theme/app_colors.dart';

final formKey = GlobalKey<FormState>();
final titleController = TextEditingController();
final descriptionController = TextEditingController();

class ScreenAdd extends StatelessWidget {
  const ScreenAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.whiteColor,
            )),
        title: Text(
          'ADD NOTES',
          style: TextStyle(
              color: AppColors.whiteColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<TodoBloc, TodoState>(
        buildWhen: (previous, current) => current is! AddActionState,
        listenWhen: (previous, current) => current is AddActionState,
        listener: (context, state) {
          if (state is AddNoteSuccessState) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(10),
                duration: Duration(seconds: 1),
                backgroundColor: Colors.green,
                content: Text(
                  "Note Added Successfuly!!",
                  style: TextStyle(color: Colors.white),
                )));
            context.read<TodoBloc>().add(FetchSuccessEvent());
          } else if (state is AddNoteErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(10),
                duration: Duration(seconds: 1),
                backgroundColor: Colors.red,
                content: Text(
                  "Cancelled !!",
                  style: TextStyle(color: Colors.white),
                )));
          }
        },
        builder: (context, state) {
          return Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ListView(
                  children: [
                    TextFormField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          hintText: 'Title',
                          hintStyle: TextStyle(fontSize: 18),
                        ),
                        validator: (value) => titleController.text.isEmpty
                            ? 'Please Enter Title'
                            : null),
                    SizedBox(
                      height: 30.0,
                    ),
                    TextFormField(
                        controller: descriptionController,
                        maxLines: 10,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          hintText: 'Description',
                          hintStyle: TextStyle(fontSize: 18),
                        ),
                        validator: (value) => titleController.text.isEmpty
                            ? 'Please Enter Description'
                            : null),
                    SizedBox(
                      height: 35,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          submitData(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 6,
                          backgroundColor: AppColors.snackBarGreen),
                      child: Text(
                        "SAVE",
                        style: TextStyle(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    )
                  ],
                ),
              ));
        },
      ),
    );
  }
}

void submitData(BuildContext context) {
  final title = titleController.text;
  final description = descriptionController.text;
  final map = {
    "title": title,
    "description": description,
    "is_completed": false
  };
  context.read<TodoBloc>().add(AddNoteEvent(map: map));
  titleController.text = '';
  descriptionController.text = '';
}
