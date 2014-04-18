<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iBlockControl.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%@ include file="../../../Includes/JSPs/Cnet/iListCnetCategories.jsp"%>
<jsp:useBean id="webCatalogObj" class="ezc.client.EzWebCatalogManager" scope="page"></jsp:useBean>
<%

	
	String uRole =(String)session.getValue("UserRole");
	if("CU".equals(uRole) || "CUSR".equals(uRole))
	{
		java.util.ArrayList selCustCat = new java.util.ArrayList();
		EzCatalogParams catalogParams = new ezc.ezparam.EzCatalogParams();
		EzCustomerItemCatParams ecic = new EzCustomerItemCatParams();

		catalogParams.setType("GET_CUST");
		ecic.setSoldTo((String)session.getValue("AgentCode"));
		catalogParams.setLocalStore("Y");
		catalogParams.setObject(ecic);
		Session.prepareParams(catalogParams);

		ReturnObjFromRetrieve retCustCat =(ReturnObjFromRetrieve)webCatalogObj.getCustomerCategories(catalogParams);

		if(retCustCat!=null && retCustCat.getRowCount()>0)
		{
			for(int k=0;k<retCustCat.getRowCount();k++)
			{
				selCustCat.add(retCustCat.getFieldValueString(k,"ECI_ITEMCAT"));
			}
		}
		if(retCatCnt>0)
		{
			for(int i=retCatCnt-1;i>=0;i--)
			{
				if(!selCustCat.contains(retCat.getFieldValueString(i,"CatID")))
					retCat.deleteRow(i);
			}
			retCatCnt = retCat.getRowCount();
		}
	}	

%>

<html>
<head>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%> 
<script>
	function gottoCat(catID,catDesc)
	{
		document.myForm.action = "ezCnetPrdListByCategoryWait.jsp?categoryID="+catID+"&categoryDesc="+catDesc+"&STYPE=BY_CAT";
		document.myForm.submit()
	
	}
	function search()
	{
		document.myForm.action = "ezCnetSearch.jsp";
		document.myForm.submit()
	}

	function  hideStatus()
	{
	window.status="";
	return true;
	
	}
				
</script> 
</head>

<body scroll="yes">
<form name="myForm" method="post">

<%
	
		
if(retCatCnt>0)
{
%>
	<Div  id="categoriesDiv" style="position:relative;background-color:white;width:95%;height:101%;left:2%;border:1px solid;border-color:lightgrey;padding:0px;">
	<table width="100%" style="background-color:whitesmoke">
	<tr> 
		<td width="100%" style="background-color:#D6D3CE;text-align:left"><b><font size=3>Welcome to American Standard</font></b></td>
		<!--<td width="50%" style="background-color:#D6D3CE;text-align:right"><b><font size=3><a href="javascript:search()">Global Search</a></font></b></td>-->
	</tr>
	</table>
	<table width="100%" style="background-color:whitesmoke">
	<tr>
<%
	String catID = "",catDesc="";
	retCat.sort(new String[]{"Description"},true);
	for(int i=1;i<=retCatCnt;i++)
	{
		catID = retCat.getFieldValueString(i-1,"CatID"); 
		catDesc = retCat.getFieldValueString(i-1,"Description");
		if(catDesc!=null)
		{
			catDesc = replaceString(catDesc,"&","@");
			catDesc = replaceString(catDesc,"'","`");
		}
		
%>
		<td width="33%" style="background-color:whitesmoke"> 
		<% if (!catDesc.equals("Specials")) { %>
		<a href="javascript:gottoCat('<%=catID%>','<%=catDesc%>')" onMouseOver="return hideStatus()"><font style="color:#227A7A"><%=retCat.getFieldValueString(i-1,"Description")%></font></a>		</td>
		<% } else {%>
		<a href="javascript:gottoCat('<%=catID%>','<%=catDesc%>')" onMouseOver="return hideStatus()"><b><font style="color:red"><%=retCat.getFieldValueString(i-1,"Description")%></font></b></a>		</td>
		<% } ;%>
<%
		if(i%3==0 && i!=retCatCnt) 
		{
%>
			</tr>
			<tr>
<%
		}
	}
	if(retCatCnt%3!=0)
	{
		for(int k=0;k<retCatCnt%3;k++)
		{
%>
		<td width="33%" style="background-color:whitesmoke">
		&nbsp;
		</td>
<%
		}
	}
%>
	</tr>
	</table>
	</Div>
	<div style="position:relative"><BR></div>
<%
}else
{
	String noDataStatement = "No categories to list";
%>

	<%@ include file="../Misc/ezDisplayNoData.jsp"%>

<%
}
%>

</form>
</body>
<Div id="MenuSol"></Div>
</html>
