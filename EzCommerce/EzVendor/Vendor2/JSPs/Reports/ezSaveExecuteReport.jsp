<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Reports/iSaveExecuteReport.jsp"%>
<%
	response.setHeader("Pragma", "No-cache");
	response.setDateHeader("Expires", 0);
	response.setHeader("Cache-Control", "no-cache");
%>

<%
	//String FromPage = request.getParameter("FromPage"); 
	//out.println(FromPage);
	String line_H = "There is no output for passed parameters";
if("B".equals(exeType))
{
	ReturnObjFromRetrieve objNo=(ReturnObjFromRetrieve)bexec.getObject("EXECINFO");
	String autoNo = objNo.getFieldValueString(0,"EXECNO");
	response.sendRedirect("ezDisplay.jsp?autoNo="+autoNo);
}else
{
	javax.servlet.ServletOutputStream sos=null;
	int count = -1;
	try
	{
		count = outTable.getRowCount();
		if ( outTable != null )
		{
			for ( int i = 0 ; i < count; i++ )
			{

				String line = outTable.getLine(i);
				if (line.length() == 257)
					line = line.substring(1,line.length()-1);
				else
					line = line.substring(1,line.length());
				if(line!=null && line.indexOf(line_H)!=-1)
				{
%>
		<html>
		<head>
		<script>
		function goBack()
		{
			document.myForm.action  = "../Misc/ezSBUWelcome.jsp";
			document.myForm.submit()
		}
		</script>
		</head>
		<body>
		<form name="myForm">
		<br><br><br><br>
		<Table width="60%" align="center" class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<Tr>
			<Td class=displayalert align=center>
					There is no output for passed parameters
			</Td>		
		</Tr>
		</Table>
		<br>
		<center>
			
<%
  
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();

			buttonName.add("Back");
			buttonMethod.add("goBack()");
			out.println(getButtonStr(buttonName,buttonMethod));	

%>			
		</center>
		</Form>
			<div id="MenuSol" ></Div>
		</body>
		</html>				
<%
		return;

				}
				out.print(line);

			}
		}

	}catch(Exception e)
	{
%>
		<html>
		<head>
		<script>
		function goBack()
		{
			document.myForm.action  = "../Misc/ezSBUWelcome.jsp";
			document.myForm.submit()
		}
		</script>
		</head>
		<body>
		<form name="myForm">
		<br><br><br><br>
		<Table width="60%" align="center" class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<Tr>
			<Td class=displayalert align=center>
					There is no output for passed parameters
			</Td>		
		</Tr>
		</Table>
		<br>
		<center>
			<!-- <a href='JavaScript:goBack()'><img src="../../Images/Buttons/English/Green/back.gif" border="none"></a> -->
<%
  
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();

			buttonName.add("Back");
			buttonMethod.add("goBack()");
			out.println(getButtonStr(buttonName,buttonMethod));	

%>			
		</center>
		</Form>
			<div id="MenuSol" ></Div>
		</body>
		</html>
<%	

		//out.println("<br><br><br><br><Center><h3> There is no output for passed    parameters </h3></Center>");
		//response.sendRedirect("../Htmls/Error.htm");
	}

		// Added by Venkat Sanampudi
	if(count == 0)
	{
%>

		<html>
		<head>
		<script>
		function goBack()
		{
			document.myForm.action  = "../Misc/ezSBUWelcome.jsp";
			document.myForm.submit()
		}
		</script>
		</head>
		<body>
		<form name="myForm">
		<br><br><br><br>
		<Table width="60%" align="center" class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
			<Tr>
			<Td class=displayalert align=center>
				There is no output for passed parameters
			</Td>	
			</Tr>
		</Table>
		<br>
		<center>
			<!-- <a href='JavaScript:goBack()'><img src="../../Images/Buttons/English/Green/back.gif" border="none"></a> -->
<%
  
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();

			buttonName.add("Back");
			buttonMethod.add("goBack()");
			out.println(getButtonStr(buttonName,buttonMethod));	

%>			
		</center>
		</Form>
			<div id="MenuSol" ></Div>
		</body>
		</html>
<%		//out.println("<br><br><br><br><Center><h3> There is no output for passed parameters </h3></Center>");
		}
	}
%>


<Div id="MenuSol" style="width:0%;height:0%;visibility:hidden">&nbsp;</Div>