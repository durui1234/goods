<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div style="width:600px; margin:0px auto;">
    <div style="text-align:center">
        <h3>修改员工信息列表</h3>
    </div>
    <div style="text-align:left">
        <form id="updateForm" action="${pageContext.request.contextPath}/update" method="post"
              enctype="multipart/form-data">
            <table width="600" border="1" cellspacing="0" cellpadding="0">
                <tr>
                    <td>员工姓名</td>
                    <td>
                        <input type="text" name="empname" id="empname" value="${emp.empname}"/></td>
                        <input type="hidden" name="empno" id="empno" value="${emp.empno}"/></td>
                </tr>
                <tr>
                    <td>性别</td>
                    <td><input type="radio" name="sex"  value="男"
                               <c:if test="${requestScope.emp.sex=='男'}">checked="checked"</c:if>/>
                        男
                        <input type="radio" name="sex"  value="女"
                               <c:if test="${requestScope.emp.sex=='女'}">checked="checked"</c:if>/>
                        女
                    </td>
                </tr>
                <tr>
                    <td>出生日期</td>
                    <td><input type="text" name="birthday" id="birthday"
                    value='<fmt:formatDate value="${emp.birthday}" pattern="yyyy-MM-dd"></fmt:formatDate>'/></td>
                </tr>
                <tr>
                    <td>部门</td>
                    <td>
                        <select name="deptno" id="deptno">
                            <c:if test="${requestScope.deptList!=null}">
                                <c:forEach items="${requestScope.deptList}" var="dept">
                                    <option value="${dept.deptno}"
                                            <c:if test="${emp.deptno==dept.deptno}">selected="selected"</c:if>>${dept.deptname}</option>
                                </c:forEach>
                            </c:if>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>薪资</td>
                    <td><input type="text" name="sal" id="sal" value="${emp.sal}"/></td>
                </tr>
                <tr>
                    <td>图像</td>
                    <td><input type="file" name="picfile" id="picfile"/>
                        <input type="hidden" name="picpath" id="picpath" value="${emp.picpath}"/>
                        <img width="30%" height="30%" src="/images/${emp.picpath}">
                    </td>

                </tr>
                <tr>
                    <td colspan="2" align="center" valign="middle"><input type="submit" name="btnUpdate" id="btnUpdate"
                                                                          value="修改员工"/>
                        &nbsp;<input type="button" name="btnReturn" id="btnReturn" value="返回"/></td>
                </tr>
            </table>
        </form>
    </div>
</div>
</body>
<script type="application/javascript"
        src="${pageContext.request.contextPath}/js/jquery-1.8.0.min.js"></script>
<script type="application/javascript"
        src="${pageContext.request.contextPath}/js/jquery.form.js"></script>
<script type="application/javascript">
    //图像的操作
    $(function () {
        $("#picfile").change(function () {
            $("#updateForm").ajaxSubmit({
                url:'${pageContext.request.contextPath}/upload',
                type:'post',
                success:function (data) {
                    $("#picpath").val(data);
                    $("img").attr("src","/images/"+data);
                }
            });
        });
    });
</script>
</html>