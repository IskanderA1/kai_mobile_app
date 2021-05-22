import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kai_mobile_app/bloc/week/week_bloc.dart';
import 'package:kai_mobile_app/bloc/week_bloc.dart';
import 'package:kai_mobile_app/elements/loader_horisont.dart';

import '../model/week_item.dart';

class WeekWidget extends StatefulWidget {
  @override
  _WeekWidgetState createState() => _WeekWidgetState();
}

class _WeekWidgetState extends State<WeekWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Card(
        child: Container(
          width: MediaQuery.of(context).size.width - 86,
          height: 64,
          decoration:
              BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Center(
            child: Container(
              child: BlocBuilder<WeekBloc, WeekState>(
                builder: (BuildContext context, state) {
                  if (state is WeekStateLoaded) {
                    return Text(
                      state.week == WeekItem.EVEN
                          ? "Четная неделя"
                          : "Нечетная неделя",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    );
                  } else if (state is WeekStateLoading) {
                    return LoadingHorisontalWidget();
                  } else if (state is WeekStateError) {
                    return Text(
                      state.error.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
