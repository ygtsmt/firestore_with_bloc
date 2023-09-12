import 'package:firestore_with_bloc/model.dart';
import 'package:flutter/material.dart';
@immutable
abstract class TodoEvent {}

class LoadTodos extends TodoEvent {}

class AddTodo extends TodoEvent {
  final Todo todo;

  AddTodo(this.todo);
}

class UpdateTodo extends TodoEvent {
  final Todo todo;

  UpdateTodo(this.todo);
}

class DeleteTodo extends TodoEvent {
  final String todoId;

  DeleteTodo(this.todoId);
}