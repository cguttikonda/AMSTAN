<%@ page import="java.util.*,java.text.*" %>
<%@ include file="../../../Includes/Lib/InboxBean.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<%
	String vendCode = request.getParameter("VENDCODE");
	if(vendCode != null)
	{
		if(vendCode.indexOf("*") != -1)
		{
			vendCode = replaceStr(vendCode,"*","%");
		}
		else
			vendCode = "%"+vendCode+"%";
	}
%>
<%@ include file="../../../Includes/JSPs/Misc/iBannerVendorSearch.jsp" %>
<%
	int retsoldtoCnt = 0;
	if(retsoldto!=null)
		retsoldtoCnt = retsoldto.getRowCount();
%>
<jsp:useBean id="UManager" class="ezc.client.EzUserAdminManager" scope="session" />
<html>
<head>
<Script>
	var tabHeadWidth=90
	var tabHeight="65%"
</Script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<Script>
	function funSubmit()
	{
		var radLen = document.myForm.vendCode.length
		var vendData = ""
		if(!isNaN(radLen))
		{
			for(i=0;i<radLen;i++)
			{
				if(document.myForm.vendCode[i].checked)
				{
					window.returnValue = document.myForm.vendCode[i].value
					break;
				}	
			}	
		}
		else
		{
			window.returnValue = document.myForm.vendCode.value
		}
		window.close()
	}
</Script>
</head
<body onLoad="scrollInit(10)" onresize="scrollInit(10)" scroll=no>
<form name="myForm">
<input type=hidden name='vendArea'>
<%
	if(retsoldtoCnt>0)
	{
%>	
		
<Div id='inputDiv' style='position:relative;align:center;top:5%;width:100%;height:100%'>
<Table width="90%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
<Tr>
	<Td height="5" style="background-color:'F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
	<Td height="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
	<Td height="5" style="background-color:'F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
</Tr>
<Tr height=300px>
	<Td width="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
	<Td style="background-color:'F3F3F3'" valign=middle>
		<Div id="Theads">
			<Table id="tabHead" width='100%' align=center  border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=0>
				<Tr>
					<Th width=7%>&nbsp;&nbsp;</Th>
					<Th width=33%>Code</Th>
					<Th width=60%>Name</Th>
				</Tr>
			</Table>
		</Div>

		<Div id="InnerBox1Div" style="overflow:auto;position:absolute;width:100%;height:90%;">
		<Table  id="InnerBox1Tab" align=center  width=100% border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=0>
<%
		String vcode = "",vname = "",vdata="",selected="";
		for(int i=0;i<retsoldtoCnt;i++)
		{

			if(i == 0)
				selected="checked";
			else	
				selected="";
			vcode = retsoldto.getFieldValueString(i,"EC_ERP_CUST_NO");
			vname = retsoldto.getFieldValueString(i,"ECA_NAME");
			vdata = vcode+"¥"+vname;
%>
			<Tr>
				<Td width=7%><input type=radio name=vendCode value='<%=vdata%>' <%=selected%>></Td>
				<Td width=33%><input type=text value="<%=vcode%>" class="tx"></Td>
				<Td width=60%><input type=text size="35" value="<%=vname%>" class="tx" title="<%=vname%>"></Td>
			</Tr>
<%
		}
%>
		</Table>
		</Div>
		<Div id="ButtonsDiv" align=center style="position:absolute;visibility:visible;width:100%;top:80%">
<%
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();
			buttonName.add("Ok");
			buttonMethod.add("funSubmit()");
			buttonName.add("Close");
			buttonMethod.add("window.close()");
			out.println(getButtonStr(buttonName,buttonMethod));
%>			
		</Div>	
		
	</Td>
	<Td width="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="Cb_e3.gif"></Td>
</Tr>
<Tr>
	<Td width="5" style="background-color:'F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
	<Td height="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
	<Td width="5" style="background-color:'F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
</Tr>
</Table>
</Div>		

<%
	}
	else
	{
		String noDataStatement = "Vendors not found for the given input";
%>		
		<%@ include file="../Misc/ezDisplayNoData.jsp" %>
		<Div id="ButtonsDiv" align=center style="position:absolute;visibility:visible;width:100%;top:90%">
<%
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();
			buttonName.add("Close");
			buttonMethod.add("window.close()");
			out.println(getButtonStr(buttonName,buttonMethod));
%>			
		</Div>
		
<%
	}	
%>
<Div id="MenuSol"></Div>
</body>
</html>


