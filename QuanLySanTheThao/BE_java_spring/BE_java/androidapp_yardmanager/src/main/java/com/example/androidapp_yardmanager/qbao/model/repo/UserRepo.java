package com.example.androidapp_yardmanager.qbao.model.repo;


import com.example.androidapp_yardmanager.qbao.model.entity.UserEnitty;
import jakarta.persistence.Tuple;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;


public interface UserRepo extends JpaRepository<UserEnitty,String> {

    @Query(value = "select password_ " +
            "from user_ u " +
            "where  u.phone_ = :loginName_ " +
            "or u.mail_ = :loginName_",nativeQuery = true)
    String login(@Param("loginName_") String loginName_);

    @Query(value = "select id_ " +
            "from user_ u " +
            "where u.phone_ = :phone_ or u.mail_ = :email_ ",nativeQuery = true)
    String checkLogin(@Param("phone_") String phone_,
                      @Param("email_") String email_);
}
