package com.example.androidapp_yardmanager.qbao.model.respone;


import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.LocalDateTime;

@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
@Data
@Builder
public class ComplainRespone {
    String idComplaint_;
    String titleComplaint_;
    String contentComplaint_;
    String statusComplaint_;
    LocalDateTime dayComplaint_;
}
