part of 'todo_bloc.dart';

@immutable
sealed class TodoState {}

//add Screen

abstract class AddActionState extends TodoState {}

final class AddInitial extends TodoState {}

final class AddNoteSuccessState extends AddActionState {}

final class AddNoteErrorState extends AddActionState {}


abstract class HomeActionState extends TodoState {}

final class TodoInitial extends TodoState {}

final class HomeInitial extends TodoState {}

final class LoadingState extends TodoState {}

// ignore: must_be_immutable
final class SuccessState extends TodoState {
  List notesList = [];
  SuccessState({required this.notesList});
}

final class ErrorState extends TodoState {}

final class FromNavigationState extends HomeActionState {}

final class ShowPopupMessageState extends HomeActionState {
  final String id;
  ShowPopupMessageState({required this.id});
}

final class DeleteNoteMessageState extends HomeActionState {}

final class UpdateNavigationState extends HomeActionState {
  final String id;
  final Map map;
  UpdateNavigationState({required this.id, required this.map});
}

//edit Screen
abstract class EditActionState extends TodoState {}

final class EditInitial extends TodoState {}

final class EditSuccessState extends EditActionState {}

final class EditFaildState extends EditActionState {}
