import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class Adicionartarefas extends StatefulWidget {
  const Adicionartarefas({super.key});

  @override
  State<Adicionartarefas> createState() => _AdicionartarefasState();
}

class _AdicionartarefasState extends State<Adicionartarefas> {
  // Lista de opções para o Dropdown
  final List<String> items = [
    'Manhã',
    'Tarde',
    'Noite',
  ];

  // Valor selecionado no Dropdown
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Tarefa'), // Título da tela
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 97, 162, 236), // Cor de fundo da tela
          padding: const EdgeInsets.all(16.0),
          child: Container(
            color: const Color.fromARGB(255, 245, 245, 245), // Cor do contêiner interno
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                // Texto para Nome da Tarefa
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: const Text(
                    'Nome da Tarefa',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                // Campo de texto para inserir o nome da tarefa
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: const TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.grey, // Cor de fundo do campo
                      filled: true,
                      border: OutlineInputBorder(), // Borda do campo
                      hintText: 'Digite o nome da tarefa', // Texto de dica
                      contentPadding: EdgeInsets.all(16.0), // Espaçamento interno
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Texto para Descrição
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: const Text(
                    'Descrição',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                // Campo de texto para inserir a descrição da tarefa
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: const TextField(
                    maxLines: 10, // Permitir múltiplas linhas
                    decoration: InputDecoration(
                      fillColor: Colors.grey, // Cor de fundo do campo
                      filled: true,
                      border: OutlineInputBorder(), // Borda do campo
                      hintText: 'Descreva sua tarefa...', // Texto de dica
                      contentPadding: EdgeInsets.all(16.0), // Espaçamento interno
                    ),
                    scrollPhysics: BouncingScrollPhysics(),
                    keyboardType: TextInputType.multiline, // Tipo de teclado para múltiplas linhas
                  ),
                ),
                const SizedBox(height: 10),
                // Texto para Período de Entrega
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: const Text(
                    'Período de Entrega',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                // Dropdown para selecionar o período de entrega
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.grey, // Cor de fundo cinza para o Dropdown
                    borderRadius: BorderRadius.circular(8), // Bordas arredondadas
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true, // Ocupa toda a largura disponível
                      hint: const Row(
                        children: [
                          Icon(
                            Icons.list,
                            size: 16,
                            color: Colors.black, // Cor do ícone
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Selecione um Período', // Texto de dica
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis, // Evitar overflow
                            ),
                          ),
                        ],
                      ),
                      // Itens do Dropdown
                      items: items.map((String item) => DropdownMenuItem<String>(
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
                      )).toList(),
                      value: selectedValue, // Valor selecionado
                      onChanged: (String? value) {
                        setState(() {
                          selectedValue = value; // Atualiza o valor selecionado
                        });
                      },
                      iconStyleData: const IconStyleData(
                        icon: Icon(Icons.arrow_forward_ios_outlined), // Ícone do dropdown
                        iconSize: 14,
                        iconEnabledColor: Colors.black, // Cor do ícone ativado
                        iconDisabledColor: Colors.grey, // Cor do ícone desativado
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 200, // Altura máxima do dropdown
                        
                        width:300, // Largura do dropdown
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14), // Bordas arredondadas
                          color: Colors.grey, // Cor de fundo do dropdown
                        ),
                        offset: const Offset(-20, 0), // Deslocamento do dropdown
                        scrollbarTheme: ScrollbarThemeData(
                          radius: const Radius.circular(40), // Raio da scrollbar
                          thickness: WidgetStateProperty.all<double>(6), // Espessura da scrollbar
                          thumbVisibility: WidgetStateProperty.all<bool>(true), // Visibilidade do "thumb" da scrollbar
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40, // Altura dos itens do menu
                        padding: EdgeInsets.only(left: 20, right: 20), // Padding dos itens do menu
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
