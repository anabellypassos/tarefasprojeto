import 'package:flutter/material.dart';
import '../dados/databaseHelper .dart';

class Vertarefas extends StatefulWidget {
  const Vertarefas({super.key});

  @override
  State<Vertarefas> createState() => _VertarefasState();
}

class _VertarefasState extends State<Vertarefas> {
  late Future<List<Map<String, dynamic>>> _taskListFuture;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  // Carrega as tarefas do banco de dados
  void _loadTasks() {
    _taskListFuture = DatabaseHelper().getTasks();
  }

  // Deleta uma tarefa com base no ID
  Future<void> _deleteTask(int id) async {
    await DatabaseHelper().deleteTask(id);
    // Recarrega as tarefas após exclusão
    setState(() {
      _loadTasks();
    });
  }

  // Atualiza o estado de conclusão da tarefa
  Future<void> _updateTaskStatus(int id, bool concluida) async {
    await DatabaseHelper().updateTaskStatus(id, concluida);
    // Recarrega as tarefas após atualização
    setState(() {
      _loadTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas'),
        backgroundColor: const Color.fromARGB(255, 97, 162, 236),
      ),
      backgroundColor: const Color.fromARGB(255, 97, 162, 236),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _taskListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar as tarefas'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma tarefa cadastrada'));
          }

          final tasks = snapshot.data!;
          final manhaTasks = tasks.where((task) => task['periodo'] == 'Manhã').toList();
          final tardeTasks = tasks.where((task) => task['periodo'] == 'Tarde').toList();
          final noiteTasks = tasks.where((task) => task['periodo'] == 'Noite').toList();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildTaskSection('Manhã', manhaTasks),
              _buildTaskSection('Tarde', tardeTasks),
              _buildTaskSection('Noite', noiteTasks),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTaskSection(String period, List<Map<String, dynamic>> tasks) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16), // Espaçamento entre seções
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            period,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            child: Column(
              children: tasks.isEmpty
                  ? [
                      const Text(
                        'Nenhuma tarefa para esse período',
                        style: TextStyle(color: Colors.white70),
                      )
                    ]
                  : tasks.map((task) {
                      return Card(
                        child: ListTile(
                          title: Text(task['nome']),
                          subtitle: Text(task['descricao']),
                          leading: Checkbox(
                            value: task['concluida'] == 1,
                            onChanged: (bool? value) {
                              if (value != null) {
                                _updateTaskStatus(task['id'], value);
                              }
                            },
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _confirmDeleteTask(task['id']),
                          ),
                        ),
                      );
                    }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // Função para confirmar exclusão da tarefa
  void _confirmDeleteTask(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir Tarefa'),
        content: const Text('Tem certeza que deseja excluir esta tarefa?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _deleteTask(id);
            },
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }
}
