package com.example.androidapp_yardmanager.qbao.exception.CustomValidErr.string;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

public class CheckGmailStringSetting implements ConstraintValidator<CheckGmailString,String> {
    @Override
    public void initialize(CheckGmailString constraintAnnotation) {
        ConstraintValidator.super.initialize(constraintAnnotation);
    }

    @Override
    public boolean isValid(String s, ConstraintValidatorContext constraintValidatorContext) {
        if(s==null){return true;}

        if(s.indexOf("@gmail.com",s.length()-10)!=-1){
            return true;
        }

        return false;
    }
}
