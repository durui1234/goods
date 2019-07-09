package com.kgc.controller;

import com.github.pagehelper.PageInfo;
import com.kgc.entity.Dept;
import com.kgc.entity.Emp;
import com.kgc.service.DeptService;
import com.kgc.service.EmpService;
import com.kgc.utils.EmpParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;
@Controller
@RequestMapping("/")
public class EmpController {
    @Autowired
    private EmpService empService;
    @Autowired
    private  DeptService deptService;
    @RequestMapping("/index")
    public String index(@RequestParam(value = "pageIndex",defaultValue = "1") Integer pageIndex,
                        @RequestParam(value = "pageSize",defaultValue = "3") Integer pageSize,
                        EmpParam empParam, Model model) {
        PageInfo<Emp> info = empService.getEmpListByPage(pageIndex, pageSize, empParam);
        List<Dept> deptList = deptService.getDeptList();
        model.addAttribute("empParam", empParam);
        model.addAttribute("info", info);
        model.addAttribute("deptList", deptList);
        return "index";
    }
@RequestMapping(value = "/insert",method = RequestMethod.GET)
    public String insert(Model model){
    List<Dept> deptList = deptService.getDeptList();
    model.addAttribute("deptList", deptList);
    return "add";
    }
    @RequestMapping(value = "/upload",method = RequestMethod.POST)
    @ResponseBody
    public String upload(MultipartFile picfile, HttpServletRequest request) throws IOException {
        String filename = picfile.getOriginalFilename();
        String realPath = request.getSession().getServletContext().getRealPath("/images");
        File parent=new File(realPath);
        if (!parent.exists()){
            parent.mkdirs();
        }
        File file=new File(parent,filename);
        picfile.transferTo(file);
        return filename;
    }
    @RequestMapping(value = "/insert",method = RequestMethod.POST,produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String insert(Emp emp){
        if (empService.addEmp(emp)) {
            return "<script>alert('添加成功');location.href='/index'</script>";
        }else {
            return "<script>alert('添加失败');history.go(-1);</script>";
        }
    }
    @RequestMapping(value = "/update/{empno}",method = RequestMethod.GET)
    public String update(@PathVariable("empno")Integer empno, Model model){
        List<Dept> deptList = deptService.getDeptList();
        Emp emp = empService.getEmpById(empno);
        model.addAttribute("deptList", deptList);
        model.addAttribute("emp", emp);
        return "update";
    }
    @RequestMapping(value = "/update",method = RequestMethod.POST,produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String update(Emp emp){
        if (empService.updateEmp(emp)) {
            return "<script>alert('修改成功');location.href='/index'</script>";
        }else {
            return "<script>alert('修改失败');history.go(-1);</script>";
        }
    }
    @RequestMapping(value = "/detail/{empno}",method = RequestMethod.GET)
    public String detail(@PathVariable("empno")Integer empno, Model model){
        Emp emp = empService.getEmpById(empno);
        model.addAttribute("emp", emp);
        return "detail";
    }
    @RequestMapping(value = "/delete/{empno}",method = RequestMethod.GET,produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String delete(@PathVariable("empno") Integer empno){
        if (empService.deleteById(empno)) {
            return "<script>alert('删除成功');location.href='/index'</script>";
        }else {
            return "<script>alert('删除失败');history.go(-1);</script>";
        }
    }
    }


