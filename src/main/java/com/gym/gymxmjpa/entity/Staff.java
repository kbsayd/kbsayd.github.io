package com.gym.gymxmjpa.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

/**
 * @Description: 员工信息实体类
 *
 */
@Entity
@Table(name = "staff")
@Getter
@Setter
public class Staff implements java.io.Serializable {
  @Id
  @GeneratedValue(strategy =  GenerationType.IDENTITY)
  private long staffId;//ID
  private String staffName;//名字
  private String staffPhone;//号码
  private String birthday;//生日
  private long staffSex;//性别
  private long staffAge;//年龄
  private java.sql.Date staffData;//入职时间
  private double staffWages;//员工薪资
  private String staffAddress;//员工地址
  private String staffEmail;//邮箱
  private long work;//工龄
  private long staffStatic;//员工状态


}
