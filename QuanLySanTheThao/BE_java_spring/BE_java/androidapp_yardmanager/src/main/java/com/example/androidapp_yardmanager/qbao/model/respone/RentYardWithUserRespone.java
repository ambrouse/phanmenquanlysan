package com.example.androidapp_yardmanager.qbao.model.respone;


import lombok.*;
import lombok.experimental.FieldDefaults;

import java.sql.Timestamp;
import java.time.LocalDateTime;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class RentYardWithUserRespone {
    String nameYard_;
    String addressYard_;
    String statusYard_;
    LocalDateTime startDay_;
    LocalDateTime endDay_;
    String rentTime;
}
