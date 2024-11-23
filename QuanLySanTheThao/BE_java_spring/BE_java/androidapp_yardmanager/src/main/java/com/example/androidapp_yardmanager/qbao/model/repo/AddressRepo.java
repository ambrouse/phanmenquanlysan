package com.example.androidapp_yardmanager.qbao.model.repo;

import com.example.androidapp_yardmanager.qbao.model.entity.AddressEntity;
import jakarta.persistence.Tuple;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface AddressRepo extends JpaRepository<AddressEntity,String> {

    @Query(value = "select a.id_, a.name_ " +
            "from address_yard_ a ",nativeQuery = true)
    List<Tuple> getAllAddressYard();
}
