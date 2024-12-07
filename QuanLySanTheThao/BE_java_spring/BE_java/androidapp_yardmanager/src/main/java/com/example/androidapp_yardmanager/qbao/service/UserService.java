package com.example.androidapp_yardmanager.qbao.service;

import com.example.androidapp_yardmanager.qbao.ApiSetting.ApiRespone;
import com.example.androidapp_yardmanager.qbao.exception.CustomException;
import com.example.androidapp_yardmanager.qbao.model.entity.UserEnitty;
import com.example.androidapp_yardmanager.qbao.model.repo.UserRepo;
import com.example.androidapp_yardmanager.qbao.model.respone.UserInfoRespone;
import jakarta.persistence.Tuple;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
@RequiredArgsConstructor
public class UserService {

    @Autowired
    UserRepo userRepo;

    public ApiRespone<UserInfoRespone> getInfoUser(String idUser_){
        Tuple tupleUserInfo_ = userRepo.getUserById(idUser_);

        return ApiRespone.<UserInfoRespone>builder()
                .respone_(200)
                .deription_("request get user by id ok")
                .result_(UserInfoRespone.builder()
                        .nameUser_(tupleUserInfo_.get(0).toString())
                        .emailUser_(tupleUserInfo_.get(1).toString())
                        .phoneUser_(tupleUserInfo_.get(2).toString())
                        .build())
                .build();
    }


    public ApiRespone<String> updateUser(UserEnitty userEnittyRequest_){
//        userEnittyRequest_.setStatusDelete_(1);
//        UserEnitty userEnitty = userRepo.findById(userEnittyRequest_.getId_()).get();
//        userEnittyRequest_.setPassword_(userEnitty.getPassword_());
        try {
            userRepo.updateUser(userEnittyRequest_.getId_(),
                    userEnittyRequest_.getName_(),
                    userEnittyRequest_.getEmail_(),
                    userEnittyRequest_.getPhone_());

            System.out.println(userEnittyRequest_);

            return ApiRespone.<String>builder()
                    .result_("Cập nhật người dùng thành công.")
                    .deription_("request update user ok")
                    .respone_(200)
                    .build();
        }catch (RuntimeException e){
            throw new RuntimeException(CustomException.builder()
                    .desription_("Cập nhật người dùng not thành công.")
                    .build());
        }

    }



}
