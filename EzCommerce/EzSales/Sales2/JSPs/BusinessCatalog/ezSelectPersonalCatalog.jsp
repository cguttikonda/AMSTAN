<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/BusinessCatalog/iListFavGroups.jsp"%>
<html>
<title>Select Personal Catalog</title>
<head>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<script src="../../Library/JavaScript/Misc/ezTrim.js"></script>
<Script>
	var tabHeadWidth=80;
	var tabHeight="60%";  
	
	function funcLoad()
	{
		window.returnValue = ""
	}
	function selCat()
	{
		window.returnValue = document.myForm.perCatalog.value
		window.close()
	
	}
	 	   	  
</Script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
</head>
<body  scroll=no>
<form method="post" onLoad="funcLoad()" name="myForm">
<%
if(retprodfavCount>0)
{
	//out.println(retprodfav.toEzcString());
%>
	<BR><BR>
	<Div id='inputDiv' style='position:relative;align:center;width:80%;left:10%'>
	<Table width="70%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
		<Tr>
			<Td height="5" style="background-color:'DDEEFF'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
			<Td height="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
			<Td height="5" style="background-color:'DDEEFF'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
		</Tr>
	
		<Tr>
			<Td width="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
		<Td style="background-color:'DDEEFF'" valign=middle>
	
		<Table  align=center border=0 valign=middle width="100%" cellPadding=0 cellSpacing=0>
		<Tr align=center>
		<Th>Select Personal Catalog</Th>
		<Td align='center'>
		<select name="perCatalog">
<%	 
		for(int i=0;i<retprodfav.getRowCount();i++)
		{
%>
			<Option value="<%=retprodfav.getFieldValueString(i,"EPG_NO")%>~~<%=retprodfav.getFieldValueString(i,"EPGD_DESC")%>"><%=retprodfav.getFieldValueString(i,"EPGD_WEB_DESC")%></option>
<%
		}
%>
		</select>
		</td>
		</tr>
		</Table>
		</td>
		
		<Td width="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"></Td>
		</Tr>
		<Tr>
			<Td width="5" style="background-color:'DDEEFF'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
			<Td height="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
			<Td width="5" style="background-color:'DDEEFF'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
		</Tr>
	</Table>
	</Div>			
   	<DIV style='overflow:auto;position:absolute;top:86%;left:38%'>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();

	buttonName.add("Ok");
	buttonMethod.add("selCat()");
	buttonName.add("Close");
	buttonMethod.add("window.close()");
		
	out.println(getButtonStr(buttonName,buttonMethod));	
%>

  	</div>   
<%
}
else
{
	String noDataStatement ="No Personal Catalogs present"; 
%>

	<%@ include file="../Misc/ezDisplayNoData.jsp"%> 
   	<DIV style='overflow:auto;position:absolute;top:86%;left:42%'>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();

	buttonName.add("Close");
	buttonMethod.add("window.close()");
		
	out.println(getButtonStr(buttonName,buttonMethod));	
%>

  	</div>   

<%
}
%>
</form>
</body>
</html>