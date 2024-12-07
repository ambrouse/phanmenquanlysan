package com.example.androidapp_yardmanager.qbao.model.repo;


import com.example.androidapp_yardmanager.qbao.model.entity.ComplainEntity;
import jakarta.persistence.Tuple;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ComplainRepo extends JpaRepository<ComplainEntity,String> {

    @Query(value = "select id_,title_, content_, status_ , day_complain_ " +
            "from complain_ " +
            "where id_user_ = :idUser_",nativeQuery = true)
    List<Tuple> getAllComplainUser(@Param("idUser_") String idUser_);
}
