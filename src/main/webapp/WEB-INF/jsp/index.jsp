<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Title</title>
</head>
<body onload="chanclo()">
<div style="width:980px; margin:0px auto; text-align:center">
    <div style="text-align:center">
        <h3>员工信息列表</h3>
    </div>
    <div style="text-align:center">
        <form id="searchForm"  action="${pageContext.request.contextPath}/index" method="post">
            员工名称：
            <input type="text" name="empname" id="empname" value="${empParam.empname}"/>
                部门:
            <select name="deptno" id="deptno">
                <option value="-1">--部门名称--</option>
                <c:if test="${requestScope.deptList!=null}">
                    <c:forEach items="${requestScope.deptList}" var="dept">
                        <option value="${dept.deptno}"
                        <c:if test="${dept.deptno==empParam.deptno}">selected="selected"</c:if>>${dept.deptname}</option>
                    </c:forEach>
                </c:if>
            </select>&nbsp;&nbsp;
            价格：
            <input name="min_sal" type="text" id="min_sal" size="10" value="${empParam.min_sal}"/>
            到
            <input name="max_sal" type="text" id="max_sal" size="10" value="${empParam.max_sal}"/>
            <input type="hidden" id="pageIndex" name="pageIndex" value="1">
            <input type="submit" name="btnQuery" id="btnQuery" value="查询" />
        </form>
    </div>

    <div style="width:950px; padding-right:30px; line-height:40px; height:40px; text-align:right">
        <a href="${pageContext.request.contextPath}/insert">添加员工</a></div>
    <table width="980" border="1" cellspacing="0" cellpadding="0">
        <tr>
            <td>全选
                <input type="checkbox" name="ckbAll" id="ckbAll" /></td>
            <td>员工编号</td>
            <td>姓名</td>
            <td>性别</td>
            <td>生日</td>
            <td>部门名称</td>
            <td>详细</td>
            <td>删除</td>
            <td>修改</td>
        </tr>
        <c:if test="${requestScope.info!=null}">
            <c:forEach items="${requestScope.info.list}" var="emp">
                <tr>
                    <td><input type="checkbox" name="ckb" id="ckb" /></td>
                    <td>${emp.empno}</td>
                    <td>${emp.empname}</td>
                    <td>${emp.sex}</td>
                    <td><fmt:formatDate value="${emp.birthday}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
                    <td>${emp.dept.deptname}</td>
                    <td><a href="${pageContext.request.contextPath}/detail/${emp.empno}">详细</a></td>
                    <td><a href="javascript:do_delete(${emp.empno})">删除</a></td>
                    <td><a href="${pageContext.request.contextPath}/update/${emp.empno}">修改</a></td>
                </tr>
            </c:forEach>
        </c:if>

        <tr>
            <td colspan="9" align="center" valign="middle">
                <a href="javascript:do_page(1)"> 首页</a>&nbsp;
                <a href="javascript:do_page(${requestScope.info.pageNum-1})">上一页</a>&nbsp;
                <a href="javascript:do_page(${requestScope.info.pageNum+1})"> 下一页</a>&nbsp;
                <a href="javascript:do_page(${requestScope.info.pages})"> 尾页</a>&nbsp;
                ${requestScope.info.pageNum}/${requestScope.info.pages}页<<br>

            </td>
        </tr>
    </table>

</div>
</body>
<script type="application/javascript"
        src="${pageContext.request.contextPath}/js/jquery-1.8.0.min.js"></script>
<script type="application/javascript"
        src="${pageContext.request.contextPath}/js/jquery.form.js"></script>
<script type="application/javascript">
    function do_page(pn) {
        $("#pageIndex").val(pn);
        $("#searchForm").submit();
    }
    function do_delete(empno) {
        var url="${pageContext.request.contextPath}/delete/"+empno;
        if (confirm("确认删除吗?")){
            location.href=url;
        }
    }
    function chanclo() {
//获取标签
        var arr = document.getElementsByTagName("tr");
//for循环实现换色
        for (i = 1; i< arr.length ; i++) {
//如果行数为偶数，背景颜色变为X色
            if (i % 2 == 0) {
                arr[i].style.backgroundColor = "ComflowerBlue";
            }
//如果行数为奇数，背景颜色变为Y色
            else {
                arr[i].style.backgroundColor = "yellow";
            }
        }
    }

</script>
</html>