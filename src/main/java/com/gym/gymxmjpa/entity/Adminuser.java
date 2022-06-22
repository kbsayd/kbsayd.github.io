package com.gym.gymxmjpa.entity;


import lombok.Getter;
import lombok.Setter;
import javax.persistence.*;

/**
 * @Description: 管理员信息实体类
 */
@Entity
@Table(name = "adminuser")
@Getter
@Setter
public class Adminuser {
  @Id
  @GeneratedValue(strategy =  GenerationType.IDENTITY)
  private long adminId;

  private String adminName;
  private String adminPassword;
  private String adminSalt;
  private String mobile;

  private long roleId;

}
