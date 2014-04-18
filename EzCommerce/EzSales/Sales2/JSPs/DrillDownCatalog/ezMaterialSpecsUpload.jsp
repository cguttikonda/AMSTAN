<jsp:useBean id="webCatalogObj" class="ezc.client.EzWebCatalogManager" scope="page"></jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%@ page import="ezc.ezparam.*" %>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>


<%
    	//String prdCode = request.getParameter("prdCode");
    	  String prdCode = "110";
    	    	
        String syskey        = (String)session.getValue("SalesAreaCode");
	ReturnObjFromRetrieve retObj = null;
	EzCatalogParams catalogParams = new ezc.ezparam.EzCatalogParams();
	EzWebCatalogSearchParams searchParams = new EzWebCatalogSearchParams();
	
	searchParams.setSearchType("P");
	searchParams.setProductCode(prdCode);

	catalogParams.setSysKey(syskey);
	catalogParams.setLanguage("EN");
	catalogParams.setObject(searchParams);
	Session.prepareParams(catalogParams);

        retObj =(ReturnObjFromRetrieve)webCatalogObj.searchByOptions(catalogParams);
        
       String matNo="",matDesc="",catalogNo="",brand="",uom="",listPrice="",imgFlag="",deleteFlag="",availQty="",imgPath="",status="",family="",type="",color="",size="",length="",width="",finish="",upcNo="",spec1="",spec2="",spec3="",spec4="";
	
	if(retObj!=null){
		matNo	     =	  retObj.getFieldValueString(0,"EMM_NO");
		matDesc      =	  retObj.getFieldValueString(0,"EMD_DESC");
		imgPath      =	  retObj.getFieldValueString(0,"EMM_IMAGE_PATH");
		spec1        =	  retObj.getFieldValueString(0,"EMD_SPECS1");
		spec2        =	  retObj.getFieldValueString(0,"EMD_SPECS2");
		spec3        =	  retObj.getFieldValueString(0,"EMD_SPECS3");
		spec4        =	  retObj.getFieldValueString(0,"EMD_SPECS4");
	   }
	
		matNo	  	= (matNo==null || "null".equals(matNo))?"":matNo;
		matDesc   	= (matDesc==null || "null".equals(matDesc))?"":matDesc;
		imgPath   	= (imgPath==null || "null".equals(imgPath))?"":imgPath;
		spec1     	= (spec1==null || "null".equals(spec1))?"":"<a href='/WebStore/CatalogImages/"+spec1+"' target='new'>"+spec1+"</a>";
		spec2     	= (spec2==null || "null".equals(spec2))?"":"<a href='/WebStore/CatalogImages/"+spec2+"' target='new'>"+spec2+"</a>";
		spec3     	= (spec3==null || "null".equals(spec3))?"":"<a href='/WebStore/CatalogImages/"+spec3+"' target='new'>"+spec3+"</a>";
		spec4     	= (spec4==null || "null".equals(spec4))?"":"<a href='/WebStore/CatalogImages/"+spec4+"' target='new'>"+spec4+"</a>";
	
  	
%>

<html>
<head> <title>Product Details</title> 
<script>
         function funChange()
         {
            alert("In Change function")
         }
</script>

</head>
<body scroll="no">
<form>
	<table width="50%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0> 
	<tr>  
	     <th width="100%" colspan=3 align="center">Product details</th>

	</tr> 
	<tr>  
	     <th width="20%" align="left">Material</th>
	     <td width="30%" align="left" colspan=2><%=matDesc%>(<%=matNo%>)&nbsp; </td>	
	</tr> 
	<tr>  
	     <th width="20%" align="left">Image Path</th>
	     <td width="20%" align="left"><%=imgPath%>&nbsp;</td> 
	     <td width="10%" align="left"><a href='Javascript:funChange()' >Change</a></td>
	     	
	</tr> 
	<tr>  
	     <th width="20%" align="left">Specification1</th>
	     <td width="50%" align="left">    <%=spec1%>&nbsp;</td>	
	</tr> 
	<tr>  
	     <th width="20%" align="left">Specification2</th>
	     <td width="50%" align="left"><%=spec2%>&nbsp;</td>	
	</tr>
	<tr>  
	     <th width="20%" align="left">Specification3</th>
	     <td width="50%" align="left"><%=spec3%>&nbsp;</td>	
	</tr> 
	<tr>  
	     <th width="20%" align="left">Specification4</th>
	     <td width="50%" align="left"><%=spec4%>&nbsp;</td>	
	</tr> 
   
	
	
<br>
	<center>
	<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		buttonName.add("Close");
		buttonMethod.add("window.close()");
		out.println(getButtonStr(buttonName,buttonMethod));
	%>
	</center>
</Div>    

</form>
</body>
</html>