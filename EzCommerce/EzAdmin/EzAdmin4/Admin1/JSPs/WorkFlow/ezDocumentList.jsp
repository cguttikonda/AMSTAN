<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp" %>


<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>

<Html>
<Head>
<meta name="author"  content="EzWorkbench">
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<Script src="../../Library/JavaScript/ezSortTableData.js"></Script>
</Head>
<Body onLoad="scrollInit();ezInitSorting()" onresize="scrollInit()" scroll=no >
<Br>
<Form name=myForm method="post">
<%
	if(listRet.getRowCount()==0)
	{
%>
		<Center>
		<Br><Br><Span class=nolabelcell> No Documents To List</Span>
		<Br><Br><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

</center>
<%
	}else{
%>
	<Table  align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="80%">
		<Tr class=trClass>
			<Td align=center class=displayheader>Documents List</Td>
		</Tr>
		</Table>
		<Div id="theads">
		<Table id="tabHead" align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="80%">
		<Tr class=trClass>
			<Th class=thClass align=left width="25%" onClick="ezSortElements(0)" style="cursor:hand">Code</Th>
			<Th class=thClass align=left width="25%" onClick="ezSortElements(1)" style="cursor:hand">Description</Th>
			<Th class=thClass align=left width="25%" onClick="ezSortElements(2)" style="cursor:hand">WF Action/Status</Th>
			<Th class=thClass align=left width="25%" onClick="ezSortElements(3)" style="cursor:hand">WF Action/Status</Th>
		</Tr>
		</Table>
		</Div>

	<DIV id="InnerBox1Div">
		<Table id="InnerBox1Tab" align=center  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="100%">
<%
			for(int i=0;i<listRet.getRowCount();i++)
			{
%>
			<Tr class=trClass>
			<Td class=tdClass align=left width="25%"><%=listRet.getFieldValue(i,"CODE")%>&nbsp;</Td>
			<Td class=tdClass align=left width="25%"><%=listRet.getFieldValue(i,"DESCRIPTION")%>&nbsp;</Td>
			<Td class=tdClass align=left width="25%"><%=act%>&nbsp;</Td>
			<Td class=tdClass align=left width="25%"><%=act%>&nbsp;</Td>
	<script>
	//========= Folowing code is for sorting=========================//
		 rowArray=new Array()
		 rowArray[0]= "<%=listRet.getFieldValue(i,"CODE")%>"
		 rowArray[1]= "<%=listRet.getFieldValue(i,"DESCRIPTION")%>"
		 rowArray[2]= "<%=listRet.getFieldValue(i,"STAT_OR_ACTION")%>"
		 rowArray[3]= "<%=listRet.getFieldValue(i,"STAT_OR_ACTION")%>"
		dataArray[<%=i%>]=rowArray
	</script>
			</Tr>
<%
			}
%>
			</Table>
		</Div>
		<Div align=center id="buttonsDiv" style="position:absolute;top:92%;width:100%">
	
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>


			
		</Div>
<%
	}
%>
</Form>
</Body>
</Html>
