package com.example.androidapp_yardmanager.qbao.controller;

import com.example.androidapp_yardmanager.qbao.ApiSetting.ApiRespone;
import com.example.androidapp_yardmanager.qbao.model.entity.ComplainEntity;
import com.example.androidapp_yardmanager.qbao.model.entity.UserEnitty;
import com.example.androidapp_yardmanager.qbao.model.entity.YardRentEntity;
import com.example.androidapp_yardmanager.qbao.model.request.LoginRequest;
import com.example.androidapp_yardmanager.qbao.model.respone.*;
import com.example.androidapp_yardmanager.qbao.service.*;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@RequiredArgsConstructor
@RestController
@RequestMapping("${apiRequest.url}")
public class UserController {

    @Autowired
    UserLoginService userLoginService;
    @Autowired
    YardService yardService;
    @Autowired
    AddressYardService addressYardService;
    @Autowired
    UserService userService;
    @Autowired
    RentYardService rentYardService;
    @Autowired
    ComplainService complainService;

    @GetMapping("/test_server")
    public ApiRespone<List<String>> testSerVer(@RequestParam(name = "time",required = false) LocalDateTime time){
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

        return  yardService.searchYard(nameYard_,addressYard_,statusYard_);
    }

    @RequestMapping("/yard_detail/{id}")
    public ApiRespone<YardDetailRespone> yardDetail(@PathVariable("id") String id_){

        return yardService.yardDetail(id_);
    }

    @RequestMapping("/address_yard")
    public ApiRespone<List<AddressYardRespone>> getAllAddressYard(){

        return addressYardService.getAllAddressYard();
    }

    @PostMapping("/rentyard")
    public ApiRespone<String> createRentYard(@RequestBody @Valid YardRentEntity yardRentEntityRequest_){

        return yardService.createRentYard(yardRentEntityRequest_);
    }

    @RequestMapping("/user/{idUser_}")
    public  ApiRespone<UserInfoRespone> getUserById(@PathVariable("idUser_") String idUser_){

        return userService.getInfoUser(idUser_);
    }

    @PutMapping("/user")
    public  ApiRespone<String> updateUserById(@RequestBody @Valid UserEnitty userEnittyRequest_){

        return userService.updateUser(userEnittyRequest_);
    }


    @RequestMapping("/rentyard/{idUser_}")
    public  ApiRespone<List<RentYardWithUserRespone>> getRentYardWithUser(@PathVariable("idUser_") String idUser_){

        return rentYardService.getRentYardByUser(idUser_);
    }

    @DeleteMapping("/rentyard/{idRentYard_}")
    public  ApiRespone<String> deleteRentYard(@PathVariable("idRentYard_") String idRentYard_){

        return rentYardService.deleteRentYard(idRentYard_);
    }

    @RequestMapping("/complain/{idUser_}")
    public  ApiRespone<List<ComplainRespone>> getAllComplaintUser(@PathVariable("idUser_") String idUser_){

        return complainService.getAllComplain(idUser_);
    }

    @PostMapping("/complain")
    public  ApiRespone<String> createComplain(@RequestBody ComplainEntity complainEntityRequest_){

        return complainService.createComplain(complainEntityRequest_);
    }



}
