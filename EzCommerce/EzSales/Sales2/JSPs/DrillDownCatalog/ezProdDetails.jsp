<jsp:useBean id="webCatalogObj" class="ezc.client.EzWebCatalogManager" scope="page"></jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%@ page import="ezc.ezparam.*" %>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%
    	String matId       = request.getParameter("matId");
    	String prdCode     = request.getParameter("prdCode");
    	String vendCatalog = request.getParameter("vendCatalog");
    	
    	
    	if(prdCode!=null)
    	prdCode = prdCode.replaceAll("@@@","#");   
    	
    	
    	    	
    	vendCatalog =vendCatalog + " AND EMM_ID = '"+matId+"'";
    	
    	String syskey        = (String)session.getValue("SalesAreaCode");
	ReturnObjFromRetrieve retObj = null;
	EzCatalogParams catalogParams = new ezc.ezparam.EzCatalogParams();
	EzWebCatalogSearchParams searchParams = new EzWebCatalogSearchParams();
	
	searchParams.setSearchType("CP");
	searchParams.setCatalogType("V");
	searchParams.setCatalogCode(vendCatalog); 
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
		catalogNo    =	  retObj.getFieldValueString(0,"EMM_CATALOG_NO");
		brand        =	  retObj.getFieldValueString(0,"EMM_MANUFACTURER");
		uom          =	  retObj.getFieldValueString(0,"EMM_UNIT_OF_MEASURE");
		listPrice    =	  retObj.getFieldValueString(0,"EMM_UNIT_PRICE");
		imgFlag      =	  retObj.getFieldValueString(0,"EMM_IMAGE_FLAG");
		deleteFlag   =	  retObj.getFieldValueString(0,"EMM_DELETION_FLAG");
		availQty     =	  retObj.getFieldValueString(0,"EMM_AVAIL_QUANTITY");
		imgPath      =	  retObj.getFieldValueString(0,"EMM_IMAGE_PATH");
		status       =	  retObj.getFieldValueString(0,"EMM_STATUS");
		family       =	  retObj.getFieldValueString(0,"EMM_FAMILY");
		type         =	  retObj.getFieldValueString(0,"EMM_TYPE");
		color        =	  retObj.getFieldValueString(0,"EMM_COLOR");
		size         =	  retObj.getFieldValueString(0,"EMM_SIZE");
		length       =	  retObj.getFieldValueString(0,"EMM_LENGTH");
		width        =	  retObj.getFieldValueString(0,"EMM_WIDTH");
		finish       =	  retObj.getFieldValueString(0,"EMM_FINISH");
		upcNo        =	  retObj.getFieldValueString(0,"EMM_EAN_UPC_NO");
		spec1        =	  retObj.getFieldValueString(0,"EMD_SPECS1");
		spec2        =	  retObj.getFieldValueString(0,"EMD_SPECS2");
		spec3        =	  retObj.getFieldValueString(0,"EMD_SPECS3");
		spec4        =	  retObj.getFieldValueString(0,"EMD_SPECS4");
	 }
		matNo	  	= (matNo==null || "null".equals(matNo))?"":matNo;
		matDesc   	= (matDesc==null || "null".equals(matDesc))?"":matDesc;
		catalogNo 	= (catalogNo==null || "null".equals(catalogNo))?"":catalogNo ;
		brand     	= (brand==null || "null".equals(brand))?"":brand;
		uom       	= (uom==null || "null".equals(uom))?"":uom;
		listPrice 	= (listPrice==null || "null".equals(listPrice))?"":listPrice;
		imgFlag   	= (imgFlag==null || "null".equals(imgFlag))?"":imgFlag;
		deleteFlag	= (deleteFlag==null || "null".equals(deleteFlag))?"":deleteFlag;
		availQty  	= (availQty==null || "null".equals(availQty))?"":availQty;
		imgPath   	= (imgPath==null || "null".equals(imgPath))?"":imgPath;
		status    	= (status==null || "null".equals(status))?"":status;
		family    	= (family==null || "null".equals(family))?"":family;
		type      	= (type==null || "null".equals(type))?"":type;
		color     	= (color==null || "null".equals(color))?"":color;
		size      	= (size==null || "null".equals(size))?"":size;
		length    	= (length==null || "null".equals(length))?"":length;
		width     	= (width==null || "null".equals(width))?"":width;
		finish    	= (finish==null || "null".equals(finish))?"":finish;
		upcNo     	= (upcNo==null || "null".equals(upcNo))?"":upcNo;
		spec1     	= (spec1==null || "null".equals(spec1))?"":"<a href='/WebStore/CatalogImages/"+spec1+"' target='new'>"+spec1+"</a>";
		spec2     	= (spec2==null || "null".equals(spec2))?"":"<a href='/WebStore/CatalogImages/"+spec2+"' target='new'>"+spec2+"</a>";
		spec3     	= (spec3==null || "null".equals(spec3))?"":"<a href='/WebStore/CatalogImages/"+spec3+"' target='new'>"+spec3+"</a>";
		spec4     	= (spec4==null || "null".equals(spec4))?"":"<a href='/WebStore/CatalogImages/"+spec4+"' target='new'>"+spec4+"</a>";
	
	        try{
			//matNo = ""+Integer.parseInt(matNo); 
		}catch(Exception err){}
	
	
