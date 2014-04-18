<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<jsp:useBean id="webCatalogObj" class="ezc.client.EzWebCatalogManager" scope="page"></jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%@ page import="ezc.ezparam.*" %>
<%@ page import = "java.util.*" %>

<%
	String syskey        = (String)session.getValue("SalesAreaCode");
	String prodCode      = request.getParameter("search");
	int retObjCount=0;
	String tempPrdCode ="";
	if(prodCode==null || "null".equals(prodCode))
		prodCode = "";
        
        tempPrdCode = prodCode;
        prodCode = "%"+prodCode+"%";
	
	ReturnObjFromRetrieve retObj = null;
	EzCatalogParams catalogParams = new ezc.ezparam.EzCatalogParams();
	EzWebCatalogSearchParams searchParams = new EzWebCatalogSearchParams();
	
	searchParams.setSearchType("GLOBAL");
	searchParams.setProductCode(prodCode);
	catalogParams.setSysKey(syskey);
	catalogParams.setLanguage("EN");
	catalogParams.setObject(searchParams);
	Session.prepareParams(catalogParams);

	retObj =(ReturnObjFromRetrieve)webCatalogObj.searchByOptions(catalogParams);
	
	if(retObj!=null)
		retObjCount = retObj.getRowCount();
	
%>

<html>
<head>
<title>ezListVendorCatalogs</title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>

<Script>
var prodCode ="<%=tempPrdCode%>"
function funShow(catNo,catDesc)
{
   parent.document.getElementById("subDisplay").src="ezCatalogSearchDisplaytag.jsp?ProdDesc1="+prodCode+"&searchType=CP&vendCatalog="+catNo; 
}

</Script>
</head>
<body  scroll=no>
<form method="post" name="myForm">

<%
	if(retObjCount==0){
%>
		<br><br>
		<Table align=center border=0 >
		<TR>
			<Td class=displayalert  colspan="4" align="center"> There were no matching part numbers found.</TD>
		</TR>
		</Table><br><br>
		
<%
		return;
	}
	else if(retObjCount>0){
%>
	
		<table CELLSPACING='8' align="left">
		<tr> 
		    <td style="background:transparent" bgcolor='#003366'> <b><font size = '-1' >Family</font></b></td>
		    <td style="background:transparent" bgcolor='#003366'> <b><font size = '-1' >Total</font></b></td>
		</tr>

		
<%
		String catalogNo 	="";
		String catalogDesc 	="";
		String total            ="";
		

		for ( int i = 0 ; i < retObjCount ; i++ )
		{
			catalogNo 	= retObj.getFieldValueString(i,"EPC_NO");
			catalogDesc 	= retObj.getFieldValueString(i,"EPC_NAME");
			total           = retObj.getFieldValueString(i,2);
			
			catalogDesc=catalogDesc.replace('\"',' ');
			catalogDesc=catalogDesc.replace('\'',' ');
			
%>
		    <tr>
			<td style="background:transparent"><b><font size = '-2' color='blue'>
			<a href = "JavaScript:funShow('<%=catalogNo%>','<%=catalogDesc%>')"><%=catalogDesc%></a></font></b></td>
			<td ALIGN='right' style="background:transparent"><b><font size = '-2' color='blue'><%=total%></font></b></td>
		    </tr>

<%
		}//End for
%>
 		</Table>	
<%
        }
%>



</form>
<Div id="MenuSol"></Div>
</body>
</html>



