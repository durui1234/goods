package com.kgc.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.kgc.entity.Dept;
import com.kgc.entity.Emp;
import com.kgc.entity.EmpExample;
import com.kgc.mapper.DeptMapper;
import com.kgc.mapper.EmpMapper;
import com.kgc.service.EmpService;
import com.kgc.utils.EmpParam;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmpServiceImpl implements EmpService {
    @Autowired
    private EmpMapper empMapper;
    @Autowired
    private DeptMapper deptMapper;
    @Override
    public PageInfo<Emp> getEmpListByPage(Integer pageIndex, Integer pageSize, EmpParam empParam) {
        //用来控制查询条件,示例查询
        EmpExample example=new EmpExample();
        example.setOrderByClause("empno");
        //查询容器,放查询条件
        EmpExample.Criteria criteria = example.createCriteria();
        if (empParam!=null){
            if (empParam.getDeptno()!=null&&empParam.getDeptno()!=-1){
                criteria.andDeptnoEqualTo(empParam.getDeptno()
                );
            }
            if (empParam.getEmpname()!=null&&!empParam.getEmpname().equals("")){
                criteria.andEmpnameLike("%"+empParam.getEmpname()+"%");
            }
            if (empParam.getMin_sal()!=null){
                criteria.andSalGreaterThanOrEqualTo(empParam.getMin_sal());
            }
            if (empParam.getMax_sal()!=null){
                criteria.andSalLessThanOrEqualTo(empParam.getMax_sal());
            }
        }
        //pageHelper
        PageHelper.startPage(pageIndex,pageSize);
        //List   (example)带条件的分页
        List<Emp> empList = empMapper.selectByExample(example);
        if (empList!=null&&empList.size()>0){
            for (Emp emp : empList) {
                Integer deptno=emp.getDeptno();
                Dept dept = deptMapper.selectByPrimaryKey(deptno);
                emp.setDept(dept);
            }
        }
        //pageInfo
        PageInfo<Emp> info=new PageInfo<>(empList,5);

        return info;
    }

    @Override
    public Emp getEmpById(Integer empno) {
        Emp emp = empMapper.selectByPrimaryKey(empno);
        if (emp!=null){
            Dept dept = deptMapper.selectByPrimaryKey(emp.getDeptno());
            emp.setDept(dept);
        }
        return emp;
    }

    @Override
    public boolean addEmp(Emp emp) {
        return empMapper.insertSelective(emp)>0?true:false;
    }

    @Override
    public boolean updateEmp(Emp emp) {
        return empMapper.updateByPrimaryKeySelective(emp)>0?true:false;
    }

    @Override
    public boolean deleteById(Integer empno) {
        return empMapper.deleteByPrimaryKey(empno)>0?true:false;
    }
}
