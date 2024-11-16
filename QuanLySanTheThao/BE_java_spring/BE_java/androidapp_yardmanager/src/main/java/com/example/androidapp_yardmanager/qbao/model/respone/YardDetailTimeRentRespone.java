package com.example.androidapp_yardmanager.qbao.model.respone;

import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.LocalDateTime;
import java.util.Date;


@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class YardDetailTimeRentRespone {
    LocalDateTime startDay_;
    LocalDateTime endDay_;
}
