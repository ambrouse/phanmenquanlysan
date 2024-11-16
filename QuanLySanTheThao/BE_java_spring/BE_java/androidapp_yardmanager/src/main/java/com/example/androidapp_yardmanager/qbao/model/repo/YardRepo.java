package com.example.androidapp_yardmanager.qbao.model.repo;

import com.example.androidapp_yardmanager.qbao.model.entity.YardEntity;
import jakarta.persistence.Tuple;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface YardRepo extends JpaRepository<YardEntity,String> {

    @Query(value = "select * " +
            "from yard_ u " +
            "where u.name_ like %:nameYard_%  and u.address_ like %:addressYard_% and u.status_ like %:statusYard_%",nativeQuery = true)
    List<Tuple> searchYard(@Param("nameYard_") String name,
                           @Param("addressYard_") String address,
                           @Param("statusYard_") String status);
}
