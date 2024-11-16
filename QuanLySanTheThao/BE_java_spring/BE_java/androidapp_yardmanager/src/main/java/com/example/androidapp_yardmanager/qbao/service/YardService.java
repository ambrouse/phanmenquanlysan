package com.example.androidapp_yardmanager.qbao.service;


import com.example.androidapp_yardmanager.qbao.ApiSetting.ApiRespone;
import com.example.androidapp_yardmanager.qbao.exception.CustomException;
import com.example.androidapp_yardmanager.qbao.model.entity.YardEntity;
import com.example.androidapp_yardmanager.qbao.model.repo.YardRentRepo;
import com.example.androidapp_yardmanager.qbao.model.repo.YardRepo;
import com.example.androidapp_yardmanager.qbao.model.respone.YardDetailRespone;
import com.example.androidapp_yardmanager.qbao.model.respone.YardRespone;
import jakarta.persistence.Tuple;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class YardService {

    @Autowired
    YardRepo yardRepo;
    @Autowired
    YardRentRepo yardRentRepo;

    public ApiRespone<List<YardRespone>> searchYard(String nameYard_, String addressYard_, String statusYard_){

        if(nameYard_==null || nameYard_.isEmpty()){
            nameYard_="";
        }

        if(addressYard_==null || addressYard_.isEmpty()){
            addressYard_="";
        }

        if(statusYard_==null || statusYard_.isEmpty()){
            statusYard_="";
        }

        List<Tuple> tupleYard_ = yardRepo.searchYard(nameYard_,addressYard_,statusYard_);
        List<YardRespone> yardEntities = tupleYard_.stream().map(t -> new YardRespone(
                t.get("name_",String.class),
                t.get("address_",String.class),
                t.get("status_",String.class)
        )).collect(Collectors.toList());

        System.out.println(yardEntities);

        if(yardEntities.size()!=0){
            return ApiRespone.<List<YardRespone>>builder()
                    .deription_("Request search yard ok")
                    .respone_(200)
                    .result_(yardEntities)
                    .build();
        }else{
            throw new RuntimeException(CustomException.builder()
                    .desription_("Không tìm thấy sân theo yêu cầu")
                    .build());
        }
    }


    public ApiRespone<YardDetailRespone> yardDetail(String idYard_){
        YardEntity yardEntity = yardRepo.findById(idYard_).get();

        List<Tuple> tupleYardDetailDatetime_ = yardRentRepo.findByIdYard(idYard_);
        System.out.println(tupleYardDetailDatetime_);
        return null;

    }


}
