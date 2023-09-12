import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_with_bloc/bloc/todo_bloc.dart';
import 'package:firestore_with_bloc/bloc/todo_event.dart';
import 'package:firestore_with_bloc/bloc/todo_state.dart';
import 'package:firestore_with_bloc/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  void initState() {
    BlocProvider.of<TodoBloc>(context).add(LoadTodos());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TodoBloc _todoBloc = BlocProvider.of<TodoBloc>(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Firestore'),
          ),
          body: BlocBuilder<TodoBloc, TodoState>(
            builder: (context, state) {
              if (state is TodoLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TodoLoaded) {
                final todos = state.todos;
                return ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];
                    return ListTile(
                      title: Text(todo.title),
                      leading: Checkbox(
                        value: todo.completed,
                        onChanged: (value) {
                          final updatedTodo = todo.copyWith(completed: value);
                          _todoBloc.add(UpdateTodo(updatedTodo));
                        },
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _todoBloc.add(DeleteTodo(todo.id));
                        },
                      ),
                    );
                  },
                );
              } else if (state is TodoOperationSuccess) {
                _todoBloc.add(LoadTodos()); // Reload todos
                return Container(); // Or display a success message
              } else if (state is TodoError) {
                return Center(child: Text(state.errorMessage));
              } else {
                return Container();
              }
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _showAddTodoDialog(context);
            },
            child: const Icon(Icons.add),
          ),
        );
  }
    void _showAddTodoDialog(BuildContext context) {
      final _titleController = TextEditingController();
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const  Text('Add Todo'),
            content: TextField(
              controller: _titleController,
              decoration: const InputDecoration(hintText: 'Todo title'),
            ),
            actions: [
              ElevatedButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: const Text('Add'),
                onPressed: () {
                  final todo = Todo(
                    id: DateTime.now().toString(),
                    title: _titleController.text,
                    completed: false,
                  );
                  BlocProvider.of<TodoBloc>(context).add(AddTodo(todo));
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
}

/*  StreamBuilder(
        stream: FirebaseFirestore.instance.collection('todos').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Veri beklenirken gösterilecek widget
          }
          if (snapshot.hasError) {
            return Text('Veri alınamıyor: ${snapshot.error}');
          }
          // Firestore'dan alınan verileri listeleyin
          final todos = snapshot.data!.docs;
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index].data();
              return ListTile(
                title: Text(todo['title'] ?? ""),
                subtitle: Text('Tamamlandı: ${todo['completed'] ?? ''}'),
              );
            },
          );
        },
      ), */