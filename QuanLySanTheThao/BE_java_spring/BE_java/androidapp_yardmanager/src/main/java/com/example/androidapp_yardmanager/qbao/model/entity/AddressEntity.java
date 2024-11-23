package com.example.androidapp_yardmanager.qbao.model.entity;


import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.LocalDateTime;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@Table(name = "address_yard_")
public class AddressEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id_")
    String id_;
    @Column(name = "name_")
    String name_;
    @Column(name = "status_delete_")
    String statusDelete_;
    @Column(name = "day_delete_")
    LocalDateTime dayDelete_;
}
