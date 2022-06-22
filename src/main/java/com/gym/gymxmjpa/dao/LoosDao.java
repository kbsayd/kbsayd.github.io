package com.gym.gymxmjpa.dao;


import com.gym.gymxmjpa.entity.Loos;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * @Description: 丢失物品信息Dao层接口
 */
public interface LoosDao extends JpaRepository<Loos,Long> {
}
