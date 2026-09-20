import 'package:busca_cep/models/cep_model.dart';
import 'package:busca_cep/repo/cep_repository.dart';
import 'package:busca_cep/ui/widgets/address_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class HomeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final repository = CepRepository(client: http.Client());
  final cepController = TextEditingController();
  final cepFormatter = MaskTextInputFormatter(
    mask: '#####-###',
    filter: {
      '#': RegExp(r'[0-9]')
    },
    type: MaskAutoCompletionType.lazy
  );
  String? errorMessage;
  CepModel? cepModel;
  bool isLoading = false;

  Future<void> buscarCep() async{
    FocusScope.of(context).unfocus();
    setState(() {
      errorMessage = null;
      cepModel = null;
      isLoading = true;
    });
    final cep = cepController.text.trim();

    if(cep.isEmpty){
      setState(() {
        errorMessage = "Digite um CEP válido!";
        isLoading = false;
      });
    }

    try {
      final addressModel = await repository.consultarCep(cep);
      setState(() {
        errorMessage = null;
        cepModel = addressModel;
        isLoading = false;
      });

    } catch (e) {
      setState(() {
        errorMessage = 'Erro ao buscar endereço';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Consulta de CEP"),
        leading: Icon(Icons.location_city),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 24,
          children: [
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary.withValues(alpha: 0.1),
                    theme.colorScheme.secondary.withValues(alpha: 0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight
                ),
                borderRadius: BorderRadius.circular(16)
              ),
              child: Column(
                spacing: 4,
                children: [
                  Icon(
                    Icons.search_rounded,
                    size: 48,
                    color: theme.colorScheme.primary,
                  ),
                  Text(
                    "Busque pelo CEP",
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.primary,
                    )
                  ),
                  Text(
                    'Digite o CEP e descubra o endereço completo',
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  )
                ],
              )   
            ),
            TextField(
              keyboardType: TextInputType.number,
              maxLength: 9,
              inputFormatters: [
                cepFormatter
              ],
              controller: cepController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.location_on_rounded, color: theme.colorScheme.primary),
                labelText: 'CEP',
                hintText: 'Digite o CEP (ex: 01310-100)',
                counterText: ''
              )
            ),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              child: isLoading ? Container(
                height: 60,
                width: 200,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 12,
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: theme.colorScheme.primary,
                        )
                      ),
                      Text(
                        "Buscando CEP...",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w500
                        )
                      ),
                    ],
                  ),
                )
              ) : 
              ElevatedButton.icon(
                onPressed: buscarCep,
                icon: const Icon(Icons.search_rounded),
                label: Text("Buscar CEP"),
              ),
            ),
            Visibility(
              visible: errorMessage != null,
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: theme.colorScheme.error.withValues(alpha: 0.3)
                  )
                ),
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline_rounded, 
                      color: theme.colorScheme.error,
                      size: 24,
                    ),
                    SizedBox(
                       width: 12,
                    ),
                    Text(
                      errorMessage ?? '', 
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.error, 
                        fontWeight: FontWeight.w500
                      ),
                    )
                  ],
                ),
              ),
            ),           
            Visibility(
              visible: cepModel != null,
              child: AnimatedOpacity(
                duration: Duration(seconds: 3),
                opacity: cepModel != null ? 1.0 : 0.0,
                child: AddressWidget(
                  cepModel: cepModel,
                ),
              )
            )
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    cepController.dispose();
    super.dispose();
  }
}