%>

<html>
<head> <title>Product Details</title> 
</head>
<body scroll="yes">
<form>
	<table width="90%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0> 
	<tr>  
		     <th width="100%" colspan=2 align="center">Product details</th>
		     
	</tr> 
	<tr>   
	      <th width="50%" >
		<table width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>
		<tr>  
		     <th width="30%" align="left">Material Code</th>
		     <td width="70%" align="left"><%=matNo%>&nbsp;</td>	
		</tr> 
		<tr>  
		     <th width="30%" align="left">Brand</th>
		     <td width="70%" align="left"><%=brand%>&nbsp;</td>	
		</tr>
		<tr>  
		     <th width="30%" align="left">List Price</th>
		     <td width="70%" align="left">$<%=listPrice%>&nbsp;</td>	
		</tr> 
		<tr>  
		     <th width="30%" align="left">Status</th>
		     <td width="70%" align="left"><%=status%>&nbsp;</td>	
		</tr>
		<tr>  
		     <th width="30%" align="left">Type</th>
		     <td width="70%" align="left"><%=type%>&nbsp;</td>	
		</tr> 
		<tr>  
		     <th width="30%" align="left">Size</th>
		     <td width="70%" align="left"><%=size%>&nbsp;</td>	
		</tr> 
		<tr>  
		     <th width="30%" align="left">Width</th>
		     <td width="70%" align="left"><%=width%>&nbsp;</td>	
		</tr> 
		<tr>  
		     <th width="30%" align="left">Specification1</th>
		     <td width="70%" align="left">    <%=spec1%>&nbsp;</td>	
		</tr> 
		<tr>  
		     <th width="30%" align="left">Specification3</th>
		     <td width="70%" align="left"><%=spec3%>&nbsp;</td>	
		</tr> 
		</table>
	      </th>
	      <th width="50%" >
		<table width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>
		<tr>  
		     <th width="30%" align="left">Description</th>
		     <td width="70%" align="left"><%=matDesc%>&nbsp;</td>	
		</tr> 
		<tr>  
		     <th width="30%" align="left">UOM</th>
		     <td width="70%" align="left"><%=uom%>&nbsp;</td>	
		</tr> 
		<tr>  
		     <th width="30%" align="left">Family</th>
		     <td width="70%" align="left"><%=family%>&nbsp;</td>	
		</tr>
		<tr>  
		     <th width="30%" align="left">Color</th>
		     <td width="70%" align="left"><%=color%>&nbsp;</td>	
		</tr>
		<tr>  
		     <th width="30%" align="left">Length</th>
		     <td width="70%" align="left"><%=length%>&nbsp;</td>	
		</tr>
		<tr>  
		     <th width="30%" align="left">Finish</th>
		     <td width="70%" align="left"><%=finish%>&nbsp;</td>	
		</tr> 
		<tr>  
		     <th width="30%" align="left">UPC No</th>
		     <td width="70%" align="left"><%=upcNo%>&nbsp;</td>	
		</tr> 
		<tr>  
		     <th width="30%" align="left">Specification2</th>
		     <td width="70%" align="left"><%=spec2%>&nbsp;</td>	
		</tr>
		<tr>  
		     <th width="30%" align="left">Specification4</th>
		     <td width="70%" align="left"><%=spec4%>&nbsp;</td>	
		</tr> 

		</table>
	      </th>
	</tr>
	<tr>  
	<td width="100%" colspan=2 align="center" style="background:transparent">
<%                      
	if(imgPath!=null && !"".equals(imgPath))
	{
%>
	     <img src="/WebStore/CatalogImages/<%=imgPath%>" border=none>
<%
	}
	else
	{
%>                        
	   <b> No Image exist</b>
<%
	}
%>	     
	     
	 </td>	
	</tr> 
	
       
	
	</table>
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