

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kai_mobile_app/bloc/get_weather_bloc.dart';
import 'package:kai_mobile_app/elements/loader_horisont.dart';
import 'package:kai_mobile_app/model/weather_response.dart';
import 'package:kai_mobile_app/style/theme.dart' as Style;

Widget buildWeatherWidget(BuildContext context){
  getWeatherBloc..getWeather();
  return Padding(
    padding: const EdgeInsets.only(top: 16.0),
    child: Container(
      width: MediaQuery.of(context).size.width - 86,
      height: 64,
      decoration: BoxDecoration(
        border: Border.all(color: Style.Colors.titleColor, width: 1, style: BorderStyle.solid),
        borderRadius: BorderRadius.all(Radius.circular(5))
      ),
      child: StreamBuilder(
        stream: getWeatherBloc.subject,
          builder: (context, AsyncSnapshot<WeatherResponse> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.error != null && snapshot.data.error.length > 0) {
                return Center(
                  child: Text(snapshot.data.error),
                );
              }
              return Row(
                children: [
                  Expanded(
                      flex: 3,
                      child: Container(
                        child: Text(
                          "Казань",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            color: Style.Colors.titleColor,
                          ),
                        ),
                      )
                  ),

                  Expanded(
                    flex: 1,
                      child: Container(
                        child: Text(
                            "${snapshot.data.weatherModel.temputure}°",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            color: Style.Colors.titleColor,
                          ),
                        ),
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Container(
                          child: Text(
                            snapshot.data.weatherModel.icon,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 40,
                              color: Style.Colors.titleColor,
                            ),
                          ),
                        ),
                      )
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Container();
            } else {
              return buildLoadingHorizontWidget();
            }
          }
      ),
    ),
  );


}