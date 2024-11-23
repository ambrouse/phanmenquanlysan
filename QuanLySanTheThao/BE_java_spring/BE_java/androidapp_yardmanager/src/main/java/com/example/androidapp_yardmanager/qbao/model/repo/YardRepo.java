package com.example.androidapp_yardmanager.qbao.model.repo;

import com.example.androidapp_yardmanager.qbao.model.entity.YardEntity;
import jakarta.persistence.Tuple;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface YardRepo extends JpaRepository<YardEntity,String> {

    @Query(value = "select u.id_, u.name_ as name_, a.name_ as addressName_, u.status_ as status_ " +
            "from yard_ u, address_yard_ a " +
            "where (u.name_ like %:nameYard_%  and u.id_address_ like %:addressYard_% and u.status_ like %:statusYard_% ) and u.id_address_ = a.id_ ",nativeQuery = true)
    List<Tuple> searchYard(@Param("nameYard_") String name,
                           @Param("addressYard_") String address,
                           @Param("statusYard_") String status);


    @Query(value = "select u.name_, a.name_, u.status_ " +
            "from yard_ u, address_yard_ a " +
            "where u.id_ = :idYard_ and a.id_ = u.id_address_ ",nativeQuery = true)
    List<Tuple> yarddetail(@Param("idYard_") String idYard_);
}
