import 'package:flutter/material.dart';

import 'model/user.dart';

class ProjectRegistryPage extends StatefulWidget {
  final User user;
  const ProjectRegistryPage({Key? key, required this.user}) : super(key: key);

  @override
  State<ProjectRegistryPage> createState() => _ProjectRegistryPageState();
}

class _ProjectRegistryPageState extends State<ProjectRegistryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Registry'),
      ),
      body: Center(),
    );
  }
}
