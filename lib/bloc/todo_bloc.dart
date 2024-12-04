import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do_app/api/api_function.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    on<FromNavigationEvent>(formNavigation);
    on<FetchSuccessEvent>(fetchDatas);
    on<ShowDialogEvent>(showDialogEvent);
    on<DeleteNoteEvent>(deleteNoteEvent);
    on<UpdateNavigationEvent>(updateNavigation);
    on<AddNoteEvent>(addNote);
    on<EditNoteEvent>(editNoteEvent);
  }

  //add Screen
  FutureOr<void> addNote(AddNoteEvent event, Emitter<TodoState> emit) async {
    final isSuccess = await Api.addNote(event.map);

    if (isSuccess) {
      emit(AddNoteSuccessState());
    } else {
      emit(AddNoteErrorState());
    }
  }

  FutureOr<void> formNavigation(
      FromNavigationEvent event, Emitter<TodoState> emit) {
    emit(FromNavigationState());
  }

  FutureOr<void> fetchDatas(
      FetchSuccessEvent event, Emitter<TodoState> emit) async {
    emit(LoadingState());
    final notes = await Api.fetchNote();
    if (notes!.isNotEmpty) {
      emit(SuccessState(notesList: notes));
    } else {
      emit(ErrorState());
    }
  }

  FutureOr<void> deleteNoteEvent(
    DeleteNoteEvent event, Emitter<TodoState> emit) async {
  bool isDeleted = await Api.deleteById(event.id);
  if (isDeleted) {
    final notes = await Api.fetchNote();
    if (notes!.isNotEmpty) {
      emit(SuccessState(notesList: notes));
    } else {
      emit(ErrorState());
    }
  } else {
    emit(ErrorState());
  }
}

  FutureOr<void> showDialogEvent(
      ShowDialogEvent event, Emitter<TodoState> emit) {
    emit(ShowPopupMessageState(id:event.id)); 
  }

  FutureOr<void> updateNavigation(
      UpdateNavigationEvent event, Emitter<TodoState> emit) {
    emit(UpdateNavigationState(id: event.id, map: event.map));
  }

  //edit Screen
  FutureOr<void> editNoteEvent(
      EditNoteEvent event, Emitter<TodoState> emit) async {
    final isSuccess = await Api.updateNote(event.id, event.map);
    if (isSuccess) {
      emit(EditSuccessState());
    } else {
      emit(EditFaildState());
    }
  }
}
