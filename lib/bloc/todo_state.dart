import 'package:firestore_with_bloc/model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<Todo> todos;

  TodoLoaded(this.todos);
}

class TodoOperationSuccess extends TodoState {
  final String message;

  TodoOperationSuccess(this.message);
}

class TodoError extends TodoState {
  final String errorMessage;

  TodoError(this.errorMessage);
}