<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Welcome</title>

    <style type="text/css">
        .tg {
            border-collapse: collapse;
            border-spacing: 0;
            border-color: #ccc;
        }

        .tg td {
            font-family: Arial, sans-serif;
            font-size: 14px;
            padding: 10px 5px;
            border-style: solid;
            border-width: 1px;
            overflow: hidden;
            word-break: normal;
            border-color: #ccc;
            color: #333;
            background-color: #fff;
        }

        .tg th {
            font-family: Arial, sans-serif;
            font-size: 14px;
            font-weight: normal;
            padding: 10px 5px;
            border-style: solid;
            border-width: 1px;
            overflow: hidden;
            word-break: normal;
            border-color: #ccc;
            color: #333;
            background-color: #f0f0f0;
        }

        .tg .tg-4eph {
            background-color: #f9f9f9
        }
    </style>

    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container">

    <c:if test="${pageContext.request.userPrincipal.name != null}">
        <form id="logoutForm" method="POST" action="${contextPath}/logout">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>

        <h2>Welcome ${pageContext.request.userPrincipal.name} |<%-- <a href="<c:url value='/edit'/>">Edit profile</a> |--%> <a onclick="document.forms['logoutForm'].submit()">Logout</a>
        </h2>

    </c:if>

</div>
<!-- Searching-->
<c:if test="${empty user.username}">

<form action="/welcome${name}">
    Name:
    <input path="name" type="text" id="name" name="name" placeholder="name"/>
    <br/>
    <br/>
    <input type="submit" value="Search"/>
    <input type="reset" value="Reset" />
    <input type="button" value="All users" onclick="location.href='/'"/>
</form>


<%--<%@ include file="search.jsp"%>--%>


<div>

    <h1>User List<sec:authorize access="hasRole('ROLE_ADMIN')">
        with admin functions.
    </sec:authorize></h1>
    <br>
    <br>
    <%--<c:if test="${!empty listUsers}">--%>
    <table class="tg">
        <tr>
            <th width="80">ID</th>
            <th width="120">First Name</th>
            <th width="120">Second Name</th>
            <th width="120">Username</th>
            <th width="120">E-mail</th>
            <th width="120">Birthday</th>
            <th width="120">Create Date</th>
            <th width="120">Last Update</th>

            <sec:authorize access="hasRole('ROLE_ADMIN')">
            <th width="60">Edit</th>
            <th width="60">Delete</th>
            </sec:authorize>
        </tr>
        <c:forEach items="${listUsers}" var="user">
            <tr>
                <td>${user.id}</td>
                <td>${user.firstName}</td>
                <td>${user.lastName}</td>
                <td>${user.username}</td>
                <td>${user.email}</td>
                <td>${user.birthDay}</td>
                <td>${user.createDate}</td>
                <td>${user.lastUpdated}</td>

                <sec:authorize access="hasRole('ROLE_ADMIN')">
                    <td><a href="<c:url value='/edit/${user.id}'/>">Edit</a></td>
                    <td><a href="<c:url value='/remove/${user.id}'/>">Delete</a></td>
                </sec:authorize>
            </tr>
        </c:forEach>
    </table>
    <%--   </c:if>--%>
</div>


</c:if>
<c:url var="addAction" value="/users/add"/>

<form:form action="${addAction}" commandName="user">
    <table>
        <c:if test="${empty user.username}">
            <h1>Add a new user</h1>
        </c:if>
        <c:if test="${!empty user.username}">
            <a href="../../">Back to main page</a>
            <br/>
            <br/>
            <h1>Edit user</h1>
            <tr>

            <td>
                <form:label path="id">
                    <spring:message text="ID"/>
                </form:label>
            </td>
            <td>
                <form:input path="id" readonly="true" size="8" disabled="true"/>
                <form:hidden path="id"/>
            </td>
            </tr>
            <tr>
                <td>
                    <form:label path="firstName">
                        <spring:message text="First name"/>
                    </form:label>
                </td>
                <td>
                    <form:input path="firstName"/>
                </td>
            </tr
            </tr>
            <tr>
                <td>
                    <form:label path="lastName">
                        <spring:message text="Last name"/>
                    </form:label>
                </td>
                <td>
                    <form:input path="lastName"/>
                </td>
            </tr>

        </c:if>

        <tr>
            <td>
                <form:label path="username">
                    <spring:message text="Username"/>
                </form:label>
            </td>
            <td>
                <form:input path="username"/>
            </td>
        </tr>

        <c:if test="${empty user.username}">

        <tr>
            <td>
                <form:label path="password">
                    <spring:message text="Password"/>
                </form:label>
            </td>
            <td>
                    <form:input path="password"/>

            </td>
        </tr>
        </c:if>
        <c:if test="${!empty user.username}">
            <a href="../../">Back to main page</a>
            <br/>
            <br/>
            <h1>Edit user</h1>
            <tr>
                <td>
                    <form:label path="email">
                        <spring:message text="E-mail"/>
                    </form:label>
                </td>
                <td>
                    <form:input path="email"/>
                </td>
            </tr
            </tr>
            <tr>
                <td>
                    <form:label path="birthDay">
                        <spring:message text="Birthday"/>
                    </form:label>
                </td>
                <td>
                    <form:input path="birthDay"/>
                </td>
            </tr>

        </c:if>


        </tr>
        <c:if test="${!empty user.username}">

        <%--<tr>
            <td>Is Admin :</td>
            <td><form:radiobutton path="isAdmin" value="1" />Admin
                <form:radiobutton path="isAdmin" value="0" />User</td>

        </tr>--%>
        </c:if>
        <tr>
            <td colspan="2">
                <c:if test="${!empty user.username}">
                    <input type="submit"
                           value="<spring:message text="Edit User"/>"/>


                </c:if>
                <c:if test="${empty user.username}">
                    <input type="submit"
                           value="<spring:message text="Add User"/>"/>
                </c:if>
            </td>
        </tr>
    </table>
</form:form>
</body>



<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>