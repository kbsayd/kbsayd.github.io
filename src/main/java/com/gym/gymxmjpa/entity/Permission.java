package com.gym.gymxmjpa.entity;


import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

/**
 * @Description: 角色实体类
 */
@Entity
@Table(name = "permission")
@Getter
@Setter
public class Permission {
  @Id
  @GeneratedValue(strategy =  GenerationType.IDENTITY)
  private long id;
  private String permissionName;
  private long roleId;


}
