 <%@ page import = "ezc.ezparam.*" %>
 <%@ page import = "java.util.*,java.sql.*" %>
 <jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
 <%
 	String desc = request.getParameter("Desc"); 
 	String busArea = request.getParameter("BusArea"); 
 	String assTo = request.getParameter("AssTo"); 
 	String defGrf = request.getParameter("DefGrf"); 
 	String descRep = request.getParameter("DescRep"); 
 	String repType = request.getParameter("RepType");
 	 	
 	String xaxis = request.getParameter("xaxis"); 
 	String yaxis = request.getParameter("yaxis"); 
 	String prod = request.getParameter("prodgroups"); 
 	String state = request.getParameter("custstate"); 

 	String authKey = "A";
 	int reportId = 123;
 	
 	//Query generation
 	
 	String Query="";
 	String prodQuery="";
 	
 	Query="SELECT "+xaxis+","+yaxis+" FROM EZC_SALES_DOC_HEADER,EZC_SALES_DOC_ITEMS WHERE ESDI_SALES_DOC=ESDH_DOC_NUMBER ";
 	
 	
 	
 	if(prod !=null)
 	{
 		Query=Query +" AND ESDI_MATERIAL_GROUP='"+prod+"'";
 	}
 	
 	if(state !=null )
	{
		Query=Query +" AND ESDH_SOLDTO_STATE='"+state+"'";
 	}
 	
 	
 
 	Query=Query.replaceAll("'","\"");
 	
 	//out.println("Query:::"+Query);
 	
 %>
 
 
 <%
 	Connection con = null;	
 	java.sql.Statement stmt=null;
 	String click="";
 	boolean qryBool=false;
 
 	try
 	{
 		 click="INSERT INTO EZC_ANALYTICAL_REPORT_HEADER VALUES('"+reportId+"','"+desc+"','"+repType+"','"+busArea+"','"+assTo+"','"+authKey+"','"+xaxis+"','"+xaxis+"','"+yaxis+"','"+yaxis+"','"+prod+"','"+state+"','"+repType+"','"+Query+"','"+defGrf+"','"+descRep+"')";
 
 		Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
 		con = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=ezastdev;SelectMethod=cursor","ezastdev","ezastdev");
 
 		stmt = con.createStatement();
 		stmt.executeUpdate(click);
 		qryBool=true;
 		
 		
 	}
 	catch(Exception e) 
 	{
 		
 		e.printStackTrace();
 	}
 	finally
 	{
 		stmt.close();
 		con.close();
 	}
 	
 	//out.println("click:::"+click);
 	
%>

<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>

<script>
	function gotoHome()
	{
		document.myForm.action="../User/ezReportDefnition.jsp";
		document.myForm.submit();
	}
</script>

</head>
<BODY onLoad="scrollInit()" onResize = "scrollInit()" scroll="no">
<form name=myForm method=post>
<div id="ButtonDiv" align="right" style="position:absolute;top:30%;width:50%;left:23%">
<%
if ( qryBool) 
{
%>
	<br>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr align="center">
		<Td class="displayheader">Report Generated Successfully</Td>
	</Tr>
	</Table><br>
	
	
	
<%
}
else
{
%>
	<br>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr align="center">
		<Td class="displayheader">Due to some Technical Issue Report was not Generated Successfully</Td>
	</Tr>
	</Table><br>
<%
}
%>

<Table align="center">
<Tr><Td align=center class="blankcell">
<a href="JavaScript:gotoHome()" style="text-decoration:none"><img src="../../Images/Buttons/<%= ButtonDir%>/ok.gif" border="none" title="Click here to continue"  alt="Click here to continue"  ></a>
</Td></Tr></Table>
</div>

</form>
</body>
</html>
 