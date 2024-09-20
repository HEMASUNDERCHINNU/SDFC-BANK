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
int AccountNo=Integer.parseInt(request.getParameter("Account_No"));
String Name=request.getParameter("uname");
String Password=request.getParameter("PWS");
int TargetAccountNo=Integer.parseInt(request.getParameter("Target Account_No"));
int amount=Integer.parseInt(request.getParameter("Amount"));
int iposition=0;
int total,a;
String submit=request.getParameter("s");
//out.print(AccountNo+" "+Name+" "+Password+" "+amount);
if("Submit".equals(submit)){
	try
	{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","hema","12345");
		
		PreparedStatement ps1 = con.prepareStatement("select * from sdfcbank where accountnumber=? and password=?");
		ps1.setInt(1,AccountNo);
		ps1.setString(2,Password);
		ResultSet r = ps1.executeQuery();

	if(r.next())
	{
		int pre=r.getInt(4);

	if(pre>amount)
	{
	int f = pre-amount;
	PreparedStatement ps2 = con.prepareStatement("update sdfcbank set amount=? where accountnumber=?");
	ps2.setInt(1,f);
	ps2.setInt(2,AccountNo);
	ps2.executeUpdate();
	PreparedStatement ps3 = con.prepareStatement("select * from sdfcbank where accountnumber=? ");
	ps3.setInt(1,TargetAccountNo);
	ResultSet r1=ps3.executeQuery();
	if(r1.next())
	{
		int a1 = r1.getInt(4);
		String n = r1.getString(2);
		int a2 = a1+amount;
		PreparedStatement ps4 = con.prepareStatement("update sdfcbank set amount=? where accountnumber=?");
		ps4.setInt(1,a2);
		ps4.setInt(2,TargetAccountNo);
		ps4.executeUpdate();
		out.print("Previous amount-----"+pre+"<br>");
		out.print("after transfer---"+amount+"<br>");
		out.print(amount+"   transfered to account    " +n);
		con.close();
	}
	}
	}
	con.close();
	}

	catch(Exception e)
	{
	out.print(e);	
	}
}
%>
</body>
</html>