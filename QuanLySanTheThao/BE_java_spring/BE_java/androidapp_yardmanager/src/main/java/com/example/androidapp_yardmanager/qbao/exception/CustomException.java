package com.example.androidapp_yardmanager.qbao.exception;

import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.FieldDefaults;

@FieldDefaults(level = AccessLevel.PRIVATE)
@Getter
@Setter
@Builder
public class CustomException extends RuntimeException{
    String desription_;

    public CustomException(String des) {
        this.desription_ = des;
    }


}
