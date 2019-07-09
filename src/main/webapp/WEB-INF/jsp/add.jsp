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
        <h3>添加员工信息列表</h3>
    </div>
    <div style="text-align:left">
        <form id="insertForm" action="${pageContext.request.contextPath}/insert" method="post"
              enctype="multipart/form-data">
            <table width="600" border="1" cellspacing="0" cellpadding="0">
                <tr>
                    <td>员工姓名</td>
                    <td>
                        <input type="text" name="empname" id="empname"/></td>
                </tr>
                <tr>
                    <td>性别</td>
                    <td><input type="radio" name="sex"  value="男"/>
                        男
                        <input type="radio" name="sex"  value="女"/>
                        女
                    </td>
                </tr>
                <tr>
                    <td>出生日期</td>
                    <td><input type="text" name="birthday" id="birthday"/></td>
                </tr>
                <tr>
                    <td>部门</td>
                    <td>
                        <select name="deptno" id="deptno">
                            <option value="-1">--部门名称--</option>
                            <c:if test="${requestScope.deptList!=null}">
                                <c:forEach items="${requestScope.deptList}" var="dept">
                                    <option value="${dept.deptno}">${dept.deptname}</option>
                                </c:forEach>
                            </c:if>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>薪资</td>
                    <td><input type="text" name="sal" id="sal"/></td>
                </tr>
                <tr>
                    <td>图像</td>
                    <td><input type="file" name="picfile" id="picfile"/>
                        <input type="hidden" name="picpath" id="picpath"/>
                        <img width="30%" height="30%">
                    </td>

                </tr>
                <tr>
                    <td colspan="2" align="center" valign="middle"><input type="submit" name="btnAdd" id="btnAdd"
                                                                          value="添加员工"/>
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
    $(function () {
        $("#picfile").change(function () {
            $("#insertForm").ajaxSubmit({
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