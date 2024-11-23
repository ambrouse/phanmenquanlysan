package com.example.androidapp_yardmanager.qbao.model.respone;


import com.example.androidapp_yardmanager.qbao.model.entity.YardEntity;
import com.example.androidapp_yardmanager.qbao.model.entity.YardRentEntity;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class YardDetailRespone {
    List<YardDetailEntityRespone> yardEntity_;
    List<YardRentDetailRespone> yardRentEntitie_;
}
