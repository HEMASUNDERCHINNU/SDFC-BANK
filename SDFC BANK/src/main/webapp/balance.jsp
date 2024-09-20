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


out.print(AccountNo+" "+Name+" "+Password);
try
{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","hema","12345");
	PreparedStatement ps=con.prepareStatement(("select amount from sdfcbank where accountnumber=? and name=? and password=?"));
	ps.setInt(1,AccountNo);
	ps.setString(2,Name);
	ps.setString(3,Password);
	
	ResultSet rs=ps.executeQuery();
	ResultSetMetaData r=rs.getMetaData();
	int n=r.getColumnCount();
	out.print("<table border ='1'>");
	for(int j=1;j<=n;j++)
	{
		out.print("<th ><font color=blue>"+r.getColumnName(j)+"</th>");
	}
	while(rs.next()){
	 out.print("<tr>");
		for(int i=1;i<=n;i++){
			
			
				out.print("<td>"+rs.getString(i)+"</td>");
				
		
		}
		out.print("</tr>");
		 
	}
		out.print("</table>");
		out.print("balance successful");

	
	con.close();
}
	catch(Exception ex){
		out.print(ex);
	}
%>

</body>
</html>