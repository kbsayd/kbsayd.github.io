package com.gym.gymxmjpa.dao;


import com.gym.gymxmjpa.entity.Adminuser;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Set;

/**
 * @Description: 管理员Dao层接口
 */
@Transactional
public interface AdminuserDao extends JpaRepository<Adminuser,Long> {


    Adminuser findByAdminNameAndAdminPassword(String name,String password);



    @Query(value=" select * FROM adminuser where adminName= :adminName",nativeQuery = true)
    Adminuser querybyAdminName(@Param("adminName") String adminName);

    @Query(value="select r.roleName FROM adminuser u,role r where u.roleId=r.id and u.adminName= :adminName",nativeQuery = true)
    Set<String> queryByAdminName(@Param("adminName") String adminName);

    @Query(value="select p.permissionName from adminuser u,role r,permission p where u.roleId=r.id and p.roleId=r.id and u.adminName= :adminName",nativeQuery = true)
    Set<String> queryByadminName(@Param("adminName") String adminName);



    @Modifying
    @Query(value = "update  adminuser set adminPassword =:adminPassword where adminId =:adminId",nativeQuery = true)
    void updPassword(@Param("adminId") long adminId,@Param("adminPassword") String adminPassword) ;




}
