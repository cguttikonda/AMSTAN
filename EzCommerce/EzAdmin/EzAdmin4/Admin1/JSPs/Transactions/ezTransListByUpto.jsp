<%@ page info="transaction" %>
<%!
	String objectId=null;
	java.util.Date d=null;
%>
<%
	ezc.ezparam.ReturnObjFromRetrieve ret=null;
	ezc.eztrans.EzTransaction eztrans=null;
	ezc.eztrans.EzTransactionParams trParams=null;
	try
		{
		objectId=request.getParameter("objectId");
		eztrans=new ezc.eztrans.EzTransaction();
		trParams=new ezc.eztrans.EzTransactionParams();
		 d=new java.util.Date();
		d.setMinutes(d.getMinutes()+10);
		trParams.setUpto(d);
		trParams.setListMode("UPTO");
		ret =eztrans.ezListTrans(trParams);
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
	<Script src="../../Library/JavaScript/ezScrollDefine.js"></script>
	<Script src="../../Library/JavaScript/ezScroll.js"></script>
	<script src="../../Library/JavaScript/chkEditAndDelete.js"></script>
	<script src="../../Library/JavaScript/Transactions/ezTransListByUpto.js"></script>

</HEAD>
<BODY onLoad='scrollInit();" scroll=no() >

<form  name='myForm' onSubmit()="ezTransListBySite.jsp">

<%
	if(ret.getRowCount()==0)
	{
%>	
			<br><br><br><br>
			<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
			<Tr>
			<Th width="100%" align=center>
			<font size=3>
			<b>No Matched Data Found</b>
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
			<Table  align=center width=75% >
			<Tr><Td>
			<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="100%">
			<Tr><Td class="displayheader" align=center>List of Transactions Until  <%=d%></Td></Tr>
			</Table>
				</Td></Tr></Table>
			<div id="theads">
			<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="96%">	
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
				    	    	<Td width=3% align=center><input type=checkbox name='chk1' value='<%=ret.getFieldValue(i,0)%>,<%=ret.getFieldValue(i,1)%>,<%=ret.getFieldValue(i,2)%>'></Td>
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
		     <div id="ScrollBoxDiv" style="position:absolute;top:90%;left:83%;visibility:hidden">
		     <A HREF="javascript:void(0)" onmouseOver="scrolling=1;UpDn='dn'; javascript:scrollMessage(); return false;" onmouseOut="scrolling=0;clearTimeout(timerID)" onClick="javascript:pageUpDnMessage(); return false;">
		     <img name="scrollDn" src="down.gif" border="0" alt="Scroll Down"></a>
		     <A HREF="javascript:void(0)" onmouseOver="scrolling=1;UpDn='up'; javascript:scrollMessage(); return false;" onmouseOut="scrolling=0;clearTimeout(timerID)" onClick="javascript:pageUpDnMessage(); return false;">
		     <img name="scrollUp" src="up.gif" border="0" alt="Scroll Up"></a>
		     </div>	
		<div id="buttons" align = "center" style="position:absolute;top:92%;width:100%">
		<input type=image src="../../Images/Buttons/<%= ButtonDir%>/Deletecenter.gif" border=no  onClick="return funClear()">
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

		</div>	
		
	<%
		
	}	
	%>	

</form>
</BODY>
</HTML>