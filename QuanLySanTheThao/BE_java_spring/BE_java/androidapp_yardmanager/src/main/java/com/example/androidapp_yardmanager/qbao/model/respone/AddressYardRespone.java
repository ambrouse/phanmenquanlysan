package com.example.androidapp_yardmanager.qbao.model.respone;


import lombok.*;
import lombok.experimental.FieldDefaults;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class AddressYardRespone {
    String idAddress_;
    String nameAddress_;
}
