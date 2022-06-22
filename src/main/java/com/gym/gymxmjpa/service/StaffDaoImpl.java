package com.gym.gymxmjpa.service;

import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.HashMap;
import java.util.Map;

/**
 * @Description: 员工管理service实现层
 */
@Service
public class StaffDaoImpl {

    @PersistenceContext
    private EntityManager entityManager;

    /**
     * @Description: 员工管理service实现层-分页查询
     */
    public Map<String,Object> query(Map<String,Object> map1){
        //分页
        String jpal="from Staff where 1=1";
        if(map1.get("staffname")!=null && !map1.get("staffname").equals("")){
            jpal=jpal+" and staffName like '%"+map1.get("staffname")+"%'";
        }
        Query qu=entityManager.createQuery(jpal);
        //起始页书
        qu.setFirstResult((int)map1.get("qi"));
        //结束页数
        qu.setMaxResults((int)map1.get("shi"));

        //查询多少条数据
        String jpa="select count(c) from Staff c where 1=1";

        if(map1.get("staffname")!=null && !map1.get("staffname").equals("")){
            jpa=jpa+" and staffName like '%"+map1.get("staffname")+"%'";
        }

        Long count=(Long) entityManager.createQuery(jpa).getSingleResult();
        Map<String,Object> map=new HashMap<String,Object>();
        map.put("total",count);
        map.put("rows",qu.getResultList());
        return map;
    }

    /**
     * @Description: 员工管理service实现层-查询总数据
     */
    public Long count(String  staffName){
        String jpa="select count(c) from Staff c where staffName ='"+staffName+"'";
        Query query=entityManager.createQuery(jpa);
        System.out.println(query);
        Long c=(Long)query.getSingleResult();
        return c;
    }
}
