package com.gym.gymxmjpa.service;

import com.gym.gymxmjpa.entity.Member;
import org.springframework.stereotype.Service;
import sun.util.resources.ga.LocaleNames_ga;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description
 * @Date 2022/3/4 9:35
 */
@Service
public class chongzhiservice {
    @PersistenceContext
    private EntityManager entityManager;

    public Map<String,Object> query2(Map<String,Object> map1){
        //分页
        String jpal="from Chongzhi where 1=1";

        Query qu=entityManager.createQuery(jpal);
        //起始页书
        qu.setFirstResult((int)map1.get("qi"));
        //结束页数
        qu.setMaxResults((int)map1.get("shi"));

        //查询多少条数据
        String jpa="select count(c) from Chongzhi c where 1=1";


        Long count=(Long) entityManager.createQuery(jpa).getSingleResult();
        Map<String,Object> map=new HashMap<String,Object>();
        map.put("total",count);
        map.put("rows",qu.getResultList());
        return map;
    }


    public Map<String,Object> query3(Map<String,Object> map1){

        //分页
        String jpa="from Chongzhi c where memberid="+ map1.get("id");;
        Query qu=entityManager.createQuery(jpa);
        //起始页书
        qu.setFirstResult((int)map1.get("qi"));
        //结束页数
        qu.setMaxResults((int)map1.get("shi"));
        //查询多少条数据
        String jpal="select count(c) from Chongzhi c where memberid="+ map1.get("id");
        Long count=(Long) entityManager.createQuery(jpal).getSingleResult();
        Map<String,Object> map=new HashMap<String,Object>();
        map.put("total",count);
        map.put("rows",qu.getResultList());
        return  map;
    }

}
