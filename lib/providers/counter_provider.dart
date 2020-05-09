import 'package:flutter/material.dart';

// EXEMPLO DE InheritedWidget
// ATIVIDADE

// Classe para controlar o estado de contagem
class CounterState {
  int _value = 1;

  void inc() => _value++;
  void dec() => _value--;
  int get value => _value;

  bool diff(CounterState old) {
    return old == null || old._value != _value;
  }
}

// InheritedWidget usado para faciliar o acesso do CounterState a partir do context.
class CounterProvider extends InheritedWidget {
  final CounterState state = CounterState();

  // O InheritedWidget precisa de um filho para que ele possa envolver e ser adicionado na arvore de componentes
  CounterProvider({Widget child}) : super(child: child);
  
  // O método of é comum em widgets para acessar componentes distante dentro da arvore de componentes
  static CounterProvider of (BuildContext context){
    // O dependOnInheritedWidgetOfExactType vai procurar em nossa arvore de widget o widget do tipo CounterProvider e retornar uma instancia
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
