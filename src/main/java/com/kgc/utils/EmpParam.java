package com.kgc.utils;

public class EmpParam {
    private String empname;
    private Integer deptno;
    private Double min_sal;
    private Double max_sal;

    public String getEmpname() {
        return empname;
    }

    public void setEmpname(String empname) {
        this.empname = empname;
    }

    public Integer getDeptno() {
        return deptno;
    }

    public void setDeptno(Integer deptno) {
        this.deptno = deptno;
    }

    public Double getMin_sal() {
        return min_sal;
    }

    public void setMin_sal(Double min_sal) {
        this.min_sal = min_sal;
    }

    public Double getMax_sal() {
        return max_sal;
    }

    public void setMax_sal(Double max_sal) {
        this.max_sal = max_sal;
    }

    @Override
    public String toString() {
        return "EmpParam{" +
                "empname='" + empname + '\'' +
                ", deptno=" + deptno +
                ", min_sal=" + min_sal +
                ", max_sal=" + max_sal +
                '}';
    }

    public EmpParam() {
    }

    public EmpParam(String empname, Integer deptno, Double min_sal, Double max_sal) {
        this.empname = empname;
        this.deptno = deptno;
        this.min_sal = min_sal;
        this.max_sal = max_sal;
    }
}
