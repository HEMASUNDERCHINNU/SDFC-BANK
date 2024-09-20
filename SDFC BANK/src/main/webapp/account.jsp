<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
int AccountNumber=Integer.parseInt(request.getParameter("AccountNumber"));
String Name=request.getParameter("uname");
String Password=request.getParameter("Pws");
String Confirm_Password=request.getParameter("cPws");
String Address=request.getParameter("Address");
double amount=Double.parseDouble(request.getParameter("amt")); 
Long Mobile_No=Long.parseLong(request.getParameter("Mobile_no"));

out.print(AccountNumber+" "+Name+" "+Password+" "+Confirm_Password+" "+Address+" "+Mobile_No);
try
{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","hema","12345");
	PreparedStatement ps=con.prepareStatement("insert into sdfcbank values(?,?,?,?,?,?,?)");
	ps.setInt(1,AccountNumber);
	ps.setString(2,Name);
	ps.setString(3,Password);
	ps.setString(4,Confirm_Password);
	ps.setDouble(5,amount);
	ps.setString(6,Address);
	ps.setLong(7,Mobile_No);
	
	int i=ps.executeUpdate();
	out.print(i+"account created successful");
	con.close();
}
catch(Exception ex)
{ 
      out.println(ex);
}
%>
</body>
</html>