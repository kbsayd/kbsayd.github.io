package com.gym.gymxmjpa.dao;


import com.gym.gymxmjpa.entity.Coach;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

/**
 * @Description: 教练信息Dao层接口
 */
public interface CoachDao extends JpaRepository<Coach,Long>  , JpaSpecificationExecutor<Coach> {
}
