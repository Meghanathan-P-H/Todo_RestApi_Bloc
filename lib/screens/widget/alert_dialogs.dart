import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/bloc/todo_bloc.dart';
import 'package:to_do_app/core/theme/app_colors.dart';

void showDeleteConfirmationDialog(BuildContext context, String id) {
  print('$id');
  AwesomeDialog(
    context: context,
    dialogType: DialogType.warning,
    animType: AnimType.rightSlide,
    title: 'Delete',
    desc: 'Do you want to delete this item?',
    btnCancelOnPress: () {},
    btnOkOnPress: () => context.read<TodoBloc>().add(DeleteNoteEvent(id: id)),
    btnCancelText: 'Cancel',
    btnOkText: 'Delete',
    btnOkColor: AppColors.snackBarRed,
  ).show();
}

