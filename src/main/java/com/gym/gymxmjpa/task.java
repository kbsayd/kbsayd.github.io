package com.gym.gymxmjpa;

import com.gym.gymxmjpa.dao.MenberDao;
import com.gym.gymxmjpa.entity.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashSet;
import java.util.List;

/**
 * @Description
 * @Date 2022/3/5 10:46
 */
@Component
public class task {
    @Autowired
    JavaMailSenderImpl mailSender;

    @Autowired
    private MenberDao menberDao;

    //每天12点
   @Scheduled(cron = "0 0 12 ? * *")
    public void execute() {
        SimpleMailMessage mailMessage = new SimpleMailMessage();
        SimpleDateFormat sdf = new SimpleDateFormat("MM-dd");
        String date = sdf.format(new Date());
        List<Member> list = menberDao.findAll();
        if (list != null && list.size() > 0) {
            for (Member member : list) {
                if (date.equals(member.getBirthday())){
                    //邮件主题
                    mailMessage.setSubject("生日祝福");
                    //邮件内容
                    if (member.getMemberSex()==0){
                        mailMessage.setText("亲爱的"+member.getMemberName()+"女士，祝您生日快乐，身体健康!");
                    }else{
                        mailMessage.setText("亲爱的"+member.getMemberName()+"先生，祝您生日快乐，身体健康!");
                    }
                    //发送到
                    mailMessage.setTo(member.getEmail());
                    //谁发的
                    mailMessage.setFrom("471496316@qq.com");
                    mailSender.send(mailMessage);
                    System.out.println("打印时间" + new Date());
                }
            }
        }


    }



}
