package com.example.androidapp_yardmanager.qbao.model.entity;


import com.example.androidapp_yardmanager.qbao.exception.CustomValidErr.string.*;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.LocalDateTime;
import java.util.Date;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@Entity
@Table(name = "user_")
public class UserEnitty {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id_",length = 60)
    String id_;
    @NotNull(message = "Tên người dùng không được rỗng")
    @NotEmpty(message = "Tên người dùng không được rỗng")
    @Column(name = "name_",length = 255)
    String name_;
    @CheckGmailString(message = "Gmail không đúng định dạng")
    @NotNull(message = "Gmail không được để trống")
    @NotEmpty(message = "Tên người dùng không được rỗng")
    @Column(name = "mail_",length = 255)
    String email_;
    @NotNull(message = "Số điện thoại không được để trống")
    @NotEmpty(message = "Tên người dùng không được rỗng")
    @Size(max = 10,min = 10, message = "Số điện thoại sai định dạng")
    @Column(name = "phone_",length = 10)
    String phone_;
    @NotNull(message = "Mật khẩu không được để trống")
    @NotEmpty(message = "Tên người dùng không được rỗng")
    @Size(min = 8, message = "Mật khẩu phải trên 8 kí tự")
    @Column(name = "password_",length = 255)
    String password_;
    @Column(name = "status_delete_",length = 1)
    Integer statusDelete_;
    @Column(name = "day_delete_")
    LocalDateTime dayDelete_;
}
