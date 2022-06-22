package com.gym.gymxmjpa.controller;

import com.gym.gymxmjpa.dao.StaffDao;
import com.gym.gymxmjpa.entity.Staff;
import com.gym.gymxmjpa.service.StaffDaoImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

/**
 * @Description: 员工管理Controller控制层
 *
 */
@Controller
@RequestMapping("/staff")
public class StaffController {
   @Autowired
   private StaffDao staffDao;
   //@Autowired
   //private PrivateCoachInfoDao privateCoachInfoDao;
   @Autowired
   private StaffDaoImpl staffDaoImpl;

    /**
     * @Description: 员工管理-进入员工列表界面
     */
    @RequestMapping("/jin3")
    public String jin3(){

        return "WEB-INF/jsp/staff";
    }

    /**
     * @Description: 员工管理-根据员工姓名分页查询
     */
    @RequestMapping("/query")
    @ResponseBody
    public Map<String,Object> query(String staffname, int pageSize, int pageNumber){
        Map<String,Object>  map1=new HashMap<String,Object>();
        map1.put("staffname",staffname);
        map1.put("qi",(pageNumber-1)*pageSize);
        map1.put("shi",pageSize);
        return staffDaoImpl.query(map1);
    }

    /**
     * @Description: 员工管理-根据员工id删除教练信息
     */
    @RequestMapping("/del")
    @ResponseBody
    public  Map<String,Object> del(long id,String staffname, int pageSize, int pageNumber){

        ////先根据教练id在私教信息表里查询是否有其信息
        //List<PrivateCoachInfo> privateCoachInfoList = privateCoachInfoDao.queryByCoachIdNative(id);
        //if(privateCoachInfoList !=null && privateCoachInfoList.size() > 0){
        //    //如果有,先循环删除
        //    for(PrivateCoachInfo privateCoachInfo : privateCoachInfoList){
        //        if(id == privateCoachInfo.getCoach().getCoachId()){
        //            privateCoachInfoDao.delete(privateCoachInfo);
        //        }
        //    }
        //}
        staffDao.deleteById(id);
        Map<String,Object>  map1=new HashMap<String,Object>();
        map1.put("staffname",staffname);
        map1.put("qi",(pageNumber-1)*pageSize);
        map1.put("shi",pageSize);
        return staffDaoImpl.query(map1);
    }

    /**
     * @Description: 员工管理-根据员工姓名计算总数据数量
     */
    @RequestMapping("/count")
    @ResponseBody
    public Long count (String staffName){
        staffDaoImpl.count(staffName);
        return  staffDaoImpl.count(staffName);
    }

    /**
     * @Description: 员工管理-添加新员工
     */
    @RequestMapping("/add")
    @ResponseBody
    public  void save(Staff staff){
        staffDao.save(staff);
    }

    /**
     * @Description: 员工管理-根据员工id查询
     */
    @RequestMapping("/cha")
    @ResponseBody
    public Optional<Staff> one(long id){
        return staffDao.findById(id);
    }

    /**
     * @Description: 员工管理-修改员工信息
     */
    @RequestMapping("/upd")
    @ResponseBody
    public  void upd(Staff staff){
        staffDao.save(staff);
    }


}
