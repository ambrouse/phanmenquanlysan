package com.example.androidapp_yardmanager.qbao.model.respone;


import lombok.*;
import lombok.experimental.FieldDefaults;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class YardDetailEntityRespone {
    String name_;
    String address_;
    String status_;

}
