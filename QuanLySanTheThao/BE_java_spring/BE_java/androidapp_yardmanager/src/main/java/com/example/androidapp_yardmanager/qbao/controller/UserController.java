package com.example.androidapp_yardmanager.qbao.controller;

import com.example.androidapp_yardmanager.qbao.ApiSetting.ApiRespone;
import com.example.androidapp_yardmanager.qbao.model.entity.UserEnitty;
import com.example.androidapp_yardmanager.qbao.model.request.LoginRequest;
import com.example.androidapp_yardmanager.qbao.model.respone.LoginRespone;
import com.example.androidapp_yardmanager.qbao.model.respone.YardDetailRespone;
import com.example.androidapp_yardmanager.qbao.model.respone.YardDetailTimeRentRespone;
import com.example.androidapp_yardmanager.qbao.model.respone.YardRespone;
import com.example.androidapp_yardmanager.qbao.service.UserLoginService;
import com.example.androidapp_yardmanager.qbao.service.YardService;
import jakarta.persistence.Tuple;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@RequiredArgsConstructor
@RestController
@RequestMapping("${apiRequest.url}")
public class UserController {

    @Autowired
    UserLoginService userLoginService;
    @Autowired
    YardService yardService;

    @GetMapping("/test_server")
    public ApiRespone<List<String>> testSerVer(@RequestParam(name = "time",required = false) LocalDateTime time){

//        System.out.println(time.getHour());
//        System.out.println(LocalDateTime.now().getHour());
//        System.out.println(time.getHour()-LocalDateTime.now().getHour());

        List<String> resultApi = new ArrayList<>();
        resultApi.add("test result");

        return ApiRespone.<List<String>>builder()
                .deription_("test deription")
                .respone_(200)
                .result_(resultApi)
                .build();
    }


    @PutMapping("/login")
    public ApiRespone<LoginRespone> login(@RequestBody LoginRequest loginRequest){
        return userLoginService.login(loginRequest);
    }


    @PostMapping("/sigup")
    public ApiRespone<LoginRespone> sigup(@RequestBody @Valid UserEnitty userEnittyRequest_){
        return userLoginService.sigup(userEnittyRequest_);
    }

    @GetMapping("/search_yard")
    public ApiRespone<List<YardRespone>> searchYard(@RequestParam(name = "nameYard_",required = false) String nameYard_,
                                                    @RequestParam(name = "addressYard_",required = false) String addressYard_,
                                                    @RequestParam(name = "statusYard_",required = false) String statusYard_){

        System.out.println(nameYard_+addressYard_+statusYard_);

        return  yardService.searchYard(nameYard_,addressYard_,statusYard_);
    }

    @RequestMapping("/yard_detail/{id}")
    public ApiRespone<YardDetailRespone> yardDetail(@PathVariable("id") String id_){
        System.out.println(id_);
        yardService.yardDetail(id_);
        return null;
    }





}
