package com.example.androidapp_yardmanager.qbao.service;


import com.example.androidapp_yardmanager.qbao.ApiSetting.ApiRespone;
import com.example.androidapp_yardmanager.qbao.exception.CustomException;
import com.example.androidapp_yardmanager.qbao.model.repo.YardRentRepo;
import com.example.androidapp_yardmanager.qbao.model.respone.RentYardWithUserRespone;
import jakarta.persistence.Tuple;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class RentYardService {
    @Autowired
    YardRentRepo yardRentRepo;

    public ApiRespone<List<RentYardWithUserRespone>> getRentYardByUser(String idUserRequest_){

        List<Tuple> tupleRentYard_ = yardRentRepo.getRentYardByUser(idUserRequest_);

        List<RentYardWithUserRespone> rentYardWithUserRespones = tupleRentYard_.stream().map(t->new RentYardWithUserRespone(
                t.get("id_",String.class),
                t.get("nameYard_",String.class),
                t.get("nameAddress_",String.class),
                t.get("statusRentYard_",String.class),
                t.get("start_day_", Timestamp.class).toLocalDateTime(),
                t.get("end_day_",Timestamp.class).toLocalDateTime(),
                t.get("rent_time_",String.class)
        )).collect(Collectors.toList());

        if(rentYardWithUserRespones.isEmpty()){
            throw new RuntimeException(CustomException.builder()
                    .desription_("Không có sân nào được đặt")
                    .build());
        }
        return ApiRespone.<List<RentYardWithUserRespone>>builder()
                .respone_(200)
                .deription_("request get rentyard by user ok")
                .result_(rentYardWithUserRespones)
                .build();
    }

    public ApiRespone<String> deleteRentYard(String idRentYardRequest_){
        try {
            yardRentRepo.deleteRentYard_(idRentYardRequest_);

        } catch (RuntimeException e) {
            throw new RuntimeException(CustomException.builder()
                    .desription_("Không thể xóa được đơn đặt hàng vui lòng liên hệ chủ sân để giải quyết.")
                    .build());
        }

        return ApiRespone.<String>builder()
                .respone_(200)
                .deription_("request delete rent yard ok")
                .result_("Đã xóa đơn đặt hàng.")
                .build();
    }


}
