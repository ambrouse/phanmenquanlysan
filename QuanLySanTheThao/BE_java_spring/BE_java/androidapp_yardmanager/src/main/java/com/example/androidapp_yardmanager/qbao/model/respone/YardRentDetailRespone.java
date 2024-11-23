package com.example.androidapp_yardmanager.qbao.model.respone;


import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.LocalDateTime;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class YardRentDetailRespone {
    String timeRent_;
    LocalDateTime timeStartRent_;
    LocalDateTime timeEndRent_;
}
