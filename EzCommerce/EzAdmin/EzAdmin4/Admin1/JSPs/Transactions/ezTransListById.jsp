<%@ page info="transaction" %>
<%!
	String siteId=null;
%>
<%
	ezc.ezparam.ReturnObjFromRetrieve ret=null;
	ezc.eztrans.EzTransaction eztrans=null;
	ezc.eztrans.EzTransactionParams trParams=null;
	try
		{
		siteId=request.getParameter("siteNum");
		if(null!=siteId)
			{
			eztrans=new ezc.eztrans.EzTransaction();

			trParams=new ezc.eztrans.EzTransactionParams();
			trParams.setUserId(siteId.toUpperCase());
			trParams.setListMode("USERID");
			ret =eztrans.ezListTrans(trParams);
			}
		}
	catch(Exception e)
		{
		out.println(e);
		}
%>
<HTML>
<HEAD>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script>
var tabHeadWidth=96
</script>
	<Script src="../../../Library/JavaScript/ezScrollDefine.js"></Script>
	<Script src="../../../Library/JavaScript/ezScroll.js"></Script>
	<script src="../../Library/JavaSacript/chkEditAndDelete.js"></script>
	<script src="../../Library/JavaScript/Transactions/ezTransListById.js"></script>
</HEAD>

<BODY onLoad='scrollInit();document.myForm.siteNum.focus()' scroll=no() >
<br>
<form name=myForm method=post onSubmit()="ezTransListBySite.jsp">
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="50%">
<Tr>
<Th width="100%" align=center>
Enter the UserId<input type=text class = "InputBox" name=siteNum value=""></Th>
<Td><input type=image src="../../Images/Buttons/<%= ButtonDir%>/show.gif" border=no  onClick="return funSubmit()"></Td>

</Tr>
</Table>
<%
	if(null==ret)
	{
%>
<br><br><br><br>
	<center>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr>
	<Th width="100%" align=center>
	Enter The UserId And Click on Show to View The List of Transactions
	</Th>
	</Tr>
	</Table>
	<br>
	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

	</center>
<%
	}
%>

<%	if(null!=siteId)
	{


		if(ret.getRowCount()==0)
		{
		%>
			<br><br><br><br>
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
			<Tr>
			<Th width="100%" align=center>
			<font size=3>
			<b>No Transaction Locks to List</b>
			</font>
			</Th>
			</Tr>
			</Table>
			<br>
			<center>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

			</center>
	<%	}
		else
		{
	%>
			<br><br>

<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
			<Tr><Td class="displayheader" align=center>List of UserId </Td></Tr>
			</Table>

			<div id="theads">
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
			<Tr>
				<Th widht=3%>&nbsp;&nbsp;</Th>
				<Th width=9%>Site</Th>
				<Th width=24%>Object</Th>
				<Th widht=16%>UserId</Th>
				<Th width=10%>KEY</Th>
				<Th width=36%>UPTO</Th>
			</Tr>
			</Table>
			</div>
				<DIV id="OuterBox1Div">
			<DIV id="InnerBox1Div">
			<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="100%">
			<%
					for(int i=0;i<ret.getRowCount();i++)
					{
			%>
				    	    <Tr>
				    	    	<Td width=4% align=center><input type=checkbox name='chk1' value='<%=ret.getFieldValue(i,0)%>,<%=ret.getFieldValue(i,1)%>,<%=ret.getFieldValue(i,2)%>'></Td>
			   		   	<Td width=9% align=center><%=ret.getFieldValue(i,0)%></Td>
			   		   	<Td width=24% align=center><%=ret.getFieldValue(i,1)%></Td>
			   		   	<Td width=16% align=center><%=ret.getFieldValue(i,5)%></Td>
			   		   	<Td width=10% align=center><%=ret.getFieldValue(i,2)%></Td>
			   		   	<Td width=36% align=center><%=ret.getFieldValue(i,4)%></Td>
			   		   </Tr>
			<%
				       }
			%>
				     </Table>
		     </div></div><br>
		     <div id="ScrollBoxDiv" style="position:absolute;top:90%;left:78%;visibility:hidden">
		     <A HREF="javascript:void(0)" onmouseOver="scrolling=1;UpDn='dn'; javascript:scrollMessage(); return false;" onmouseOut="scrolling=0;clearTimeout(timerID)" onClick="javascript:pageUpDnMessage(); return false;">
		     <img name="scrollDn" src="down.gif" border="0" alt="Scroll Down"></a>
		     <A HREF="javascript:void(0)" onmouseOver="scrolling=1;UpDn='up'; javascript:scrollMessage(); return false;" onmouseOut="scrolling=0;clearTimeout(timerID)" onClick="javascript:pageUpDnMessage(); return false;">
		     <img name="scrollUp" src="up.gif" border="0" alt="Scroll Up"></a>
		     </div>
		<div id="buttons" align = "center" style="position:absolute;top:85%;width:100%">
		<input type=image src="../../Images/Buttons/<%= ButtonDir%>/Delete.gif" border=no  onClick="return funClear()">
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

		</div>

	<%
		}
	}
	%>

</form>
</BODY>
</HTML>