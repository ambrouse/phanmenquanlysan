import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/navbar/navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Complaint extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ComplaintSetting();
  }
}

TextStyle funcTextFormat(double fontSize_, Color color_) {
  return TextStyle(fontSize: fontSize_, color: color_);
}

Future<List> funcGetComplain() async {
  try {
    final dio = Dio();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String idUserRequest_ = sharedPreferences.getString("idUser_").toString();
    Response response = await dio.get(
        "http://10.0.2.2:9090/user/api/v1/complain/" + idUserRequest_,
        options: Options(
            headers: {'Authorization': ""},
            contentType: Headers.jsonContentType));

    return [true, response.data['result_']];
  } on DioException catch (e) {
    if (e.response != null) {
      return [false, e.response?.data['result_']];
    } else {
      return [false, e.toString()];
    }
  }
}

Future<String> funcSendComplain(var title_, var content_) async {
  try {
    final dio = Dio();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String idUserRequest_ = sharedPreferences.getString("idUser_").toString();
    Response response = await dio.post(
        "http://10.0.2.2:9090/user/api/v1/complain",
        options: Options(
            headers: {'Authorization': ""},
            contentType: Headers.jsonContentType),
        data: {
          "title_": title_,
          "content_": content_,
          "idUser_": idUserRequest_
        });

    return response.data['result_'];
  } on DioException catch (e) {
    if (e.response != null) {
      return e.response?.data['result_'];
    } else {
      return e.toString();
    }
  }
}

class ComplaintSetting extends State<Complaint> {
  List listComplain_ = [];
  TextEditingController complainValueContent_ = TextEditingController();
  TextEditingController complainValueTitle_ = TextEditingController();
  var checkAndSaveValueTitle_;
  var checkAndSaveValueContent_;

  @override
  void initState() {
    super.initState();
    funcGetComplain().then((data) {
      setState(() {
        listComplain_ = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //size phone
    final width_ = MediaQuery.of(context).size.width;
    final height_ = MediaQuery.of(context).size.height;

    //varilabel style widget
    final colorText = const Color.fromARGB(255, 0, 0, 0);
    final colorBackgr = const Color.fromARGB(255, 217, 217, 217);
    final colorBackgr2 = Color.fromARGB(255, 198, 194, 194);
    final double sizeText1 = 20;
    final double sizeText2 = 15;
    final double sizeText3 = 10;

    @override
    void dispose() {
      complainValueContent_.dispose();
      complainValueTitle_.dispose();
      super.dispose();
    }

    if (checkAndSaveValueTitle_ != null) {
      setState(() {
        complainValueTitle_.text = checkAndSaveValueTitle_;
      });
    }
    if (checkAndSaveValueTitle_ != null) {
      setState(() {
        complainValueContent_.text = checkAndSaveValueContent_;
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
            Container(
              width: double.infinity,
              child: ListView(
                children: [
                  Container(
                    width: double.infinity,
                    height: (height_ / 1.3),
                    decoration: BoxDecoration(
                        color: colorBackgr2,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, "/user/user_profile");
                            },
                            child: Icon(Icons.arrow_back_outlined),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Danh sách phản hồi",
                            style: funcTextFormat(sizeText1, colorText),
                          ),
                        ),
                        Expanded(
                            child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 500,
                                  mainAxisExtent: 200,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20),
                          itemCount: listComplain_.isEmpty
                              ? 1
                              : listComplain_[0] == false
                                  ? 1
                                  : listComplain_[1].length,
                          itemBuilder: (context, index) {
                            if (listComplain_.isEmpty) {
                              print(index);
                              return Container(
                                margin: EdgeInsets.only(top: 30),
                                alignment: Alignment.center,
                                child: Text(
                                  "Load ....",
                                  style: funcTextFormat(sizeText2, colorText),
                                ),
                              );
                            }

                            if (listComplain_[0] == false) {
                              return Container(
                                margin: EdgeInsets.only(top: 30),
                                alignment: Alignment.center,
                                child: Text(
                                  listComplain_[1],
                                  style: funcTextFormat(sizeText2, colorText),
                                ),
                              );
                            }

                            return Container(
                              width: width_,
                              padding: EdgeInsets.only(
                                  top: 20, left: 40, right: 40, bottom: 20),
                              child: Container(
                                padding: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                    color: colorBackgr,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                "Tiêu đề : ",
                                                style: funcTextFormat(
                                                    sizeText2, colorText),
                                              )),
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                listComplain_[1][index]
                                                    ["titleComplaint_"],
                                                style: funcTextFormat(
                                                    sizeText2, colorText),
                                              ))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                "Trạng thái :",
                                                style: funcTextFormat(
                                                    sizeText2, colorText),
                                              )),
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                listComplain_[1][index]
                                                    ["statusComplaint_"],
                                                style: funcTextFormat(
                                                    sizeText2, colorText),
                                              ))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                "Ngày gửi phản hồi :",
                                                style: funcTextFormat(
                                                    sizeText2, colorText),
                                              )),
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                listComplain_[1][index]
                                                    ["dayComplaint_"],
                                                style: funcTextFormat(
                                                    sizeText2, colorText),
                                              ))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ))
                      ],
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Thêm phản hồi :",
                        style: funcTextFormat(sizeText2, colorText),
                      )),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 40, right: 40),
                    margin: EdgeInsets.only(top: 10),
                    child: TextField(
                      controller: complainValueTitle_,
                      // maxLines: 5,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.only(top: 1, bottom: 1, left: 20),
                        hintText: "Tiêu đề : ",
                        hintStyle: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 40, right: 40),
                    margin: EdgeInsets.only(top: 10),
                    child: TextField(
                      controller: complainValueContent_,
                      // maxLines: 5,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.only(top: 1, bottom: 1, left: 20),
                        hintText: "Nội dung : ",
                        hintStyle: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 100, top: 10),
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.only(right: 40),
                    child: InkWell(
                      onTap: () {
                        funcSendComplain(complainValueTitle_.text,
                                complainValueContent_.text)
                            .then((value) {
                          funcGetComplain().then((data) {
                            setState(() {
                              print(value);
                              listComplain_ = data;
                            });
                          });
                        });
                      },
                      child: Container(
                        width: 200,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: colorBackgr2,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Text(
                          "<<Ấn để gửi>>",
                          style:
                              TextStyle(fontSize: sizeText2, color: colorText),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(bottom: 20, left: 0, child: Navbar()),
          ],
        ),
      ),
    ));
  }
}
