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
		function funCreateJob()
		{
			var timeSp  = document.myForm.timeSpan.value;
			var jobType = document.myForm.jobName.value;
			
			if(jobType=="")
			{
				alert("Please select Job Type");
				document.myForm.jobName.focus();
				return;			
			}			
			if(timeSp=="")
			{
				alert("Please enter time span");
				document.myForm.timeSpan.focus();
				return;
			}
			else if(isNaN(timeSp))
			{
				alert("Please enter valid time");
				document.myForm.timeSpan.value="";
				document.myForm.timeSpan.focus();
				return;
			}
			else
			{
				document.myForm.action="ezCreateJob.jsp";
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
		<br><br><br><br>
		<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="50%">
		<Tr>
			<Th width="100%" align=center>No Jobs Scheduled</Th>
		</Tr>
		</Table>
		
		<br><br><br><br>
		<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="50%">
		<Tr>
			<Th width="100%" colSpan=3>Create Periodic Job</Th>
		</Tr>
		<Tr>

			<Td width="25%">

			Select Job Type

			</Td>

			<Td width="25%" colspan=2>
			<select name=jobName>

			<option value=''>--Select Job Type--</option>
			<option value='ezCustSynch'>Customer Synchronization</option>
			<option value='ezMatSynch'>Material Synchronization</option>

			</select>

			</Td>

		</Tr>
		<Tr>
			<Td width="25%">

				Enter Time Span

			</Td>
			<Td width="25%">
				<input class="InputBox" type="text" name="timeSpan" value="" style="width:50%">
			</Td>
			<Td width="25%">
				<a href="javascript:funCreateJob()">Create</a>
			</Td>
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
		
		<br><br><br><br>
		
		
		<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="50%">
		<Tr>
			<Th width="100%" colSpan=3>Create Periodic Job</Th>
		</Tr>
		<Tr>

			<Td width="25%">

			Select Job Type

			</Td>

			<Td width="25%" colspan=2>
			<select name=jobName>

			<option value=''>--Select Job Type--</option>
			<option value='ezCustSynch'>Customer Synchronization</option>
			<option value='ezMatSynch'>Material Synchronization</option>

			</select>

			</Td>

		</Tr>
		<Tr>
			<Td width="25%">

				Enter Time Span

			</Td>
			<Td width="25%">
				<input class="InputBox" type="text" name="timeSpan" value="" style="width:50%">
			</Td>
			<Td width="25%">
				<a href="javascript:funCreateJob()">Create</a>
			</Td>
		</Tr>
		</Table>
		</Div>
<%
	}
%>	
		
<input type=hidden name='JOBCHK'>
</Form>
</Body>
</Html>
