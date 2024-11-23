package com.example.androidapp_yardmanager.qbao.model.entity;


import jakarta.persistence.*;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@Entity
@Table(name = "yard_")
public class YardEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id_")
    String id_;

    @NotNull(message = "Không được để trống tên của sân")
    @NotEmpty(message = "Không được để trống tên của sân")
    @Column(name = "name_")
    String name_;

    @NotNull(message = "Không được để trống địa của sân")
    @NotEmpty(message = "Không được để trống địa chỉ của sân")
    @Column(name = "id_address_")
    String idAddress_;

    @NotNull(message = "Không được để trống trạng thái của sân")
    @NotEmpty(message = "Không được để trống trạng thái của sân")
    @Column(name = "status_")
    String status_;

    @Column(name = "status_delete_")
    String statusDelete_;

    @Column(name = "day_delete_")
    LocalDateTime dayDelete_;

}
