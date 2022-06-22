package com.gym.gymxmjpa;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.transaction.annotation.EnableTransactionManagement;

/**
 * @Description: 健身房管理系统启动类
 */
@SpringBootApplication
@EnableScheduling//开启定时任务
@EnableTransactionManagement //开启事务支持
public class GymxmjpaApplication {
    public static void main(String[] args) {
        SpringApplication.run(GymxmjpaApplication.class, args);
    }
}
