import 'package:flutter/material.dart';
import 'tree_note_manager.dart';

class TreeNoteManagerTestPage extends StatefulWidget {
  @override
  _TreeNoteManagerTestPageState createState() => _TreeNoteManagerTestPageState();
}

class _TreeNoteManagerTestPageState extends State<TreeNoteManagerTestPage> {
  final TreeNoteManager _manager = TreeNoteManager();
  final TextEditingController _folderNameController = TextEditingController();
  final TextEditingController _noteTitleController = TextEditingController();
  final TextEditingController _noteContentController = TextEditingController();
  final TextEditingController _subfolderIdController = TextEditingController();
  String _displayContents = '';
  String _currentPath = 'Root';

  @override
  void dispose() {
    _folderNameController.dispose();
    _noteTitleController.dispose();
    _noteContentController.dispose();
    _subfolderIdController.dispose();
    super.dispose();
  }

  void _createFolder() async {
    await _manager.createFolder(_folderNameController.text);
    _folderNameController.clear();
    _updateCurrentPathDisplay();
  }

  void _createNote() async {
    await _manager.createNote(_noteTitleController.text, _noteContentController.text);
    _noteTitleController.clear();
    _noteContentController.clear();
    _updateCurrentPathDisplay();
  }

  void _navigateToSubfolder() async {
    await _manager.navigateToSubfolder(_subfolderIdController.text);
    _subfolderIdController.clear();
    _updateCurrentPathDisplay();
  }

  void _moveToParentFolder() async {
    await _manager.moveToParentFolder();
    _updateCurrentPathDisplay();
  }

  void _fetchCurrentFolderContents() async {
    try {
      var contents = await _manager.getCurrentFolderContent();
      setState(() {
        _displayContents = contents.toString();
      });
    } catch (e) {
      setState(() {
        _displayContents = 'Error: $e';
      });
    }
  }

  void _updateCurrentPathDisplay() {
    setState(() {
      _currentPath = _manager.currentFolderRef?.path ?? 'Root';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TreeNoteManager Test'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _folderNameController,
                decoration: InputDecoration(hintText: 'Folder Name'),
              ),
              ElevatedButton(
                onPressed: _createFolder,
                child: Text('Create Folder'),
              ),
              TextField(
                controller: _noteTitleController,
                decoration: InputDecoration(hintText: 'Note Title'),
              ),
              TextField(
                controller: _noteContentController,
                decoration: InputDecoration(hintText: 'Note Content'),
              ),
              ElevatedButton(
                onPressed: _createNote,
                child: Text('Create Note'),
              ),
              TextField(
                controller: _subfolderIdController,
                decoration: InputDecoration(hintText: 'Subfolder ID to Navigate'),
              ),
              ElevatedButton(
                onPressed: _navigateToSubfolder,
                child: Text('Navigate to Subfolder'),
              ),
              ElevatedButton(
                onPressed: _moveToParentFolder,
                child: Text('Move to Parent Folder'),
              ),
              ElevatedButton(
                onPressed: _fetchCurrentFolderContents,
                child: Text('Fetch Current Folder Contents'),
              ),
              SizedBox(height: 20),
              Text('Current Folder Contents:'),
              SelectableText(_displayContents),
              SizedBox(height: 20),
              Text('Current Path: $_currentPath'),
            ],
          ),
        ),
      ),
    );
  }
}
