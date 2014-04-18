<%--***************************************************************
       /* Copyright Notice =====================================*
	* This file contains proprietary information of EzCommerce Inc.
	* Copying or reproduction without prior written approval is prohibited.
	* Copyright (c) 2003-2004 =====================================*/

       /* Author : AmmiReddy.B
	* Team   : Admin
	* Date   : 16-3-2004
	* Copyright (c) 2003-2004 =====================================*/
*****************************************************************--%>
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/EzcLogs/iLogsList.jsp"%>
<Html>
<Head>
	<Title>EzLogs List----Powered by Ezcommerce Global Solutions</Title>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<script src="../../Library/JavaScript/ezTabScroll.js"></script>
	<script src="../../Library/JavaScript/chkEditAndDelete.js"></script>
	<script src="../../Library/JavaScript/EzcLogs/ezLogsList.js"></script>

</Head>
<body onLoad="scrollInit()" scroll=no onResize="scrollInit()">
<Form name=myForm method="post" onSubmit="return go()" >

<%
	if(LogsListCount==0)
	{
%>
		<Div id="tabHead" align=center style="position:absolute;top:40%;width:100%">
			<Table align="center">
				<Tr>
					<Th class=nolabelcell> No Logs To List</Th>
				</Tr>
				<Tr>
					<Th class=nolabelcell>Please Click 'Add' To Add A Log</Th>
				</Tr>
				<Tr>
					<Th class=nolabelcell><input type=image src="../../Images/Buttons/<%=ButtonDir%>/add.gif"  alt="Add" border=no onClick="fun(1)"></Th>
				</Tr>
			</Table>
		</Div>

</Form>
</Body>
</Html>
<%
	return;
	}
	else
	{
%>
		<Br>
		<Table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
			<Tr>
				<Th class="displayheader" align=center>List Of Logs</Th>
			</Tr>
		</Table>
		<Div id="theads">
			<Table id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
				<Tr>
					<Th width="5%"><input type=checkbox name=chkAll onclick="checkAll()"></Th>
					<Th width="14%">Log Number</Th>
					<Th width="12%">UserID</Th>
					<Th width="12%">Sys Key</Th>
					<Th width="12%">SoldTo</Th>
					<Th width="15%">Log Key</Th>
					<Th width="15%">Value</Th>
					<Th width="18%">Time Stamp</Th>

				</Tr>
			</Table>
		</Div>
		<Div id="InnerBox1Div">
			<Table id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
<%
				for(int i=0;i<LogsListCount;i++)
				{
%>
					<Tr>
						<Td align=center width="5%"><Input type=checkbox  name=chk1  value='<%=retLogsList.getFieldValue(i,"LOGNO")%>'></Td>
						<Td width="14%"><Input type="Text"  name="logNumber" class="textInBox" value='<%=retLogsList.getFieldValue(i,"LOGNO")%>' size="12%" readonly></Td>
						<Td width="12%"><Input type="Text" class="textInBox" value='<%=retLogsList.getFieldValue(i,"USERID")%>' size="12%" readonly></Td>
						<Td width="12%"><Input type="Text" class="textInBox" value='<%=retLogsList.getFieldValue(i,"SYSKEY")%>' size="10%" readonly></Td>
						<Td width="12%"><Input type="Text" class="textInBox" value='<%=retLogsList.getFieldValue(i,"SOLDTO")%>'size="12%" readonly></Td>
						<Td width="15%"><Input type="Text" class="textInBox" value='<%=retLogsList.getFieldValue(i,"LOGKEY")%>'size="10%" readonly></Td>
						<Td width="15%"><Input type="Text" class="textInBox" value='<%=retLogsList.getFieldValue(i,"VALUE")%>'size="12%" readonly></Td>

<%
		String timeStamp=retLogsList.getFieldValueString(i,"TIMESTAMP").substring(0,10);
		if(timeStamp!=null)
		{
		java.util.StringTokenizer st=new java.util.StringTokenizer(timeStamp,"-");
		String Year=st.nextToken();
		String Month=st.nextToken();
		String Day=st.nextToken();
		timeStamp=Day+"-"+Month+"-"+Year;
		}
%>


						<Td width="18%" align="center"><Input type="Text" class="textInBox" value='&nbsp;&nbsp;&nbsp;&nbsp;<%=timeStamp%>'size="12%" readonly></Td>

					</Tr>
<%
				}
%>

			</Table>
		</Div>
		<Div id="ButtonDiv" align=center style="position:absolute;top:90%;width:100%">
			<Table border=0 align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width=35%>
				<Tr>
					<Td class="nolabelcell" align=center>
						<a href="javascript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif"  alt="Back" border=no style="cursor:hand"></a>
					</Td>
				</Tr>
			</Table>
		</Div>

<%
		}
%>
</Form>
</Body>
</Html>
