package com.gym.gymxmjpa.controller;



import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.gym.gymxmjpa.dao.AdminuserDao;
import com.gym.gymxmjpa.entity.Adminuser;
import com.gym.gymxmjpa.entity.Content;
import com.gym.gymxmjpa.utils.Client;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @Description: 管理员登录Controller控制层
 */
@Slf4j
@Controller
@RequestMapping("/")
public class AdminuserConntroller extends HttpServlet {
    @Autowired
    private AdminuserDao adminuserDao;
    @Autowired
    private StringRedisTemplate redisTemplate;
    /**
     * @Description: 输入端口号直接跳转登录界面
     */
    @RequestMapping("/")
    public String beforeLogin(){
        return "login";
    }

  

    /**
     * @Description: 管理员登录验证方法
     */
    @RequestMapping("/dl/yz")
    public String login(String username, String password,String imgCode,String imgCodeKey,HttpSession httpSession,Model model){


        Subject subject= SecurityUtils.getSubject();
        UsernamePasswordToken userToken=new UsernamePasswordToken(username,DigestUtils.md5Hex(password));
        try{
            subject.login(userToken);
            Adminuser a= adminuserDao.findByAdminNameAndAdminPassword(username,DigestUtils.md5Hex(password));
            httpSession.setAttribute("user",a);
            if(imgCode==null||"".equals(imgCode)){
                model.addAttribute("msg","验证码不能为空");
                return "login";
            }
            String cacheCode = redisTemplate.opsForValue().get(imgCodeKey);
            if (null == cacheCode) {
                model.addAttribute("msg","图片验证码已过期，请重新获取");
                return "login";
            }
            if (cacheCode.equals(imgCode)) {
                log.debug("cacheCode: {} ,imgCode : {}", cacheCode, imgCode);
                model.addAttribute("msg","验证码校验正确");
                return "WEB-INF/jsp/index";
            }
            model.addAttribute("msg","验证码输入错误");
            return "login";
        }catch (UnknownAccountException e){
            model.addAttribute("msg","用户名或密码错误,请重新输入");
            return "login";
        }

        /*Adminuser a= adminuserDao.findByAdminNameAndAdminmima(username,password);
        if(a!=null){
            httpSession.setAttribute("user",a);
            return "WEB-INF/jsp/index" ;
        }
        model.addAttribute("mag","账号或密码错误");
        return "login";*/
    }

    /**
     * 注册
     */
    @RequestMapping("/register")
    public Object register(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("userId");
        String password = request.getParameter("password");
        String mobile = request.getParameter("mobile");
        String code = request.getParameter("code");
        JSONObject json = (JSONObject) request.getSession().getAttribute("code");
        if (!json.getString("code").equals(code)) {
            return "验证码错误";
        }
        if ((System.currentTimeMillis() - json.getLong("createTime")) > 1000 * 60 * 5) {
            return "验证码过期";
        }
        Adminuser adminuser=new Adminuser();

        adminuser.setAdminName(userId);
        adminuser.setAdminPassword(DigestUtils.md5Hex(password));
        adminuser.setMobile(mobile);
        adminuser.setRoleId(2);
        adminuserDao.save(adminuser);
        //将用户信息存入数据库
        //这里省略
        return "login";
    }







    /**
     * @Description: 退出登录后清除session
     */
    @RequestMapping("/logout")
    public String logout(){
        Subject subject = SecurityUtils.getSubject();
        subject.logout();
        return "redirect:/login";

    }

    /**
     * @Description: 跳转到修改密码界面
     */
    @RequestMapping("/updPassword")
    public String updPassword(){
        return "WEB-INF/jsp/updPassword";
    }


