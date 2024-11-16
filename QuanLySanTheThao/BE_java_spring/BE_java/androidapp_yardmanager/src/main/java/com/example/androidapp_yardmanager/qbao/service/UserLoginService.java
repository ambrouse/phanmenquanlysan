package com.example.androidapp_yardmanager.qbao.service;


import com.example.androidapp_yardmanager.qbao.ApiSetting.ApiRespone;
import com.example.androidapp_yardmanager.qbao.exception.CustomException;
import com.example.androidapp_yardmanager.qbao.model.entity.UserEnitty;
import com.example.androidapp_yardmanager.qbao.model.repo.UserRepo;
import com.example.androidapp_yardmanager.qbao.model.request.LoginRequest;
import com.example.androidapp_yardmanager.qbao.model.respone.LoginRespone;
import com.nimbusds.jose.*;
import com.nimbusds.jose.crypto.MACSigner;
import com.nimbusds.jose.crypto.MACVerifier;
import com.nimbusds.jwt.JWTClaimsSet;
import com.nimbusds.jwt.SignedJWT;
import jakarta.persistence.Tuple;
import lombok.experimental.NonFinal;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class UserLoginService {

    @Autowired
    UserRepo userRepo;

    public ApiRespone<LoginRespone> sigup(UserEnitty userEnittyRequest_){
//        try {
            PasswordEncoder passwordEncoder = new BCryptPasswordEncoder(10);
            String checkUser = userRepo.checkLogin(userEnittyRequest_.getPhone_(),userEnittyRequest_.getEmail_());

            if(checkUser==null){
                userEnittyRequest_.setPassword_(passwordEncoder.encode(userEnittyRequest_.getPassword_()));
                userEnittyRequest_.setStatusDelete_(1);
                userRepo.save(userEnittyRequest_);

                return ApiRespone.<LoginRespone>builder()
                        .respone_(200)
                        .deription_("Request ok")
                        .result_(LoginRespone.builder()
                                .checkLogin_(true)
                                .desriptions_("Đăng kí thành công")
                                .build())
                        .build();
            }else{
                throw new RuntimeException(CustomException.builder()
                        .desription_("Người dùng đã tồn tại, email hay số điện thoại bị trùng")
                        .build());
            }
    }


    public ApiRespone<LoginRespone> login(LoginRequest loginRequest){
        try {
            String passLoginFind_ = userRepo.login(loginRequest.getLoginName_());

            if(passLoginFind_ != null){
                PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
                if(passwordEncoder.matches(loginRequest.getLoginPassword_(),passLoginFind_)){
                    String token_ = create_token(loginRequest.getLoginName_());

                    return ApiRespone.<LoginRespone>builder()
                            .respone_(200)
                            .deription_("Request ok")
                            .result_(LoginRespone.builder()
                                    .checkLogin_(true)
                                    .token_(token_)
                                    .desriptions_("Đăng nhập thành công")
                                    .build())
                            .build();
                }else{
                    return ApiRespone.<LoginRespone>builder()
                            .respone_(200)
                            .deription_("Request false")
                            .result_(LoginRespone.builder()
                                    .checkLogin_(false)
                                    .desriptions_("Sai mật khẩu")
                                    .build())
                            .build();
                }
            }else{
                return ApiRespone.<LoginRespone>builder()
                        .respone_(200)
                        .deription_("Request false")
                        .result_(LoginRespone.builder()
                                .checkLogin_(false)
                                .desriptions_("Sai số điện thoại, email hoặc người dùng chưa đăng ký")
                                .build())
                        .build();
            }
        } catch (RuntimeException e) {
            throw new RuntimeException(CustomException.builder()
                    .desription_("Lỗi hệ thống")
                    .build());
        }
    }

    @NonFinal
    private final String key_create_token_ = "aHa66Jus+2XX03YJO7MFcs6RnN4eHCsjLmmcIATMmjEi7RctICJiZzI3dzWZrh2q";

    private String create_token(String idUser_){
        JWSHeader jwsHeader = new JWSHeader(JWSAlgorithm.HS512);
        JWTClaimsSet jwtClaimsSet = new JWTClaimsSet.Builder()
                .subject(idUser_)
                .issuer("ten_domain")
                .issueTime(new Date())
                .expirationTime(new Date(
                        Instant.now().plus(2, ChronoUnit.HOURS).toEpochMilli()
                ))
                .claim("scope","user")
                .build();
        Payload payload = new Payload(jwtClaimsSet.toJSONObject());
        JWSObject jwsObject = new JWSObject(jwsHeader,payload);

        try {
            jwsObject.sign(new MACSigner(key_create_token_.getBytes()));
            String a = jwsObject.serialize();
            return a;
        } catch (JOSEException e) {
            throw new RuntimeException(CustomException.builder()
                    .desription_("Khong the tao token cho user")
                    .build());
        }
    }

    public boolean verify_token(String token) throws JOSEException, ParseException {
        JWSVerifier jwsVerifier = new MACVerifier(key_create_token_.getBytes());
        SignedJWT signedJWT = SignedJWT.parse(token);
        boolean verify = signedJWT.verify(jwsVerifier);
        boolean check_time = signedJWT.getJWTClaimsSet().getExpirationTime().after(new Date());
        boolean check = (verify == true && check_time == true);
        var a = SecurityContextHolder.getContext().getAuthentication();
        a.getAuthorities().forEach(e -> System.out.println(e.getAuthority()));
        return check;

    }
}
