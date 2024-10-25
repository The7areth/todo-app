import 'package:flutter/material.dart';
import '../../controllers/projects_controller.dart';
import '../../models/projects.dart';
import 'add_project_page.dart';

class ProjectPage extends StatefulWidget {
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  late ProjectController _projectController;
  List<Project> _projects = [];

  @override
  void initState() {
    super.initState();
    _projectController = ProjectController();
    _loadProjects();
  }

  Future<void> _loadProjects() async {
    List<Project> projects = await _projectController.getAllProjects();
    setState(() {
      _projects = projects;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project Manager'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              // Navigate to the Add Project Page and wait for a result
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddProjectPage()),
              );
              if (result == true) {
                // Reload projects after adding a new one
                _loadProjects();
              }
            },
          ),
        ],
      ),
      body: _projects.isEmpty
          ? Center(child: Text('No projects found'))
          : ListView.builder(
        itemCount: _projects.length,
        itemBuilder: (context, index) {
          final project = _projects[index];
          return ListTile(
            title: Text(project.name),
            subtitle: Text(project.description),
            trailing: Text(project.status),
            onTap: () {
              // Handle project tap
            },
          );
        },
      ),
    );
  }
}
