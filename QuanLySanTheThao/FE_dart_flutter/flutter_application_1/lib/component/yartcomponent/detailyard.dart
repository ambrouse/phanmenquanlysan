import 'dart:io';

import 'package:date_field/date_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/navbar/navbar.dart';
import 'package:intl/intl_standalone.dart'
    if (dart.library.html) 'package:intl/intl_browser.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailYard extends StatefulWidget {
  const DetailYard({super.key});

  @override
  State<StatefulWidget> createState() {
    return DetailYardSetting();
  }
}

Future<dynamic> funcGetYardDetail(String idYard_) async {
  final dio = Dio();
  Response response_ = await dio.get(
      "http://10.0.2.2:9090/user/api/v1/yard_detail/$idYard_",
      options: Options(
          headers: {'Authorization': ""},
          contentType: Headers.jsonContentType));

  return response_.data['result_'];
}

Future<List> funcRentYard(
    String startTime_, String endTime_, String idYard_) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String idUserRequest_ = sharedPreferences.getString("idUser_").toString();
  String startDayRequest_ =
      "${startTime_.split(" ")[0]}T${startTime_.split(" ")[1]}";
  String endDayRequest_ = "${endTime_.split(" ")[0]}T${endTime_.split(" ")[1]}";

  final dio = Dio();
  try {
    Response response = await dio.post(
        "http://10.0.2.2:9090/user/api/v1/rentyard",
        data: {
          "idUser_": idUserRequest_,
          "idYard_": idYard_,
          "startDay_": startDayRequest_,
          "endDay_": endDayRequest_
        },
        options: Options(
            headers: {'Authorization': ""},
            contentType: Headers.jsonContentType));
    // print(startDayRequest_);
    // print(endDayRequest_);
    // print(idUserRequest_);
    // print(idYard_);
    return [true, response.data['result_']];
  } on DioException catch (e) {
    if (e.response != null) {
      return [false, e.response?.data['result_']];
    } else {
      return [false, e.toString()];
    }
  }
}

class DetailYardSetting extends State<DetailYard> {
  //api request param
  String startDay_ = "";
  String endDay_ = "";

  //current varilable
  String errText_ = "";

  //varilabel style widget
  final colorText = const Color.fromARGB(255, 0, 0, 0);
  final colorBackgr = const Color.fromARGB(255, 217, 217, 217);
  final colorBackgr2 = Color.fromARGB(255, 198, 194, 194);

  //api varilabel
  List<dynamic> YardDetail_ = [];
  List<dynamic> YardRentDetail_ = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // size phone varilabel and param router
    final width_ = MediaQuery.of(context).size.width;
    final height_ = MediaQuery.of(context).size.height;
    final currentCount = (MediaQuery.of(context).size.width ~/ 250).toInt();

    //ulr param
    String idYard_ = ModalRoute.of(context)!.settings.arguments as String;

    if (YardDetail_.isEmpty) {
      funcGetYardDetail(idYard_).then((data) {
        setState(() {
          YardDetail_ = data['yardEntity_'];
          YardRentDetail_ = data['yardRentEntitie_'];
        });
      });
    }

