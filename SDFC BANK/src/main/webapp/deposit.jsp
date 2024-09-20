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
double amount=Double.parseDouble(request.getParameter("Amount")); 
int iposition=0;
double a,total;
String submit=request.getParameter("s");
//out.print(AccountNo+" "+Name+" "+Password+" "+amount);
if("Submit".equals(submit)){
try
{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","hema","12345");
	PreparedStatement ps=con.prepareStatement(("select * from sdfcbank where AccountNumber=? and name=? and password=?"));
	ps.setInt(1,AccountNo);
	ps.setString(2,Name);
	ps.setString(3,Password);
	ResultSet rs=ps.executeQuery();
	ResultSetMetaData r=rs.getMetaData();
	int n=r.getColumnCount();
	while(rs.next()){
		for(int i=1;i<=n;i++){
			if(r.getColumnName(i).equalsIgnoreCase("Amount")){
				a=rs.getInt(i);
				total=a+amount;
				PreparedStatement ps1=con.prepareStatement(("update sdfcbank set amount=? where AccountNumber=?"));
				ps1.setDouble(1,total);
				ps1.setInt(2,AccountNo);
				int j=ps1.executeUpdate();
				out.print("Successfully desposited");
			}
		}
	}
	con.close();
}
catch(Exception ex){
	out.println(ex);
}
}

%>
</body>
</html>