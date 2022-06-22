package com.gym.gymxmjpa.controller;

import com.gym.gymxmjpa.dao.MemberttypeDao;
import com.gym.gymxmjpa.dao.chongzhiDao;
import com.gym.gymxmjpa.entity.Chongzhi;
import com.gym.gymxmjpa.entity.Member;
import com.gym.gymxmjpa.service.MembertypeDaoImpl;
import com.gym.gymxmjpa.entity.Membertype;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

/**
 * @Description: 会员卡类型信息Controller控制层
 */
@Controller
@RequestMapping("/metype")
public class MetypeController {

    @Autowired
    private MembertypeDaoImpl membertypeDaoImpl;
    @Autowired
    private MemberttypeDao memberttypeDao;

    /**
     * @Description: 会员卡类型-删除
     */
    @RequestMapping("/del")
    @ResponseBody
    public  Map<String,Object> del(long typeId,String typeName, int pageSize, int pageNumber){
     memberttypeDao.deleteById(typeId);
     Map<String,Object>  map1=new HashMap<String,Object>();
     map1.put("typeName",typeName);
     map1.put("qi",(pageNumber-1)*pageSize);
     map1.put("shi",pageSize);
     return membertypeDaoImpl.query(map1);
    }

    /**
     * @Description: 会员卡类型-添加会员卡类型
     */
    @RequestMapping("/add")
    @ResponseBody
    public  void save(Membertype membertype){

        memberttypeDao.save(membertype);
    }

    /**
     * @Description: 会员卡类型-根据id查询
     */
    @RequestMapping("/cha")
    @ResponseBody
  /*  public Optional<Membertype> one(long typeId){
        return memberttypeDao.findById(typeId);
    }*/
public  Map<String,Object>  querybyid(int pageSize,int pageNumber, long typeId){
        Map<String,Object> map = new HashMap();
        Pageable pageable=new PageRequest(pageNumber-1,pageSize);
        Specification<Membertype> specification=new Specification<Membertype>() {
            @Override
            public Predicate toPredicate(Root<Membertype> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder)  {
                Predicate predicate =criteriaBuilder.equal( root.get("typeId"),typeId) ;
                return predicate;
            }
        };


        Page<Membertype> list1 =memberttypeDao.findAll(specification,pageable);
        List<Membertype> li = list1.getContent();
        map.put("total",list1.getTotalElements());
        map.put("rows",li);
        return map;

    }


    /**
     * @Description: 会员卡类型-修改会员卡类型信息
     */
    @RequestMapping("/upd")
    @ResponseBody
    public  void upd(Membertype membertype){

        memberttypeDao.save(membertype);
    }

    @RequestMapping("/cha2")
    @ResponseBody

    public Membertype query2(Long id){

        return memberttypeDao.findById(id).get();
    }


}
