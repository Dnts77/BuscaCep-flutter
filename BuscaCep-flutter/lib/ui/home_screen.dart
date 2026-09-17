import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.location_on_rounded, color: theme.colorScheme.primary),
                labelText: 'CEP',
                hintText: 'Digite o CEP (ex: 01310-100)',
                counterText: ''
              )
            ),
            AnimatedSwitcher(
              duration: Duration.zero,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.search_rounded),
                label: Text("Buscar CEP"),
              ),
            )
          ],
        ),
      ),
    );
  }
}