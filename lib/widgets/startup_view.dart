import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sunoff/models/startup_view_model.dart';
import 'package:sunoff/providers/startup_view_provider.dart';

class StartUpView extends StatelessWidget {
  const StartUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StartupViewProvider<StartupViewModel>.withConsumer(
      viewModel: StartupViewModel(),
      onModelReady: (model) => model.handleStartUp(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation(
                          Theme.of(context).primaryColor)))
            ],
          ),
        ),
      ),
    );
  }
}
