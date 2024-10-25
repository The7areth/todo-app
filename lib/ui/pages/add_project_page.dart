import 'package:flutter/material.dart';

import '../../controllers/projects_controller.dart';
import '../../models/projects.dart';


class AddProjectPage extends StatefulWidget {
  @override
  _AddProjectPageState createState() => _AddProjectPageState();
}

class _AddProjectPageState extends State<AddProjectPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  String _status = 'Not Started';

  late ProjectController _projectController;

  @override
  void initState() {
    super.initState();
    _projectController = ProjectController();
  }

  Future<void> _saveProject() async {
    if (_formKey.currentState!.validate()) {
      Project newProject = Project(
        id: 0,
        name: _nameController.text,
        description: _descriptionController.text,
        startDate: _startDate!,
        endDate: _endDate!,
        status: _status,
      );
      await _projectController.createProject(newProject);
      Navigator.pop(context, true); // Return success to ProjectPage
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Project'),
        ),
        body: Padding(
        padding: const EdgeInsets.all(16.0),
    child: Form(
    key: _formKey,
    child: ListView(
    children: [
    TextFormField(
    controller: _nameController,
    decoration: InputDecoration(labelText: 'Project Name'),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter a project name';
    }
    return null;
    },
    ),
    TextFormField(
    controller: _descriptionController,
    decoration: InputDecoration(labelText: 'Description'),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter a description';
    }
    return null;
    },
    ),
    ListTile(
    title: Text('Start Date: ${_startDate != null ? _startDate!.toLocal().toString().split(' ')[0] : 'Select Date'}'),
    trailing: Icon(Icons.calendar_today),
    onTap: () async {
    DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
    setState(() {
    _startDate = pickedDate;
    });
    }
    },
    ),
    ListTile(
    title: Text('End Date: ${_endDate != null ? _endDate!.toLocal().toString().split(' ')[0] : 'Select Date'}'),
    trailing: Icon(Icons.calendar_today),
    onTap: () async {
    DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
    setState(() {
    _endDate = pickedDate;
    });
    }
    },
    ),
    DropdownButtonFormField<String>(
    value: _status,
    items: ['Not Started', 'In Progress', 'Completed']
        .map((status) => DropdownMenuItem(
    value: status,
    child: Text(status),
    ))
        .toList(),
    onChanged: (value) {
    setState(() {
    _status = value!;
    });

    },
      decoration: InputDecoration(labelText: 'Status'),
    ),
      SizedBox(height: 20),
      ElevatedButton(
        onPressed: _saveProject,
        child: Text('Save Project'),
      ),
    ],
    ),
    ),
        ),
    );
  }
}

