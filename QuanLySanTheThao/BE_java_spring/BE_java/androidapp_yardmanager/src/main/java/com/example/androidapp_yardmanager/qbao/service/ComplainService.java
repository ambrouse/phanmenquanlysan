package com.example.androidapp_yardmanager.qbao.service;


import com.example.androidapp_yardmanager.qbao.ApiSetting.ApiRespone;
import com.example.androidapp_yardmanager.qbao.exception.CustomException;
import com.example.androidapp_yardmanager.qbao.model.entity.ComplainEntity;
import com.example.androidapp_yardmanager.qbao.model.repo.ComplainRepo;
import com.example.androidapp_yardmanager.qbao.model.respone.ComplainRespone;
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
public class ComplainService {

    @Autowired
    ComplainRepo complainRepo_;

    public ApiRespone<List<ComplainRespone>>getAllComplain(String idUserRequest_){
        try {
            List<Tuple> tupleComplaints_ = complainRepo_.getAllComplainUser(idUserRequest_);

            List<ComplainRespone> complainRespones_ = tupleComplaints_.stream().map(t->new ComplainRespone(
                    t.get("id_",String.class),
                    t.get("title_",String.class),
                    t.get("content_",String.class),
                    t.get("status_",String.class),
                    t.get("day_complain_", Timestamp.class).toLocalDateTime()
            )).collect(Collectors.toList());

            if(complainRespones_.isEmpty()){
                throw new RuntimeException(CustomException.builder()
                        .desription_("Không có phản hồi nào từ người dùng.")
                        .build());
            }

            return ApiRespone.<List<ComplainRespone>>builder()
                    .respone_(200)
                    .deription_("request get all complaint with id user ok")
                    .result_(complainRespones_)
                    .build();
        } catch (RuntimeException e) {
            throw new RuntimeException(CustomException.builder()
                    .desription_("Không có phản hồi nào từ người dùng.")
                    .build());
        }
    }

    public ApiRespone<String> createComplain(ComplainEntity complainEntityRequest_){

        complainEntityRequest_.setStatusDelete_(1);
        complainEntityRequest_.setDayComplaint_(LocalDateTime.now());
        complainEntityRequest_.setStatus_("Chưa được xử lý ");
        try {
            complainRepo_.save(complainEntityRequest_);
            return ApiRespone.<String>builder()
                    .respone_(200)
                    .deription_("request create complain ok")
                    .result_("Đã gửi phản hồi đang chờ được giải quyết.")
                    .build();
        } catch (RuntimeException e) {
            throw new RuntimeException(CustomException.builder()
                    .desription_("Không thể gửi được phản hồi liên hệ chủ sân để xử lý!!!")
                    .build());
        }

    }
}
