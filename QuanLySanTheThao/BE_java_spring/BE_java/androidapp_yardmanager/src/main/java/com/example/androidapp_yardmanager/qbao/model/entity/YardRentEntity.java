package com.example.androidapp_yardmanager.qbao.model.entity;


import jakarta.persistence.*;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.LocalDateTime;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@Entity
@Table(name = "rent_yard_")
public class YardRentEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id_")
    String id_;

    @NotNull(message = "không được để trống id của người dùng ")
    @NotEmpty(message = "không được để trống id của người dùng ")
    @Column(name = "id_user_")
    String idUser_;

    @NotNull(message = "không được để trống id của sân  ")
    @NotEmpty(message = "không được để trống id của sân  ")
    @Column(name = "id_yard_")
    String idYard_;

    @NotNull(message = "không được để trống ngày thuê của người dùng ")
    @NotEmpty(message = "không được để trống ngày thuê của người dùng ")
    @Column(name = "start_day_")
    LocalDateTime startDay_;

    @NotNull(message = "không được để trống ngày trả sân của người dùng ")
    @NotEmpty(message = "không được để trống ngày trả sân của người dùng ")
    @Column(name = "end_day_")
    LocalDateTime endDay_;

    @NotNull(message = "không được để trống trạng thái thanh toán của người dùng  ")
    @NotEmpty(message = "không được để trống trạng thái thanh toán của người dùng ")
    @Column(name = "status_")
    String status_;

    @Column(name = "status_delete_")
    String statusDelete_;

    @Column(name = "day_delete_")
    LocalDateTime dayDelete_;

}
