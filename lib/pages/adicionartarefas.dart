import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../dados/databaseHelper .dart';
import 'vertarefas.dart';

class Adicionartarefas extends StatefulWidget {
  const Adicionartarefas({super.key});

  @override
  State<Adicionartarefas> createState() => _AdicionartarefasState();
}

class _AdicionartarefasState extends State<Adicionartarefas> {
  final List<String> items = ['Manhã', 'Tarde', 'Noite']; // Opções para o dropdown
  String? selectedValue; // Valor selecionado no dropdown

  // Controladores para os campos de texto
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nova Tarefa',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 97, 162, 236),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 97, 162, 236),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 245, 245, 245),
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                // Campo para inserir o nome da tarefa
                const Text('Nome da Tarefa',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                TextField(
                  controller: nomeController,
                  decoration: const InputDecoration(
                    fillColor: Colors.grey,
                    filled: true,
                    hintText: 'Digite o nome da tarefa',
                    contentPadding: EdgeInsets.all(16.0),
                  ),
                ),
                const SizedBox(height: 10),
                // Campo para inserir a descrição da tarefa
                const Text('Descrição',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                TextField(
                  controller: descricaoController,
                  maxLines: 10,
                  decoration: const InputDecoration(
                    fillColor: Colors.grey,
                    filled: true,
                    hintText: 'Descreva sua tarefa...',
                    contentPadding: EdgeInsets.all(16.0),
                  ),
                  scrollPhysics: const BouncingScrollPhysics(),
                  keyboardType: TextInputType.multiline,
                ),
                const SizedBox(height: 10),
                // Dropdown para selecionar o período da tarefa
                const Text('Período de Entrega',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: const Row(
                        children: [
                          SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              'Selecione um Período',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      // Adiciona as opções de período ao dropdown
                      items: items
                          .map((String item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      value: selectedValue,
                      // Atualiza o valor selecionado
                      onChanged: (String? value) {
                        setState(() {
                          selectedValue = value;
                        });
                      },
                      iconStyleData: const IconStyleData(
                        icon: Icon(Icons.calendar_today),
                        iconSize: 24,
                        iconEnabledColor: Colors.black,
                        iconDisabledColor: Colors.grey,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.grey,
                        ),
                        offset: const Offset(-20, 0),
                        scrollbarTheme: ScrollbarThemeData(
                          radius: const Radius.circular(40),
                          thickness: WidgetStateProperty.all<double>(6),
                          thumbVisibility: WidgetStateProperty.all<bool>(true),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                        padding: EdgeInsets.only(left: 20, right: 20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Botão para salvar a tarefa no banco de dados
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () async {
                        // Verifica se todos os campos foram preenchidos
                        if (nomeController.text.isNotEmpty &&
                            descricaoController.text.isNotEmpty &&
                            selectedValue != null) {
                          // Insere a tarefa no banco de dados
                          await DatabaseHelper().insertTask({
                            'nome': nomeController.text,
                            'descricao': descricaoController.text,
                            'periodo': selectedValue,
                          });
                          // Navega para a tela de ver tarefas
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Vertarefas()),
                          );
                        } else {
                          // Exibe uma mensagem de erro se algum campo estiver vazio
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Preencha todos os campos!'),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 0, 167, 97),
                        side: const BorderSide(color: Colors.white, width: 2.0),
                      ),
                      child: const Text(
                        'Salvar Tarefa',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}