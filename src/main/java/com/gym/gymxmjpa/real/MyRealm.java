package com.gym.gymxmjpa.real;

import com.gym.gymxmjpa.dao.AdminuserDao;
import com.gym.gymxmjpa.entity.Adminuser;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;

public class MyRealm extends AuthorizingRealm {

    @Autowired
    private AdminuserDao adminuserDao;

    //为当前登录的用户授予角色和权限
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        System.out.println("已授权");

        //Subject subject = SecurityUtils.getSubject();
        //Adminuser user = (Adminuser) principalCollection.getPrimaryPrincipal() ;
        String userName = (String)principalCollection.getPrimaryPrincipal();
        //
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo() ;
        info.setRoles(adminuserDao.queryByAdminName(userName));
        info.setStringPermissions(adminuserDao.queryByadminName(userName));
        System.out.println(userName);
        System.out.println(info.getRoles());
        System.out.println(info.getStringPermissions());
        return info;
    }

    //验证当前登录的用户
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {

        UsernamePasswordToken token = (UsernamePasswordToken)authenticationToken ;
        Adminuser adminuser = adminuserDao.findByAdminNameAndAdminPassword(token.getUsername(),String.copyValueOf(token.getPassword()));
        //String userName = (String) authenticationToken.getPrincipal();
        //Adminuser user = adminuserDao.querybyAdminName(userName);
        //if(user!=null){
        //    AuthorizationInfo authorizationInfo=new SimpleAuthorizationInfo(user.getAdminName(),user.getAdminPassword(),"");
        //    return authorizationInfo;
        //}
        if(null == adminuser){
            return null ;
        }

        SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(adminuser.getAdminName(),adminuser.getAdminPassword(),"") ;
        System.out.println("完成认证！");
        return info;
    }
}
