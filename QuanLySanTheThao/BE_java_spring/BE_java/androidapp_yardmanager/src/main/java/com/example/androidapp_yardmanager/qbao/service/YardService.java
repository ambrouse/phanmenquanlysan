package com.example.androidapp_yardmanager.qbao.service;


import com.example.androidapp_yardmanager.qbao.ApiSetting.ApiRespone;
import com.example.androidapp_yardmanager.qbao.exception.CustomException;
import com.example.androidapp_yardmanager.qbao.model.entity.YardEntity;
import com.example.androidapp_yardmanager.qbao.model.entity.YardRentEntity;
import com.example.androidapp_yardmanager.qbao.model.repo.YardRentRepo;
import com.example.androidapp_yardmanager.qbao.model.repo.YardRepo;
import com.example.androidapp_yardmanager.qbao.model.respone.YardDetailEntityRespone;
import com.example.androidapp_yardmanager.qbao.model.respone.YardDetailRespone;
import com.example.androidapp_yardmanager.qbao.model.respone.YardRentDetailRespone;
import com.example.androidapp_yardmanager.qbao.model.respone.YardRespone;
import jakarta.persistence.Tuple;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
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
                t.get("id_",String.class),
                t.get("name_",String.class),
                t.get("addressName_",String.class),
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

        List<Tuple> tupleYardDetailDatetime_ = yardRentRepo.findByIdYard(idYard_);
        List<Tuple> tupleyardEntity_ = yardRepo.yarddetail(idYard_);

        List<YardRentDetailRespone> yardRentDetailRespones = tupleYardDetailDatetime_.stream().map(t->new YardRentDetailRespone(
                t.get("rent_time_", String.class),
                t.get("start_day_", Timestamp.class).toLocalDateTime(),
                t.get("end_day_", Timestamp.class).toLocalDateTime()
        )).collect(Collectors.toList());
        List<YardDetailEntityRespone> yardDetailRespones = tupleyardEntity_.stream().map(t->new YardDetailEntityRespone(
                t.get(0, String.class),
                t.get(1, String.class),
                t.get(2, String.class)
        )).collect(Collectors.toList());


        return ApiRespone.<YardDetailRespone>builder()
                .respone_(200)
                .deription_("request yard detail ok")
                .result_(YardDetailRespone.builder()
                        .yardEntity_(yardDetailRespones)
                        .yardRentEntitie_(yardRentDetailRespones)
                        .build())
                .build();
    }

    public ApiRespone<String> createRentYard(YardRentEntity yardRentEntityRequest_){
        if(yardRentEntityRequest_.getStartDay_().compareTo(yardRentEntityRequest_.getEndDay_())>0){
            throw new RuntimeException(CustomException.builder()
                    .desription_("Ngày bắt đầu đặt sân không thể lớn hơn ngày trả sân")
                    .build());

        }

        yardRentEntityRequest_.setStatus_("0");
        yardRentEntityRequest_.setStatusDelete_(1);
        int startHours_ = yardRentEntityRequest_.getStartDay_().getHour();
        int endHours_ = yardRentEntityRequest_.getEndDay_().getHour();
        if((yardRentEntityRequest_.getStartDay_().getMinute()+yardRentEntityRequest_.getEndDay_().getMinute())>0&&(yardRentEntityRequest_.getStartDay_().getMinute()+yardRentEntityRequest_.getEndDay_().getMinute())<60){
            endHours_+=1;
        }else if((yardRentEntityRequest_.getStartDay_().getMinute()+yardRentEntityRequest_.getEndDay_().getMinute())>60){
            endHours_+=2;
        }
        yardRentEntityRequest_.setRentTime_(Integer.toString(endHours_-startHours_));
        System.out.println(yardRentEntityRequest_);
        yardRentRepo.save(yardRentEntityRequest_);
        return ApiRespone.<String>builder()
                .result_("Đăng kí sân hoàn tất, đang chuyển trang thanh toán.")
                .respone_(200)
                .deription_("request create rent yard ok")
                .build();
    }


}
