<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>
<%
	ezc.ezparam.EzcParams deleteMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziActionsParams deleteParams = new ezc.ezworkflow.params.EziActionsParams();
	
	String[] chkValue=request.getParameterValues("chk1");
 
	String val="";
	for(int i=0;i<chkValue.length;i++)
		val += chkValue[i]+",";
 
	val = val.substring(0,val.length()-1);
	deleteParams.setCode(val);

	deleteMainParams.setObject(deleteParams);
	Session.prepareParams(deleteMainParams);
	Object myObj=EzWorkFlowManager.deleteActions(deleteMainParams);
	ReturnObjFromRetrieve obj = null;
	if(myObj instanceof java.util.Vector)
	{
		obj=(ReturnObjFromRetrieve)((java.util.Vector)myObj).elementAt(0);
	}
	else
	{
		obj=(ReturnObjFromRetrieve)myObj;
	}
      

        if(obj!=null && obj.isError())
	{
	      		
%>
		<Html>
		<Head>
		<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
		<meta name="author"  content="EzWorkbench">
		<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
		</Head>
		<Body onLoad="scrollInit()" onresize="scrollInit()" scroll=no >
		<Br>
		<Form name=myForm method="post">
			<Table  align=center cellPadding=2 cellSpacing=0 width="80%">
				<Tr>
					<Td align=center class=blankCell><font color=red><b>Unable to Delete Selected Actions since they have Resultant Statuses</b></font></Td>
				</Tr>
				</Table>
				<Div id="theads">
				<Table id="tabHead" align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="80%">
				<Tr class=trClass>
					<Th class=thClass align=left width="34%">WF Action</Th>
					<Th class=thClass align=left width="33%">Result Status</Th>
					<Th class=thClass align=left width="33%">AuthKey</Th>
					
					
				</Tr>
				</Table>
				</Div>

			<DIV id="InnerBox1Div">
				<Table id="InnerBox1Tab" align=center  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="100%">
		<%
				
					for(int i=0;i<obj.getRowCount();i++)
					{
		%>
					<Tr class=trClass>
						<Td class=tdClass align=left width="34%"><%=obj.getFieldValue(i,"ACTDESC")%></Td>
						<Td class=tdClass align=left width="33%"><%=obj.getFieldValue(i,"STATDESC")%>&nbsp;</Td>
						<Td class=tdClass align=left width="33%"><%=obj.getFieldValue(i,"AUTHDESC")%>&nbsp;</Td>
					</Tr>
		<%
					}
		%>
					</Table>
				</Div>
				<Div align=center id="ButtonDiv" style="position:absolute;top:92%;width:100%">
					<a href="ezActionsList.jsp"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
				</Div>
		</Form>
		</Body>
	</Html>
	
<%      		
		}
		else
		{
			response.sendRedirect("ezActionsList.jsp");	
		}
	


%>
