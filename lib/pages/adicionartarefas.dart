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
  title: const Text(
    'Nova Tarefa',
    textAlign: TextAlign.center, // Opcional, pois o centerTitle já alinha o texto
    style: TextStyle(
      fontWeight: FontWeight.bold,
    ),
  ),
  backgroundColor: const Color.fromARGB(255, 97, 162, 236),
  centerTitle: true, // Centraliza o título do AppBar
),

      // Defina a cor de fundo diretamente no Scaffold
      backgroundColor: const Color.fromARGB(255, 97, 162, 236),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 245, 245, 245), // Cor do contêiner interno
              borderRadius: BorderRadius.circular(10.0), // Bordas arredondadas do contêiner interno
            ),
            padding: const EdgeInsets.all(20.0), // Espaçamento interno do contêiner interno
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                // Texto para Nome da Tarefa
                const Text(
                  'Nome da Tarefa',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                // Campo de texto para inserir o nome da tarefa
                const TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.grey, // Cor de fundo do campo
                    filled: true,
                    hintText: 'Digite o nome da tarefa', // Texto de dica
                    contentPadding: EdgeInsets.all(16.0), // Espaçamento interno
                  ),
                ),
                const SizedBox(height: 10),
                // Texto para Descrição
                const Text(
                  'Descrição',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                // Campo de texto para inserir a descrição da tarefa
                const TextField(
                  maxLines: 10, // Permitir múltiplas linhas
                  decoration: InputDecoration(
                    fillColor: Colors.grey, // Cor de fundo do campo
                    filled: true,
                    hintText: 'Descreva sua tarefa...', // Texto de dica
                    contentPadding: EdgeInsets.all(16.0), // Espaçamento interno
                  ),
                  scrollPhysics: BouncingScrollPhysics(),
                  keyboardType: TextInputType.multiline, // Tipo de teclado para múltiplas linhas
                ),
                const SizedBox(height: 10),
                // Texto para Período de Entrega
                const Text(
                  'Período de Entrega',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                // Dropdown para selecionar o período de entrega
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey, // Cor de fundo cinza para o Dropdown
                    borderRadius: BorderRadius.circular(8), // Bordas arredondadas
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true, // Ocupa toda a largura disponível
                      hint: const Row(
                        children: [
                          SizedBox(width: 20),
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
                        icon: Icon(Icons.calendar_today), // Ícone do dropdown
                    
                        iconSize: 24,
                        iconEnabledColor: Colors.black, // Cor do ícone ativado
                        iconDisabledColor: Colors.grey, // Cor do ícone desativado
                        
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 200, // Altura máxima do dropdown
                        width: 300, // Largura do dropdown
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
                 const SizedBox(height: 20), // Espaçamento entre os botões
              Align(
        alignment: Alignment.center,
  child: SizedBox(
     // Espaçamento entre os botões
    width: 200,
    child: ElevatedButton(
      onPressed: () => {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 0, 167, 97),
        side: const BorderSide(color: Colors.white, width: 2),
      ),
      child: const Text(
        'Salvar Tarefa',
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
)
                 
              ],
            ),
          ),
        ),
      ),
    );
  }
}
