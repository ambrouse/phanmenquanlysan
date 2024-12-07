import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/navbar/navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Userprofile extends StatefulWidget {
  const Userprofile({super.key});

  @override
  State<StatefulWidget> createState() {
    return UserProfileSetting();
  }
}

Future<List> getUsereInfo() async {
  try {
    final dio = Dio();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String idUserRequest_ = sharedPreferences.getString("idUser_").toString();
    Response response = await dio.post(
        "http://10.0.2.2:9090/user/api/v1/user/$idUserRequest_",
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

class UserProfileSetting extends State<Userprofile> {
  //api varilabel
  List userInfo = [];

  @override
  void initState() {
    super.initState();
    getUsereInfo().then((data) {
      setState(() {
        userInfo = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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

    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // String idUserRequest_ = sharedPreferences.getString("idUser_").toString();

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
                      bottomRight: Radius.circular(20))),
              child: ListView(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "/user/home");
                      },
                      child: Icon(Icons.arrow_back_outlined),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Quản lý người dùng",
                      style: TextStyle(fontSize: sizeText1, color: colorText),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    child: Column(
                      children: [
                        SizedBox(
                          width: (width_ / 1.3),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Text(
                                  "Tên : ",
                                  style: TextStyle(
                                      fontSize: sizeText2, color: colorText),
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: Text(
                                  userInfo.isNotEmpty
                                      ? userInfo[1]["nameUser_"]
                                      : "",
                                  style: TextStyle(
                                      fontSize: sizeText2, color: colorText),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: (width_ / 1.3),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Text(
                                  "Gmail : ",
                                  style: TextStyle(
                                      fontSize: sizeText2, color: colorText),
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: Text(
                                  userInfo.isNotEmpty
                                      ? userInfo[1]["emailUser_"]
                                      : "",
                                  style: TextStyle(
                                      fontSize: sizeText2, color: colorText),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: (width_ / 1.3),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Text(
                                  "Số điện thoại : ",
                                  style: TextStyle(
                                      fontSize: sizeText2, color: colorText),
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: Text(
                                  userInfo.isNotEmpty
                                      ? userInfo[1]["phoneUser_"]
                                      : "",
                                  style: TextStyle(
                                      fontSize: sizeText2, color: colorText),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 50),
                    child: Column(
                      children: [
                        SizedBox(
                          width: (width_ / 1.5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.only(top: 7, bottom: 7),
                                    alignment: Alignment.center,
                                    width: (width_ / 4),
                                    decoration: BoxDecoration(
                                        color: colorBackgr,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Text("Đăng xuất"),
                                  ),
                                ),
                              ),
                              Container(
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    width: (width_ / 4),
                                    padding: EdgeInsets.only(top: 7, bottom: 7),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: colorBackgr,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Text("Xóa tài khoản"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: (width_ / 1.5),
                          margin: EdgeInsets.only(top: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "/user/user_edit",
                                        arguments: userInfo);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(top: 7, bottom: 7),
                                    alignment: Alignment.center,
                                    width: (width_ / 4),
                                    decoration: BoxDecoration(
                                        color: colorBackgr,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Text("Sửa thông tin"),
                                  ),
                                ),
                              ),
                              Container(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "/user/user_complaint");
                                  },
                                  child: Container(
                                    width: (width_ / 4),
                                    padding: EdgeInsets.only(top: 7, bottom: 7),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: colorBackgr,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Text("Phản hồi"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: (width_ / 1.5),
                          margin: EdgeInsets.only(top: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.only(top: 7, bottom: 7),
                                    alignment: Alignment.center,
                                    width: (width_ / 4),
                                    decoration: BoxDecoration(
                                        color: colorBackgr,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Text("Thông báo"),
                                  ),
                                ),
                              ),
                              Container(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "/user/user_rent_yard");
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(top: 7, bottom: 7),
                                    alignment: Alignment.center,
                                    width: (width_ / 4),
                                    decoration: BoxDecoration(
                                        color: colorBackgr,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Text("Giỏ hàng"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 100),
                          child: Text(""),
                        )
                      ],
                    ),
                  )
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
