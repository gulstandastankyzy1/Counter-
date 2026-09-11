import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(
    ScopedModel<CounterModel>(
      model: CounterModel(),
      child: MaterialApp(home: MyApp()),
    ),
  );
}

class CounterModel extends Model {
  int count = 0;

  void plus() {
    count++;
    notifyListeners();
  }

  void minus() {
    count--;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scopped Model')),
      body: ScopedModelDescendant<CounterModel>(
        builder: (context, child, model) {
          return Column(
            children: [
              SizedBox(height: 20),

              Text('(Root Widget)', style: TextStyle(fontSize: 30)),

              SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [CounterWidget(), CounterWidget()],
              ),
            ],
          );
        },
      ),
    );
  }
}

class CounterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CounterModel>(
      builder: (context, child, model) {
        return Container(
          width: 120,
          height: 130,
          color: Colors.yellow,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('(Child Widget)'),

              Text('${model.count}', style: TextStyle(fontSize: 35)),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(onPressed: model.minus, icon: Icon(Icons.remove)),

                  IconButton(onPressed: model.plus, icon: Icon(Icons.add)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
