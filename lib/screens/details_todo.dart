import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/bloc/todo_bloc.dart';
import 'package:to_do_app/core/theme/app_colors.dart';

final formKey = GlobalKey<FormState>();
final titleController = TextEditingController();
final descriptionController = TextEditingController();
bool isCompleted = false;

class ScreenUpdate extends StatefulWidget {
  const ScreenUpdate({super.key, required this.id, required this.map});
  final String id;
  final Map map;

  @override
  State<ScreenUpdate> createState() => _ScreenUpdateState();
}

class _ScreenUpdateState extends State<ScreenUpdate> {
  @override
  void initState() {
    super.initState();
    final note = widget.map;
    titleController.text = note['title'];
    descriptionController.text = note['description'];
    isCompleted = widget.map['is_completed'] ?? false;
  }

  @override
  void dispose() {
    super.dispose();
    titleController.text = '';
    descriptionController.text = '';
  }

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
          'UPDATE NOTES',
          style: TextStyle(
              color: AppColors.whiteColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is EditSuccessState) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(10),
              duration: Duration(seconds: 1),
              backgroundColor: Colors.green,
              content: Text(
                'Update Successfull',
                style: TextStyle(color: Colors.white),
              ),
            ));
            context.read<TodoBloc>().add(FetchSuccessEvent());
          } else if (state is EditFaildState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(10),
                duration: Duration(seconds: 1),
                backgroundColor: Colors.red,
                content: Text(
                  "did not upated",
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
                        validator: (value) => descriptionController.text.isEmpty
                            ? 'Please Enter Description'
                            : null),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: IconButton(
                        icon: Icon(
                          isCompleted
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color: AppColors.appColor,size: 40.0,
                        ),
                        onPressed: () {
                          setState(() {
                            isCompleted = !isCompleted;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          update(context, widget.id, widget.map);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 6, backgroundColor: AppColors.orageColor),
                      child: Text(
                        "UPDATE",
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

  void update(BuildContext context, String id, Map note) {
    print('Updating note with ID: $id');
    final title = titleController.text;
    final description = descriptionController.text;

    final map = {
      'title': title,
      'description': description,
      'is_completed': isCompleted,
    };
    context.read<TodoBloc>().add(EditNoteEvent(id: id, map: map));
  }
}
