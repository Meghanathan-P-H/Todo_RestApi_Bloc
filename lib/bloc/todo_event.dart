part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

//add Screen

final class AddNoteEvent extends TodoEvent {
  final Map map;

  AddNoteEvent({required this.map});
}

////Home Screen
abstract class HomeActionEvent extends TodoEvent {}

final class FetchSuccessEvent extends HomeActionEvent {}

final class FromNavigationEvent extends HomeActionEvent {}

final class DeleteNoteEvent extends HomeActionEvent {
  final String id;
  DeleteNoteEvent({required this.id});
}

final class ShowDialogEvent extends HomeActionEvent {
  final String id;
  ShowDialogEvent({required this.id});
}

final class UpdateNavigationEvent extends HomeActionEvent {
  final String id;
  final Map map;
  UpdateNavigationEvent({required this.id, required this.map});
}

//edit Screen
final class EditNoteEvent extends TodoEvent {
  final String id;
  final Map map;
  EditNoteEvent({required this.id, required this.map});
}
