
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

final dio = Dio();

Future<String> funcSigup(String phone_, String name_, String password_, String email_) async{
  try {
    Response response_;
    response_ = await dio.post("http://10.0.2.2:9090/user/api/v1/sigup",
        data: {
          "phone_": phone_,
          "password_": password_,
          "email_": email_,
          "name_": name_
        },
        options: Options(
            headers: {
              'Authorization': ""
            },
            contentType: Headers.jsonContentType
        ));
    return response_.data['result_']['desriptions_'];
  }on DioException catch (e) {
    if (e.response != null) {
      return e.response?.data['result_'];
    }else {
      return e.message.toString();
    }
  }
}


class sigup extends StatefulWidget {
  String nofitication_ = "không được bỏ trống thông tin nhé";
  var emailHistory_;
  var passwordHistory_;
  var phoneHistory_;
  var nameHistory_;

  sigup({super.key});

  @override
  State<StatefulWidget> createState() {
    return sigupSetting();
  }
}

void hhhh(String s){
  print(s);
}


class sigupSetting extends State<sigup> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailValue_ =  TextEditingController();
    TextEditingController phoneValue_ =  TextEditingController();
    TextEditingController passwordValue_ =  TextEditingController();
    TextEditingController nameValue_ =  TextEditingController();

    widget.emailHistory_!=null? emailValue_.text = widget.emailHistory_:"";
    widget.passwordHistory_!=null? passwordValue_.text = widget.passwordHistory_:"";
    widget.phoneHistory_!=null? phoneValue_.text = widget.phoneHistory_:"";
    widget.nameHistory_!=null? nameValue_.text = widget.nameHistory_:"";
  @override
  void dispose() {
    emailValue_.dispose();
    passwordValue_.dispose();
    phoneValue_.dispose();
    nameValue_.dispose();
    super.dispose();
  }

  final height_ = MediaQuery.of(context).size.height;
  final width_ = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
          child: Container(
            width: width_,
            height: height_,
            color: Color.fromARGB(255, 217, 217, 217),
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(top: 50),
                        child:const Text(
                          "Trang đăng kí",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 1, 1, 1),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 50),
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            SizedBox(
                              width: (width_/1.2),
                              child: TextField(
                                controller: emailValue_,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.only(top: 1,bottom: 1,left: 20),
                                    hintText: "Email",
                                    hintStyle: TextStyle(
                                        fontSize: 15
                                    )
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              width: (width_/1.2),
                              child:  TextField(
                                controller: phoneValue_,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.only(top: 1,bottom: 1,left: 20),
                                    hintText: "Số điện thoại",
                                    hintStyle: TextStyle(
                                        fontSize: 15
                                    )
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              width: (width_/1.2),
                              child:  TextField(
                                controller: passwordValue_,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.only(top: 1,bottom: 1,left: 20),
                                    hintText: "Mật khẩu",
                                    hintStyle: TextStyle(
                                        fontSize: 15
                                    )
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              width: (width_/1.2),
                              child:  TextField(
                                controller: nameValue_,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.only(top: 1,bottom: 1,left: 20),
                                    hintText: "Tên người dùng",
                                    hintStyle: TextStyle(
                                        fontSize: 15
                                    )
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 30),
                              child: Text(widget.nofitication_),
                            ),
                            Container(
                                margin: const EdgeInsets.only(top: 50),
                                width: (width_/1.2),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                        onPressed: (){
                                          Navigator.pushNamed(context, "/user/login");
                                        },
                                        style: ButtonStyle(
                                            padding: WidgetStateProperty.all<EdgeInsets>(
                                                const EdgeInsets.only(
                                                    left: 40,right: 40,top: 0,bottom: 0
                                                )
                                            ),
                                            shape: WidgetStateProperty.all(
                                                const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                                )
                                            )
                                        ),
                                        child: const Text(
                                          "Login",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black
                                          ),
                                        )
                                    ),
                                    ElevatedButton(
                                        onPressed: (){
                                          if(emailValue_.text.isNotEmpty){
                                            widget.emailHistory_ = emailValue_.text;
                                          }
                                          if(passwordValue_.text.isNotEmpty){
                                            widget.passwordHistory_ = passwordValue_.text;
                                          }
                                          if(nameValue_.text.isNotEmpty){
                                            widget.nameHistory_ = nameValue_.text;
                                          }
                                          if(phoneValue_.text.isNotEmpty){
                                            widget.phoneHistory_ = phoneValue_.text;
                                          }
                                          funcSigup(phoneValue_.text,
                                              nameValue_.text,
                                              passwordValue_.text,
                                              emailValue_.text).then((data){
                                                setState(() {
                                                  widget.nofitication_ = data;
                                                });
                                              });
                                          },
                                        style: ButtonStyle(
                                            padding: WidgetStateProperty.all<EdgeInsets>(
                                                const EdgeInsets.only(
                                                    left: 40,right: 40,top: 0,bottom: 0
                                                )
                                            ),
                                            shape: WidgetStateProperty.all(
                                                const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                                )
                                            )
                                        ),
                                        child: const Text(
                                          "Next",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black
                                          ),
                                        )
                                    )
                                  ],
                                )
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                // Positioned(
                //     bottom: 20,
                //     left: 0,
                //     child: Navbar()
                // )
              ],
            ),
          ),
        )
    );
  }
}
