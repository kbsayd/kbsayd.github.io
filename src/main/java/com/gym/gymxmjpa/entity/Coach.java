package com.gym.gymxmjpa.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

/**
 * @Description: 教练信息实体类
 */
@Entity
@Table(name = "coach")
@Getter
@Setter
public class Coach implements java.io.Serializable {
  @Id
  @GeneratedValue(strategy =  GenerationType.IDENTITY)
  private long coachId; //教练id
  private String coachName;//教练名字
  private String coachPhone;//教练电话
  private long coachSex;//教练性别
  private long coachAge;//教练年龄
  private java.sql.Date coachData;//教练工作时间
  private long teach;//教龄
  private double coachWages;//教练工资
  private long coachStatic;//教练状态
  private String coachAddress;//教练住址
}
