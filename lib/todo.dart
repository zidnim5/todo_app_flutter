import "package:flutter/material.dart";

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  List<String> _todoItems = [];

  void _addTodoItem(String task) {
    setState(() {
      _todoItems.add(task);
    });
  }

  void _removeTodoItem(int index){
    setState(() => {
      _todoItems.removeAt(index)
    });
  }

  Widget _buildTodoList() {
    return new ListView.builder(itemBuilder: (context, index){
      if(index < _todoItems.length){
        return _buildTodoItem(_todoItems[index], index);
      }
    });
  }

  Widget _buildTodoItem(String todoText, int index){
    return new ListTile(
      title: new Text(todoText),
      onTap: () => _promptDeleteTodoItem(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
      
        title: Text(widget.title),
      ),
      body: _buildTodoList(),
      floatingActionButton: new FloatingActionButton(
        onPressed: _pushAddTodoItemScreen, 
        tooltip: 'Add Task', 
        child: new Icon(Icons.add),), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _pushAddTodoItemScreen(){
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context){
          return new Scaffold(
            appBar: new AppBar(title: new Text('Add New Task'),),
            body: new TextField(
              autofocus: true,
              onSubmitted: (val){
                _addTodoItem(val);
                Navigator.pop(context);
              },
              decoration: new InputDecoration(
                hintText: 'Enter something to do...',
                contentPadding: const EdgeInsets.all(16.0)              ),
            ),
          );
        }
      )
    );
  }

  void _promptDeleteTodoItem(int index){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return new AlertDialog(
        title: new Text('Mark "${_todoItems[index]}" as done?'),
        actions: <Widget>[
          new FlatButton(
            child: new Text('CANCEL'),
            onPressed: () => Navigator.of(context).pop()
          ),
          new FlatButton(
            child: new Text('MARK AS DONE'),
            onPressed: () {
              _removeTodoItem(index);
              Navigator.of(context).pop();
            }
          )
        ]
      );
      }
    );
  }
}
