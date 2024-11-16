package com.example.androidapp_yardmanager.qbao.model.repo;

import com.example.androidapp_yardmanager.qbao.model.entity.YardRentEntity;
import jakarta.persistence.Tuple;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface YardRentRepo extends JpaRepository<YardRentEntity,String> {

    @Query(value = "select u.start_day_, u.end_day_ " +
            "from rent_yard_ u " +
            "where u.id_yard_ = :idYard_",nativeQuery = true)
    List<Tuple> findByIdYard(@Param("idYard_") String idYard_);
}
