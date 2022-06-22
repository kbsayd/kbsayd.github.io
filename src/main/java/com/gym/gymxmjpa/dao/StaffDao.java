package com.gym.gymxmjpa.dao;


import com.gym.gymxmjpa.entity.Staff;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * @Description: 员工信息Dao层接口
 */

public interface StaffDao extends JpaRepository<Staff,Long> {
}
