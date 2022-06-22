package com.gym.gymxmjpa.dao;


import com.gym.gymxmjpa.entity.Member;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.Optional;

/**
 * @Description: 会员信息Dao层接口
 */
public interface MenberDao extends JpaRepository<Member,Long>, JpaSpecificationExecutor<Member> {


    Optional<Member> findOne(Specification<Member> specification);


}
