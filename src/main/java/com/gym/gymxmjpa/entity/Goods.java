package com.gym.gymxmjpa.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

/**
 * @Description: 商品信息实体类
 */
@Entity
@Table(name = "goods")
@Getter
@Setter
public class Goods implements java.io.Serializable {
  @Id
  @GeneratedValue(strategy =  GenerationType.IDENTITY)
  private long goodsId;
  private String goodsName;
  private String unit;//单位
  private double unitPrice;//进价
  private double sellPrice;//售价
  private Integer inventory;//库存
  private String remark;//备注

}
