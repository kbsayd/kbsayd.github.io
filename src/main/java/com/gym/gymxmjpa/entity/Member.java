package com.gym.gymxmjpa.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Date;


/**
 * @Description: 会员信息实体类
 */
@Entity
@Table(name = "member")
@Getter
@Setter
public class Member implements Serializable {
  @Id
  @GeneratedValue(strategy =  GenerationType.IDENTITY)
  private long memberId;
  private String memberName;
  private String memberPhone;
  private long memberSex;
  private long memberAge;
  private String birthday;
  private Date nenberDate;
  @ManyToOne
  @JoinColumn(name = "MemberTypes")//[ 'kɔləm ]
  private Membertype membertypes;

  private long memberStatic;

  private float memberbalance;

  private Date Memberxufei;

  private String  email;

}
