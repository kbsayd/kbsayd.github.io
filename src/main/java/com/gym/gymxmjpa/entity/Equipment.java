package com.gym.gymxmjpa.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

/**
 * @Description: 设备信息实体类
 */
@Entity
@Table(name = "equipment")
@Getter
@Setter
public class Equipment {
  @Id
  @GeneratedValue(strategy =  GenerationType.IDENTITY)
  private long eqId;
  private String eqName;//名称
  private String eqUnit;//单位
  private long eqNum;//数量
  private String eqRemark;//备注
  private String eqBrand;//品牌
  private long eqPrice;//价格
  private String eqFunction;//功能要求



}