    return SafeArea(
        child: Scaffold(
      body: Container(
        width: width_,
        height: height_,
        color: colorBackgr,
        child: Stack(
          children: [
            ListView(
              children: [
                Container(
                  width: double.infinity,
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/user/list_yard");
                    },
                    child: Icon(Icons.arrow_back_outlined),
                  ),
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    "Chi tiết sân",
                    style: TextStyle(fontSize: 20, color: colorText),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 40, bottom: 40),
                  decoration: BoxDecoration(
                      color: colorBackgr2,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: (width_ / 1.3),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text("Ten san :"),
                            ),
                            YardDetail_.isNotEmpty
                                ? Expanded(
                                    flex: 6,
                                    child: Text(YardDetail_[0]['name_']))
                                : Container()
                          ],
                        ),
                      ),
                      SizedBox(
                        width: (width_ / 1.3),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text("Gia tien :"),
                            ),
                            Expanded(flex: 6, child: Text("data"))
                          ],
                        ),
                      ),
                      SizedBox(
                        width: (width_ / 1.3),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text("Dia chi :"),
                            ),
                            YardDetail_.isNotEmpty
                                ? Expanded(
                                    flex: 6,
                                    child: Text(YardDetail_[0]['address_']))
                                : Container()
                          ],
                        ),
                      ),
                      SizedBox(
                        width: (width_ / 1.3),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text("Trang thai :"),
                            ),
                            YardDetail_.isNotEmpty
                                ? Expanded(
                                    flex: 6,
                                    child: Text(YardDetail_[0]['status_']))
                                : Container()
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 30),
                    width: double.infinity,
                    height: 250,
                    // padding: EdgeInsets.only(left: (width_/5),right: (width_/5)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: (width_ / 1.5),
                          margin: EdgeInsets.only(left: 20),
                          child: DateTimeFormField(
                            decoration: InputDecoration(
                                labelText: "Tu ngay :",
                                labelStyle:
                                    TextStyle(fontSize: 15, color: colorText)),
                            firstDate:
                                DateTime.now().add(const Duration(days: 10)),
                            lastDate:
                                DateTime.now().add(const Duration(days: 40)),
                            initialPickerDateTime:
                                DateTime.now().add(const Duration(days: 20)),
                            onChanged: (DateTime? data) {
                              startDay_ = data.toString();
                            },
                          ),
                        ),
                        Container(
                          width: (width_ / 1.5),
                          margin: EdgeInsets.only(left: 20),
                          child: DateTimeFormField(
                            decoration: InputDecoration(
                                labelText: "Den ngay :",
                                labelStyle:
                                    TextStyle(fontSize: 15, color: colorText)),
                            firstDate:
                                DateTime.now().add(const Duration(days: 10)),
                            lastDate:
                                DateTime.now().add(const Duration(days: 40)),
                            initialPickerDateTime:
                                DateTime.now().add(const Duration(days: 20)),
                            onChanged: (DateTime? data) {
                              endDay_ = data.toString();
                            },
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            errText_,
                            style: TextStyle(color: colorText, fontSize: 15),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 20, left: 20),
                            child: InkWell(
                              onTap: () {
                                if (startDay_.isNotEmpty &&
                                    endDay_.isNotEmpty) {
                                  funcRentYard(startDay_, endDay_, idYard_)
                                      .then((data) {
                                    setState(() {
                                      if (!data[0]) {
                                        errText_ = data[1];
                                      } else {
                                        errText_ = data[1];
                                        Navigator.pushNamed(
                                            context, "/user/payment",arguments: idYard_);
                                      }
                                    });
                                    // sleep(Duration(seconds: 3));
                                    // print("to page");
                                  });
                                }
                                // Navigator.pushNamed(context, "/user/list_yard");
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: 5, bottom: 5, left: 20, right: 20),
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 32, 32, 32),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 87, 42, 42),
                                        width: 1)),
                                child: Text(
                                  "Dat san.",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ),
                            ))
                      ],
                    )),
                Container(
                    margin: EdgeInsets.only(top: 40),
                    width: double.infinity,
                    height: (height_ / 2),
                    decoration: BoxDecoration(color: colorBackgr2),
                    padding: EdgeInsets.only(top: 20),
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 500,
                            mainAxisExtent: 150,
                            // childAspectRatio: 3/4,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                        itemCount: YardRentDetail_.isNotEmpty
                            ? YardRentDetail_.length
                            : 1,
                        itemBuilder: (context, index) {
                          if (YardRentDetail_.isEmpty) {
                            return Container(
                              alignment: Alignment.center,
                              child:
                                  Text("Chưa có khách hàng nào đặt sân này."),
                            );
                          }
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: 300,
                                height: 150,
                                decoration: BoxDecoration(
                                    color: colorBackgr,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 4,
                                            child: Container(
                                              padding:
                                                  EdgeInsets.only(left: 20),
                                              child: Text("Thoi gian dat :"),
                                            )),
                                        Expanded(
                                            flex: 6,
                                            child: Text((YardRentDetail_[0]
                                                    ['rentTime_'])
                                                .toString()))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 4,
                                            child: Container(
                                              padding:
                                                  EdgeInsets.only(left: 20),
                                              child: Text("Tu :"),
                                            )),
                                        Expanded(
                                            flex: 6,
                                            child: Text((YardRentDetail_[0]
                                                    ['timeStartRent_'])
                                                .toString()))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 4,
                                            child: Container(
                                              padding:
                                                  EdgeInsets.only(left: 20),
                                              child: Text("Den :"),
                                            )),
                                        Expanded(
                                            flex: 6,
                                            child: Text((YardRentDetail_[0]
                                                    ['timeEndRent_'])
                                                .toString()))
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          );
                        })),
              ],
            ),
            Positioned(bottom: 20, left: 0, child: Navbar()),
          ],
        ),
      ),
    ));
  }
}