    /**
     * @Description: 修改密码
     */
    @RequestMapping("/upd/updPassword")
    public String updPasswordConfirm(String oldPassword,String newPassword,String newPasswordAgain,HttpSession httpSession,Model model){
        Pattern p = Pattern.compile("^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!.%*#?&])[A-Za-z\\d$@$!.%*#?&]{8,}$");
        Matcher m = p.matcher(newPassword);
        if(!m.matches()){
            model.addAttribute("msg","新密码最少为8位并为字母+数字+特殊字符");
            return "WEB-INF/jsp/updPassword";
        }
        if(!newPassword.equals(newPasswordAgain)){
            model.addAttribute("msg","两次输入新密码不一致,请重新输入");
            return "WEB-INF/jsp/updPassword";
        }
        Adminuser adminuser=(Adminuser) httpSession.getAttribute("user");
        if(null != adminuser){
            if(!adminuser.getAdminPassword().equals(DigestUtils.md5Hex(oldPassword))){
                model.addAttribute("msg","原密码不正确,请重新输入");
                return "WEB-INF/jsp/updPassword";
            }
            adminuserDao.updPassword(adminuser.getAdminId(), DigestUtils.md5Hex(newPassword));
        }
        Subject subject = SecurityUtils.getSubject();
        subject.logout();
       return "redirect:/login.jsp";
    }

    /**
     * 发送短信验证码
     *
     //* @param number接收手机号码
     */


    @RequestMapping("/sendSms")
    public Object sendSms(HttpServletRequest request) {
        try {
            JSONObject json = null;
            //生成6位验证码
            String code = String.valueOf(new Random().nextInt(8999) + 1000);
            //发送短信
            Subject subject= SecurityUtils.getSubject();


            Client client = new Client();
            client.setAppId("hw_10943");     //开发者ID，在【设置】-【开发设置】中获取
            client.setSecretKey("40a20533b391fb3248da4aa5dc9ad575");    //开发者密钥，在【设置】-【开发设置】中获取
            client.setVersion("1.0");
            Client.Request request1 = new Client.Request();
            request1.setMethod("sms.message.send");
            Content content = new Content();
            //bizContent.setMobile((JSONArray) subject.getSession().getAttribute("mobile"));
            //bizContent.setMobile(json.getJSONArray(request.getParameter("mobile")));

            //request1.setBizContent(
            //        "{\"mobile\":[\"15635964882\"]," +
            //                "\"type\":1," +
            //                "\"template_id\":" +
            //                "\"ST_2022051100000001\"," +
            //                "\"sign\":\"健身房管理系统\"," +
            //                "\"send_time\":\"\"," +
            //                "\"params\":{\"code\":4321}}"
            //);


            JSONArray ja=new JSONArray();
            ja.set(0,"15635964882");
            //bizContent.setMobile(json.getJSONArray(request.getParameter("mobile")));
            content.setMobile(ja);
            content.setType(0);
            content.setTemplate_id("ST_2022051100000001");
            content.setSign("健身房管理系统");
            content.setSend_time(null);
            content.setParams(JSON.parseObject("{code:"+code+"}"));
            JSONObject json1 = new JSONObject();
            String biz=json1.toJSONString(content);
            System.out.println(biz);
            request1.setBizContent(biz);

            //JSONArray js = JSONArray.fromObject(queryOrderParameterDTO);
            //String array = js.toString();
            //System.out.println(array);

            //System.out.println( client.execute(request1) );
            String s = client.execute(request1);
            //String result = client.send(number, "您的验证码为:" + verifyCode + "，该码有效期为5分钟，该码只能使用一次！【短信签名】");
            JSONObject jsonObject = JSONObject.parseObject(s);
            //ResponseCode res = JSONObject.parseObject(String.valueOf(jsonObject), ResponseCode.class);
            //if (res.getCode()!= 0)//发送短信失败
            //    return "fail";
            //将验证码存到session中,同时存入创建时间
            //以json存放，这里使用的是阿里的fastjson
            HttpSession session = request.getSession();
            json = new JSONObject();
            json.put("code", code);
            json.put("createTime", System.currentTimeMillis());
            // 将认证码存入SESSION
            request.getSession().setAttribute("code", json);
            return null;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;


    }

    @RequestMapping("/session")
    @ResponseBody
    public  List session(HttpServletRequest request){
        Subject subject= SecurityUtils.getSubject();
        Session session=subject.getSession();
        List roleList=new ArrayList();
        if(subject.hasRole("admin")){
            roleList.add("admin");
        }
        if(subject.hasRole("user")){
            roleList.add("user");
        }
        return roleList;
    }



}
