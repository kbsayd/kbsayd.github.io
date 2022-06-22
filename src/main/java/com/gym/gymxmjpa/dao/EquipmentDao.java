package com.gym.gymxmjpa.dao;


import com.gym.gymxmjpa.entity.Equipment;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * @Description: 设备信息Dao层接口
 */
public interface EquipmentDao extends JpaRepository<Equipment,Long> {
}
