package com.gym.gymxmjpa.controller;


import com.gym.gymxmjpa.service.MenberDaoImpl;
import com.gym.gymxmjpa.dao.MenberDao;
import com.gym.gymxmjpa.entity.Chongzhi;
import com.gym.gymxmjpa.entity.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @Description: 会员充值管理Controller控制层
 */
@Controller
@RequestMapping("/cz")
public class chongzhiController {

    @Autowired
    private com.gym.gymxmjpa.dao.chongzhiDao chongzhiDao;

    @Autowired
    private MenberDao menberDao;

    @Autowired
    private com.gym.gymxmjpa.service.chongzhiservice chongzhiservice;

    @Autowired
    private MenberDaoImpl menberDaoImpl;

    @PersistenceContext
    private EntityManager entityManager;

    /**
     * @Description: 会员充值管理-进入会员充值记录界面
     */
    @RequestMapping("/jin")
    public String jin(){
        return "WEB-INF/jsp/HYMemberjilu";
    }


    /**
     * @Description: 信息统计-进入收入统计界面
     */
    @RequestMapping("/jin2")
    public String jin2(){
        return "WEB-INF/jsp/ShouRuTongji";
    }


    /**
     * @Description: 会员余额充值
     */
    @RequestMapping("/xin")
    @ResponseBody
    public Map<String,Object> cye(Chongzhi chongzhi){

        //充值money
        Member member=menberDao.findById(chongzhi.getMember().getMemberId()).get();
        member.setMemberbalance(member.getMemberbalance()+chongzhi.getMoney());
        menberDao.save(member);

        //添加充值记录
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        java.sql.Timestamp dat=java.sql.Timestamp.valueOf(df.format(new Date()));
        chongzhi.setDate(dat);
        chongzhi.setCzStatic(1L);
        chongzhiDao.save(chongzhi);
        Map<String,Object>  map1=new HashMap<String,Object>();
        map1.put("hyname",null);
        map1.put("ktype",0);
        map1.put("qi",1);
        map1.put("shi",5);
       return menberDaoImpl.query(map1);
   }
    /**
     * @Description: 续费续卡记录分页查询
     */
    @RequestMapping("/query2")
    @ResponseBody
    public Map<String,Object> query( int pageSize, int pageNumber){
        Map<String,Object>  map1=new HashMap<String,Object>();
        map1.put("qi",(pageNumber-1)*pageSize);
        map1.put("shi",pageSize);
        return chongzhiservice.query2(map1);
    }

    /**
     * @Description: 续费续卡记录-根据所选日期分页查询数据记录
     */
    @RequestMapping("/query")
    @ResponseBody
    public Map<String,Object> query(int pageSize,int pageNumber,final String xdate,final String ddate) throws ParseException{
        Map<String,Object> map = new HashMap();
        Pageable pageable=new PageRequest(pageNumber-1,pageSize);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        if(ddate.equals("")){
            final Date startTime = sdf.parse(xdate);
            Specification<Chongzhi> specification=new Specification<Chongzhi>() {
                @Override
                public Predicate toPredicate(Root<Chongzhi> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder)  {
                    Predicate predicate =criteriaBuilder.greaterThanOrEqualTo( root.get("date"),startTime) ;
                    return predicate;
                }
            };
            Page<Chongzhi> list1= chongzhiDao.findAll(specification,pageable);
            List<Chongzhi> li = list1.getContent();
            map.put("total",list1.getTotalElements());
            map.put("rows",li);
            return map;
        }else if(xdate.equals("")){
            final Date endTime = sdf.parse(ddate);
            Specification<Chongzhi> specification=new Specification<Chongzhi>() {
                @Override
                public Predicate toPredicate(Root<Chongzhi> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder)  {
                    Predicate predicate =criteriaBuilder.lessThanOrEqualTo( root.get("date"),endTime) ;
                    return predicate;
                }
            };
            Page<Chongzhi> list1 = chongzhiDao.findAll(specification,pageable);
            List<Chongzhi> li = list1.getContent();
            map.put("total",list1.getTotalElements());
            map.put("rows",li);
            return map;
        }else{
            final Date startTime = sdf.parse(xdate);
            final Date endTime = sdf.parse(ddate);
            Specification<Chongzhi> specification=new Specification<Chongzhi>() {
                @Override
                public Predicate toPredicate(Root<Chongzhi> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder)  {
                    List<Predicate> list=new ArrayList<Predicate>();
                    list.add(criteriaBuilder.between(root.<Date> get("date"),startTime,endTime));
                    return criteriaBuilder.and(list.toArray(new Predicate[list.size()]));
                }
            };
            Page<Chongzhi> list1 = chongzhiDao.findAll(specification,pageable);
            List<Chongzhi> li = list1.getContent();
            map.put("total",list1.getTotalElements());
            map.put("rows",li);
            return map;
        }


   }

    /**
     * @Description: 续费续卡记录-根据name分页查询数据记录
     */
    @RequestMapping("/query3")
    @ResponseBody
    public Map<String,Object> query3( Integer  pageSize,Integer pageNumber, Long id) throws ParseException{
        Map<String,Object>  map1=new HashMap<String,Object>();
        map1.put("qi",(pageNumber-1)*pageSize);
        map1.put("shi",pageSize);
        map1.put("id",id);
        return chongzhiservice.query3(map1);
    }

    /**
     * @Description: 信息统计-进入收入统计界面
     */
    @RequestMapping("/tongji")
    @ResponseBody
    public int[] TOngji(){
        String[] array={"2020-01","2020-02","2020-03","2020-04","2020-05","2020-06","2020-07","2020-08","2020-09","2020-10","2020-11","2020-12"};
        int[] intar=new int[12];
        for (int i=0;i<array.length;i++){
            String jpa="select sum(a.money) from Chongzhi as a where Date like('%"+array[i]+"%')";
            Query query=entityManager.createQuery(jpa);
            Object obj = query.getSingleResult();
            if(obj==null){
            	intar[i]=0;
            }else{
            	intar[i]=((Long)obj).intValue();
            }
        }
        return intar;
   }
    /**
     * @Description: 插入续卡记录
     */
    @RequestMapping("/add")
    @ResponseBody
    @Transactional
    public  int    insert(Chongzhi  cz) {
        chongzhiDao.save(cz);
        return 1;
    }

}
