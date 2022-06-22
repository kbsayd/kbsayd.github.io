package com.gym.gymxmjpa.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

/**
 * @Description: 课程信息实体类
 */
@Entity
@Table(name = "subject")
@Getter
@Setter
public class Subject {
  @Id
  @GeneratedValue(strategy =  GenerationType.IDENTITY)
  private long subId;
  private String subname;
  private double sellingPrice;


}
