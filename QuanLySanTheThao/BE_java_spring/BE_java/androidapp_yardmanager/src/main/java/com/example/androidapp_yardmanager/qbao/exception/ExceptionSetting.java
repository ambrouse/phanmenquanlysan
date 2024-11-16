package com.example.androidapp_yardmanager.qbao.exception;


import com.example.androidapp_yardmanager.qbao.ApiSetting.ApiRespone;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class ExceptionSetting {

    @ExceptionHandler
    ResponseEntity<ApiRespone<String>> setting(CustomException customException){
        return ResponseEntity.badRequest().body(ApiRespone.<String>builder()
                        .deription_("Request error")
                        .respone_(200)
                        .result_(customException.getDesription_())
                .build());
    }


    @ExceptionHandler
    ResponseEntity<ApiRespone<String>> valid(MethodArgumentNotValidException customException){
        return ResponseEntity.badRequest().body(ApiRespone.<String>builder()
                .deription_("Request error")
                .respone_(200)
                .result_(customException.getFieldError().getDefaultMessage())
                .build());
    }

}
