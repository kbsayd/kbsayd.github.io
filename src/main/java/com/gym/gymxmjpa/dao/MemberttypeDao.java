package com.gym.gymxmjpa.dao;


import com.gym.gymxmjpa.entity.Member;
import com.gym.gymxmjpa.entity.Membertype;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

/**
 * @Description: 会员卡类型信息Dao层接口
 */
public interface MemberttypeDao extends JpaRepository<Membertype,Long>, JpaSpecificationExecutor<Membertype> {
}
