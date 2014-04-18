<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>
<%
	String fd=request.getParameter("fromDate");
	String td=request.getParameter("toDate");
	String WebSysKey= request.getParameter("WebSysKey");
	String fromDate=request.getParameter("fromDate");
	String toDate=request.getParameter("toDate");
%>
<html>
<head>  
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
	<script src="../../Library/JavaScript/Graph1.js"></script>
	<script>
	function getDefaultsFromTo()
	{
		<%if(fd != null && td != null)
		{%>
			

			
			
		<%}
		else
		{%> /////167
			
			toDate = new Date();
			today = toDate.getDate();
			thismonth = toDate.getMonth()+1;
			thisyear = toDate.getYear();
			if(today < 10)
				today = "0"+today;
			if(thismonth < 10)
				thismonth = "0" + thismonth;

		
		document.myForm.fromDate.value = today+"/"+thismonth+"/"+thisyear;
		document.myForm.toDate.value = today +1 +"/"+thismonth+"/"+thisyear;
		<%}
		%>
		for(i=0;i<document.myForm.WebSysKey.options.length;i++)
		{
			if(document.myForm.WebSysKey.options[i].value=="<%=WebSysKey%>")
			{	
				document.myForm.WebSysKey.selectedIndex=i;
				break;
			}
		}

		
	}
	
	function funSubmit()
	{
		document.myForm.action="ezTimeStatsGraph.jsp";
		document.myForm.submit();
	}

	function funShowUsers(hr,users)
	{
		alert("Hello");
		myURL="ezTimeStatsUsers.jsp?Users="+ users +"&Hour=" + hr
		alert(myURL)
		ezWin=window.open(myURL);
	}		
	
	</script>

</head>
<BODY onLoad="getDefaultsFromTo()" >


<form name=myForm method=post>

<input type=hidden name="Area" value=<%=areaFlag%>>
<%
	int sysRows = ret.getRowCount();
	if ( sysRows > 0 ) 
	{
%>
		<Table  width="40%" border="0" align="center">
		<Tr align="center"> 
		    <Th>SBU</Th>
		    <Td width = "40%"><select name="WebSysKey" Style = "width:100%">
			<option value="">All</option>
		     <%
			StringBuffer all=new StringBuffer("");
			for(int i=0;i<ret.getRowCount();i++)
			{
				if(i==0)
				{
					all.append("'" + ret.getFieldValue(i,SYSTEM_KEY) +"'");
				}
				else
				{
					all.append(",");
					all.append("'" + ret.getFieldValue(i,SYSTEM_KEY) +"'");
				}	
				out.println("<option value='" + ret.getFieldValue(i,SYSTEM_KEY) + "'>" + ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION) + "</option>");
			}
		     %>
		     </select>
   		     </Td>
		    <script>
			document.myForm.WebSysKey.options[0].value="<%=all.toString()%>"
		    </script>

		   <Th>From</Th>
		   <Td><input type=text class = "InputBox" name="fromDate" size=10 value="<%=fromDate%>"><img src="../../Images/calender.gif" height="20" style="cursor:hand" onClick=showCal("document.myForm.fromDate")></Td>
		   <Th>To</Th>
		   <Td><input type=text class = "InputBox" name="toDate" size=10 value="<%=toDate%>"><img src="../../Images/calender.gif" height="20" style="cursor:hand" onClick=showCal("document.myForm.toDate")></Td>
		   <Td><img src="../../Images/Buttons/<%= ButtonDir%>/go.gif" height="20" style="cursor:hand" onClick="funSubmit()"></Td>
		  </Tr>
		</Table>
		<%
		if(WebSysKey!=null)
		{
		%>	
			<%@ include file="../../../Includes/JSPs/WebStats/iTimeStats.jsp"%>		
	
			<script>
			var val= new Array();
			<%
				int mTot=0;
				int eTot=0;
				int grandTotal=0;
	
				String s="";
				for(int i=0;i<=23;i++)
				{
		
					 int temp=Integer.parseInt(retWebStats.getFieldValueString(i,"FREQUENCY"));
					if(i<12)
					 	mTot=mTot+temp;
					else
						eTot=eTot+temp;

					grandTotal=grandTotal+temp;
					s=("".equals(s))?String.valueOf(temp):s+"," + String.valueOf(temp);
				
					out.println("val[" +i +"] =" + i );
				}	
			%>			
		
			var g = new Graph(500,200);
			g.addRow(<%=s%>);
			g.scale = 50;
			g.setDate(8,10,1998);
			g.title = "Time";
			g.yLabel="User Frequency "
			g.xLabel="XLABEL ";
			g.rowText(val);
			g.build();
			</SCRIPT>		
		<%
		}
		else
		{
		%>
			<br><br>
		<Table  align=center>
		<Tr>
			<Td>Please Select Syskey, From Date, To Date and press Go to continue.</Td>
		</Tr>
		</Table>
		<%
		}
	}
	else
	{
		out.println("No SBU's to List");
	}
%>
</form>	 
</body>
</html>