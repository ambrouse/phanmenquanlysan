import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/navbar/navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Edituser extends StatefulWidget {
  const Edituser({super.key});

  @override
  State<StatefulWidget> createState() {
    return EdituserSetting();
  }
}

Future<List> funcUpdateUser(String name_, String mail_, String phone_) async {
  final dio = new Dio();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String idUser_ = sharedPreferences.getString("idUser_").toString();

  Response response = await dio.put("http://10.0.2.2:9090/user/api/v1/user",
      options: Options(
          headers: {'Authorization': ""}, contentType: Headers.jsonContentType),
      data: {
        "id_": idUser_,
        "name_": name_,
        "email_": mail_,
        "phone_": phone_
      });

  return [response.data["result_"]];
}

Future<String> funcTestDelay() async {
  print("vcl start delay");
  sleep(Duration(seconds: 5));
  print("vcl start delay");
  return "";
}

class EdituserSetting extends State<Edituser> {
  //setsate varilabel
  var nofitication_;
  @override
  Widget build(BuildContext context) {
    //user param
    List userInfo = ModalRoute.of(context)!.settings.arguments as List;
    print(nofitication_);

    //size phone varilabel
    final width_ = MediaQuery.of(context).size.width;
    final height_ = MediaQuery.of(context).size.height;

    //varilabel style widget
    final colorText = const Color.fromARGB(255, 0, 0, 0);
    final colorBackgr = const Color.fromARGB(255, 217, 217, 217);
    final colorBackgr2 = Color.fromARGB(255, 198, 194, 194);
    final double sizeText1 = 20;
    final double sizeText2 = 15;
    final double sizeText3 = 10;

    //controller text input
    final nameUserValue_ = TextEditingController();
    final mailUserValue_ = TextEditingController();
    final phoneUserValue_ = TextEditingController();
    nameUserValue_.text = userInfo[1]['nameUser_'];
    mailUserValue_.text = userInfo[1]['emailUser_'];
    phoneUserValue_.text = userInfo[1]['phoneUser_'];

    @override
    void dispose() {
      nameUserValue_.dispose();
      mailUserValue_.dispose();
      phoneUserValue_.dispose();
      super.dispose();
    }

    return SafeArea(
        child: Scaffold(
      body: Container(
        width: width_,
        height: height_,
        color: colorBackgr,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 100),
              decoration: BoxDecoration(
                color: colorBackgr2,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              child: ListView(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "/user/user_profile");
                      },
                      child: Icon(Icons.arrow_back_outlined),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      "Sửa thông tin",
                      style: TextStyle(fontSize: sizeText1, color: colorText),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 50),
                    child: Column(
                      children: [
                        SizedBox(
                          width: (width_ / 1.4),
                          height: 30,
                          child: TextField(
                            controller: nameUserValue_,
                            style: TextStyle(fontSize: sizeText2),
                            decoration: InputDecoration(
                                hintText: "Vui long khong de trong ten",
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide:
                                        BorderSide(color: colorText, width: 1)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide:
                                        BorderSide(color: colorText, width: 1)),
                                contentPadding: EdgeInsets.only(
                                    top: 0, bottom: 0, left: 20)),
                          ),
                        ),
                        Container(
                          width: (width_ / 1.4),
                          margin: EdgeInsets.only(top: 20),
                          height: 30,
                          child: TextField(
                            controller: mailUserValue_,
                            style: TextStyle(fontSize: sizeText2),
                            decoration: InputDecoration(
                                hintText: "Vui long khong de trong ten",
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide:
                                        BorderSide(color: colorText, width: 1)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide:
                                        BorderSide(color: colorText, width: 1)),
                                contentPadding: EdgeInsets.only(
                                    top: 0, bottom: 0, left: 20)),
                          ),
                        ),
                        Container(
                          width: (width_ / 1.4),
                          margin: EdgeInsets.only(top: 20),
                          height: 30,
                          child: TextField(
                            controller: phoneUserValue_,
                            style: TextStyle(fontSize: sizeText2),
                            decoration: InputDecoration(
                                hintText: "Vui long khong de trong ten",
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide:
                                        BorderSide(color: colorText, width: 1)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide:
                                        BorderSide(color: colorText, width: 1)),
                                contentPadding: EdgeInsets.only(
                                    top: 0, bottom: 0, left: 20)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: InkWell(
                      onTap: () {
                        funcUpdateUser(nameUserValue_.text, mailUserValue_.text,
                                phoneUserValue_.text)
                            .then((data) {
                          print(data);
                          setState(() {
                            nofitication_ = data[0];
                            userInfo[1]["nameUser_"] = nameUserValue_.text;
                            userInfo[1]["emailUser_"] = mailUserValue_.text;
                            userInfo[1]["phoneUser_"] = phoneUserValue_.text;
                          });
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 7, bottom: 7, left: 20, right: 20),
                        decoration: BoxDecoration(
                            color: colorBackgr,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Text("Cập nhật thông tin"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(bottom: 20, left: 0, child: Navbar()),
            nofitication_ == null
                ? Container()
                : Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                        width: width_,
                        height: height_,
                        alignment: Alignment.center,
                        color: const Color.fromARGB(0, 0, 0, 0),
                        child: Container(
                          width: (width_ / 1.5),
                          height: 200,
                          decoration: BoxDecoration(
                            color: colorBackgr,
                            borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.topRight,
                                padding: EdgeInsets.all(10),
                                child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        nofitication_ = null;
                                      });
                                    },
                                    child: Icon(Icons.close)),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 30),
                                child: Text(
                                  nofitication_ == null ? "" : nofitication_,
                                  style: TextStyle(
                                      color: colorText, fontSize: sizeText2),
                                ),
                              )
                            ],
                          ),
                        )),
                  )
          ],
        ),
      ),
    ));
  }
}
