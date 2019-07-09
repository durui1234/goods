package com.kgc.service;

import com.github.pagehelper.PageInfo;
import com.kgc.entity.Emp;
import com.kgc.utils.EmpParam;

public interface EmpService {
    public PageInfo<Emp> getEmpListByPage(Integer pageIndex, Integer pageSize, EmpParam empParam);
    public  Emp getEmpById(Integer empno);
    public boolean addEmp(Emp emp);
    public boolean updateEmp(Emp emp);
    public boolean deleteById(Integer empno);

}
