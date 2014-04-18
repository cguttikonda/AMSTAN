<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iHolidayCalListWithReason.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<%
	java.util.Hashtable monthsHash = new java.util.Hashtable();
	monthsHash.put("1","January");
	monthsHash.put("2","February");
	monthsHash.put("3","March");
	monthsHash.put("4","April");
	monthsHash.put("5","May");
	monthsHash.put("6","June");
	monthsHash.put("7","July");
	monthsHash.put("8","August");
	monthsHash.put("9","September");
	monthsHash.put("10","October");
	monthsHash.put("11","November");
	monthsHash.put("12","December");
	
	String display_header = "HoliDays List";
	
	int count = 0;
	
	if(listRet!=null)
	{
		count = listRet.getRowCount();
	}	
%>

<Html>
<Head>
<meta name="author"  content="EzWorkbench">

<Script src="../../Library/JavaScript/chkEditAndDelete.js"></Script>
<script src="../../Library/JavaScript/ezCalender.js"></script>

<script>
	var tabHeadWidth=90
	var tabHeight="65%"
</script>
<Script src="../../Library/JavaScript/ezHolidayCalListWithReason.js"></Script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<Script src="../../Library/JavaScript/chkEditAndDelete.js"></Script>
<Script src="../../Library/JavaScript/ezSubmitForm.js"></Script>
<Script src="../../Library/JavaScript/ezSortTableData.js"></Script>
</Head>
<Body onLoad="scrollInit()" onresize="scrollInit()" scroll=no >
<Form name=myForm>
<TABLE align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	<tr>
		<Th width="15%">Add New Holiday</Th>
		<td width="15%"><input type=text name="hldDate"  readonly size=10 maxlength="10"><img src="../../Images/calender.gif" height="20" style="cursor:hand" title="Calendar" onClick=showCal("document.myForm.hldDate",25,300,"<%=cDate%>","<%=cMonth%>","<%=cYear%>")></td>
		<Th width="10%">Reason</Th>
		<td width="50%"><input type=text name="reason"  value="" style="width:100%"></td>
		<td width="10%"><a href='javaScript:save()'><img src="../../Images/Buttons/<%= ButtonDir%>/add.gif"  alt="Save"  border="none"></a></td>   
	</tr>
</table>

<%
	if(count==0)
	{
%>
		<br><br><br><br>
		<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="50%">
		<Tr>
			<Th width="100%" align=center>
			No HoliDays To List
			</Th>
		</Tr>
		</Table>
<%
	}
	else
	{
		String str[] = {"MONTH"};
		boolean b = listRet.sort(str,true);
%>
		<Div id="theads">
		<Table id="tabHead" align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="80%">
		<Tr class=trClass>
			<Th class=thClass align="center" width="5%">&nbsp;</Th>
			<Th class=thClass align="center" width="20%">Day</Th>
			<Th class=thClass align="center" width="20%">Month</Th>
			<Th class=thClass align="center" width="20%">Year</Th>
			<Th class=thClass align="center" width="35%">Reason</Th>
		</Tr>
		</Table>
		</Div>
		<DIV id="InnerBox1Div">
		<Table id="InnerBox1Tab" align=center  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
<%
			for(int i=0;i<listRet.getRowCount();i++)
			{
%>
			<Tr >
				<Td  align=center width="5%">
					<input type=checkbox name=chk1 value="<%=listRet.getFieldValue(i,"ID")%>">
				</Td>
				<%
					String Str = listRet.getFieldValueString(i,"MONTH");
				%>
				<Td  align=left width="20%"><%=listRet.getFieldValue(i,"DAY")%>&nbsp;</Td>
				<Td  align=left width="20%"><%=(String)monthsHash.get(Str)%>&nbsp;</Td>
				<Td  align=left width="20%"><%=listRet.getFieldValue(i,"YEAR")%>&nbsp;</Td>
				<Td  align=left width="35%" title='<%=listRet.getFieldValue(i,"REASON")%>'><input type=text readonly class=DisplayBox value="<%=listRet.getFieldValue(i,"REASON")%>" size=50>&nbsp;</Td>
			</Tr>
<%
			}
%>
		</Table>
		</Div>
		<Div align=center id="ButtonDiv" style="position:absolute;top:92%;width:100%">
			<a href="javascript:deleteDates()"><img src="../../Images/Buttons/<%=ButtonDir%>/delete.gif"  alt="Click Here To Delete" border=no></a>			
		</Div>
<%
	}
%>
</Form>
</Body>
</Html>
	