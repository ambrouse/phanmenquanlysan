package com.example.androidapp_yardmanager.qbao.model.repo;


import com.example.androidapp_yardmanager.qbao.model.entity.UserEnitty;
import jakarta.persistence.Tuple;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
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

    @Query(value = "select id_ " +
            "from user_ u " +
            "where  u.phone_ = :loginName_ " +
            "or u.mail_ = :loginName_",nativeQuery = true)
    String getIdUser(@Param("loginName_") String loginName_);

    @Query(value = "select u.name_, u.mail_, u.phone_ " +
            "from user_ u " +
            "where u.id_ = :idUser_",nativeQuery = true)
    Tuple getUserById(@Param("idUser_") String idUser_);

    @Modifying
    @Query(value = "update user_ " +
            "set name_ = :nameUser_, mail_ = :mailUser_, phone_ = :phoneUser_ " +
            "where id_ = :idUser_",nativeQuery = true)
    void updateUser(@Param("idUser_") String idUser_,
                    @Param("nameUser_") String nameUser_,
                    @Param("mailUser_") String mailUser_,
                    @Param("phoneUser_") String phoneUser_);
}
