import 'package:flutter/material.dart';
import 'adicionartarefas.dart';
import 'vertarefas.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Variáveis de estado podem ser declaradas aqui
  int counter = 0;

  // Método que pode atualizar o estado
  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Aplica a cor de fundo a todo o body
        color: const Color.fromARGB(255, 97, 162, 236),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // Alinha ao topo
            crossAxisAlignment:
                CrossAxisAlignment.center, // Centraliza horizontalmente
            children: [
                 const SizedBox(height: 100), // Espaçamento superior (opcional)
              Container(
                width: 200, // Largura do container
                height: 200, // Altura do container
                decoration: BoxDecoration(
                  color:
                      const Color.fromARGB(153, 254, 255, 255), // Cor do fundo
                  borderRadius: BorderRadius.circular(
                      100), // Valor para arredondar as bordas
                ),
                child: const Icon(
                  Icons.task,
                  color: Colors.white,
                  size: 150,
                ),
              ),
            const SizedBox(height: 100), 
              SizedBox(
                width: 220,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const Vertarefas()),
                    );
                     
                  },
                  
                  label: const Text(
                    'Ver Tarefas',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  icon: const Icon(
                    Icons.remove_red_eye,
                    color: Colors.white,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(131, 123, 205, 252),
                    side: const BorderSide(color: Colors.white, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 20), // Espaçamento entre os botões
              SizedBox(
                width: 220,
                    height: 50,
                child: ElevatedButton.icon(
                  
                  onPressed: ( ) =>{
                    Navigator.push(
                       context, 
                       MaterialPageRoute(builder: (context) => const Adicionartarefas()),
                       )
                  },
                  label: const Text(
                    'Adicionar Tarefa',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(131, 123, 205, 252),
                    side: const BorderSide(color: Colors.white, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 20), // Espaçamento entre os botões
            
              
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}
