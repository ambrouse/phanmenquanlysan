package com.example.androidapp_yardmanager.qbao.service;

import com.example.androidapp_yardmanager.qbao.ApiSetting.ApiRespone;
import com.example.androidapp_yardmanager.qbao.model.repo.AddressRepo;
import com.example.androidapp_yardmanager.qbao.model.respone.AddressYardRespone;
import jakarta.persistence.Tuple;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class AddressYardService {

    @Autowired
    AddressRepo addressRepo;

    public ApiRespone<List<AddressYardRespone>> getAllAddressYard(){
        List<Tuple> addresstuple = addressRepo.getAllAddressYard();

        List<AddressYardRespone> addressYardRespones = addresstuple.stream().map(t-> new AddressYardRespone(
                t.get("id_",String.class),
                t.get("name_",String.class)
        )).collect(Collectors.toList());

        addressYardRespones.add(AddressYardRespone.builder()
                        .idAddress_("")
                        .nameAddress_("Tất cả")
                .build());

        return ApiRespone.<List<AddressYardRespone>>builder()
                .respone_(200)
                .deription_("request adderss yard ok")
                .result_(addressYardRespones)
                .build();
    }
}
