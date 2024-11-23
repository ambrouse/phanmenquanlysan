package com.example.androidapp_yardmanager.qbao.model.repo;

import com.example.androidapp_yardmanager.qbao.model.entity.YardRentEntity;
import jakarta.persistence.Tuple;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface YardRentRepo extends JpaRepository<YardRentEntity,String> {

    @Query(value = "select u.rent_time_, u.start_day_, u.end_day_ " +
            "from rent_yard_ u " +
            "where u.id_yard_ = :idYard_",nativeQuery = true)
    List<Tuple> findByIdYard(@Param("idYard_") String idYard_);


    @Query(value = "select y.name_ as nameYard_, a.name_ as nameAddress_, r.status_ as statusRentYard_, r.start_day_, r.end_day_, r.rent_time_ " +
            "from rent_yard_ r, yard_ y , address_yard_ a " +
            "where r.id_yard_ = y.id_ and r.id_user_ = :idUser_ and a.id_ = y.id_address_",nativeQuery = true)
    List<Tuple> getRentYardByUser(@Param("idUser_") String idUser_);
}
