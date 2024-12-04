import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/bloc/todo_bloc.dart';
import 'package:to_do_app/core/theme/app_colors.dart';
import 'package:to_do_app/screens/widget/alert_dialogs.dart';

class TodoItems extends StatelessWidget {
  const TodoItems({
    super.key,
    required this.id,
    required this.note,
  });

  final String id;
  final Map note;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: () {
          context
              .read<TodoBloc>()
              .add(UpdateNavigationEvent(id: id, map: note));
        },
        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: AppColors.appBarColor,
        leading: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: note['is_completed'] ?? false
                ? AppColors.snackBarGreen
                : AppColors.orageColor,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        title: Text(
          note['title'] ?? '',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.whiteColor,
            decoration: note['is_completed'] ?? false
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: AppColors.snackBarRed,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            onPressed: () {
              // context.read<TodoBloc>().add(ShowDialogEvent(id: id));
              // print('$id');
              showDeleteConfirmationDialog(context, id);
            },
            icon: Icon(
              Icons.delete,
            ),
            color: AppColors.whiteColor,
            iconSize: 18,
          ),
        ),
      ),
    );
  }
}
