import 'package:fish_redux/fish_redux.dart';
import 'state.dart';
import 'package:flutter/material.dart';
import 'action.dart';

Widget buildView(DemoState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Demo Page'),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'You have pushed the button this many times:',
          ),
          Text(
            '${state.pressCount}',
            style: Theme.of(viewService.context).textTheme.display1,
          ),
          RaisedButton(onPressed: () => dispatch(DemoActionCreator.onReduceAction(state.pressCount)), child: Text('点击减少次数'),),
          RaisedButton(onPressed: () => dispatch(DemoActionCreator.onStepAction()), child: Text('点击跳转至商城'),)
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () =>
          dispatch(DemoActionCreator.onPressAction(state.pressCount)),
      tooltip: 'Increment',
      child: Icon(Icons.add),
    ), // This trailing comma makes auto-formatting nicer for build methods.
  );
}
