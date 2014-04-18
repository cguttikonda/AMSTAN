<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp"%>
<%@ page import ="java.util.*,org.quartz.*,org.quartz.impl.StdSchedulerFactory,org.w3c.dom.*" %>
<%@ include file="../../../Includes/JSPs/WorkFlow/iJobList.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Html>
<Head>
	<Script src="../../Library/JavaScript/ezJobScroll.js"></Script>
	<Script>
		function unscheduleJob(jobname)
		{
			if(confirm("Do you really want to remove this job from schedular"))
			{
				document.myForm.JOBCHK.value=jobname
				document.myForm.submit();
			}	
		}
	</Script>
</Head>
<Body onLoad="scrollInit()" onresize="scrollInit()" scroll="no" >
<Form name=myForm method="post">
<%	
	if(jobCount == 0)
	{
%>
		<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
		<Tr>
			<Th width="100%" align=center>No Jobs Scheduled</Th>
		</Tr>
		</Table>
<%
	}
	else
	{
%>
		<Table  align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
			<Tr class=trClass>
				<Td align=center class=displayheader>List Of Jobs Scheduled</Td>
			</Tr>
		</Table>
		<Div id="theads">
		<Table id="tabHead" align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
			<Tr class=trClass>
				<Th align=center width="40%">Job Name</Th>
				<Th align=center width="45%">Trigger Time</Th>
				<Th align=center width="15%" >&nbsp;</Th>
			</Tr>
		</Table>
		</Div>
		<Div id="InnerBox1Div">
		<Table id="InnerBox1Tab" align=center  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<%
		for(int i=0;i<jobCount;i++)
		{
%>
			<Tr class=trClass>
				<Td align=center width="40%"><%=jobListRet.getFieldValueString(i,"JOB_NAME")%></Td>
				<Td align=center width="45%"><%=jobListRet.getFieldValueString(i,"JOB_TRIGGER_AT")%></Td>
				<Td align=center width="15%"><a href="javascript:unscheduleJob('<%=jobListRet.getFieldValueString(i,"JOB_NAME")%>')">Remove</a></Td>
			</Tr>
<%
		}
%>
		</Table>
		</Div>
<%
	}
%>
<input type=hidden name='JOBCHK'>
</Form>
</Body>
</Html>
