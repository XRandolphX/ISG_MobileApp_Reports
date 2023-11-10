import 'package:flutter/material.dart';
import 'package:insergemobileapplication/view/Pages/Visualizator/MinimalPages/GalleryPage.dart';

import 'MinimalPages/RendersPage.dart';

class VisualizatorPage extends StatefulWidget {
  const VisualizatorPage({super.key});

  @override
  State<VisualizatorPage> createState() => _VisualizatorPageState();
}

class _VisualizatorPageState extends State<VisualizatorPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          automaticallyImplyLeading: false,
          centerTitle: true,
          foregroundColor: Colors.blueAccent,
          title: const Text(
            'Visualizador',
            style: TextStyle(color: Colors.blueAccent),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.blueAccent,
            indicatorWeight: 5,
            labelColor: Colors.blueAccent,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(text: 'Galeria'),
              Tab(text: 'Render'),
            ],
          ),
        ),
        body: const TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              GalleryPage(),
              RendersPage(),
            ]),
      ),
    );
  }
}
