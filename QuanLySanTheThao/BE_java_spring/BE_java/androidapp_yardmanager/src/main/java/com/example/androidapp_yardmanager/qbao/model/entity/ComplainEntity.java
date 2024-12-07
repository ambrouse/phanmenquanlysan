package com.example.androidapp_yardmanager.qbao.model.entity;


import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.LocalDateTime;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@Entity
@Table(name = "complain_")
public class ComplainEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id_")
    String id_;

    @Column(name = "id_user_")
    String idUser_;

    @Column(name = "content_")
    String content_;

    @Column(name = "status_")
    String status_;

    @Column(name = "title_")
    String title_;

    @Column(name = "status_delete_")
    int statusDelete_;

    @Column(name = "day_delete_")
    LocalDateTime dayDelete_;

    @Column(name = "day_complain_")
    LocalDateTime dayComplaint_;

}
