<jsp:useBean id="webCatalogObj" class="ezc.client.EzWebCatalogManager" scope="page"></jsp:useBean>   
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%@ page import="ezc.ezcnetconnector.params.*,ezc.ezparam.*" %>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%@ include file="../../../Includes/Lib/ezSpChar.jsp"%> 

<%
	String prodID = enSp(request.getParameter("prodID"));
	String imagePath = enSp(request.getParameter("imagePath"));
	//out.println("imagePathimagePath:::"+imagePath);
	int retDetCnt = 0,retExtCnt = 0;
	
	EzCatalogParams catalogParamsCRI = new ezc.ezparam.EzCatalogParams();  
	EzCustomerItemCatParams ecicCRI = new EzCustomerItemCatParams(); 

	catalogParamsCRI.setType("GET_NON_CNET_PROD_DET");
	ecicCRI.setProdID(prodID);	
	ecicCRI.setQuery("");	
	
	catalogParamsCRI.setObject(ecicCRI);
	catalogParamsCRI.setLocalStore("Y");
	Session.prepareParams(catalogParamsCRI);
	ReturnObjFromRetrieve retDet = (ReturnObjFromRetrieve)webCatalogObj.getCustomerCategories(catalogParamsCRI);
	
	if(retDet!=null && retDet.getRowCount()>0)
		retDetCnt = retDet.getRowCount();
	
	//out.println("retDetretDet::::"+retDet.toEzcString());
%>
<html>
<head> <title>Product Details</title> 
<script>
		  var tabHeadWidth=95
 	   	  var tabHeight="70%"

</script> 
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
</head>
<body onLoad="scrollInit();" onresize="scrollInit()" scroll=no>
<form name="myForm" method="post">

<%

	String noDataStatement ="No details present";  
	if(retDetCnt>0)
	{
%>
	<BR>
	<Div id='theads'>
	<Table  width="95%" id='tabHead' align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	<Tr align="center" valign="middle">
	<Th width="100%" colspan=2 style="text-align:left">Product Specifications</Th>
	</Tr>
	</Table>
	</div>

	<DIV id='InnerBox1Div' style='position:absolute;width:95%;height:90%'>
	<Table id='InnerBox1Tab' width='100%' align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	<Tr>
	<Th style="width:100%;text-align:left" colspan=3>Main Specs</Td>
	</Tr>

			<Tr>
			<Td style="width:20%;height:30;text-align:left"><b>Product Description</b></Td>
			<Td style="width:40%;height:30;text-align:left" ><%=retDet.getFieldValueString(0,"EMD_DESC")%>&nbsp;</Td>

			<Td style="width:40%;height:50;text-align:left" rowspan=4><img src="<%=imagePath%>"></Td>		

			</Tr>
			<Tr>
			<Td style="width:20%;height:30;text-align:left"><b>Color</b></Td>
			<Td style="width:40%;height:30;text-align:left" ><%=retDet.getFieldValueString(0,"EMM_COLOR")%>&nbsp;</Td>			
			</Tr>
			<Tr>
			<Td style="width:20%;height:30;text-align:left"><b>Size</b></Td>
			<Td style="width:40%;height:30;text-align:left" ><%=retDet.getFieldValueString(0,"EMM_SIZE")%>&nbsp;</Td>			
			</Tr>
			<Tr>
			<Td style="width:20%;height:30;text-align:left"><b>Length</b></Td>
			<Td style="width:40%;height:30;text-align:left" ><%=retDet.getFieldValueString(0,"EMM_LENGTH")%>&nbsp;</Td>
			</Tr>
			<Tr>
			<Td style="width:20%;height:30;text-align:left"><b>Width</b></Td>
			<Td style="width:40%;height:30;text-align:left" colspan=2><%=retDet.getFieldValueString(0,"EMM_WIDTH")%>&nbsp;</Td>
			</Tr>			
			<Tr>
			<Td style="width:20%;height:30;text-align:left"><b>UOM</b></Td>
			<Td style="width:40%;height:30;text-align:left" colspan=2><%=retDet.getFieldValueString(0,"EMM_UNIT_OF_MEASURE")%>&nbsp;</Td>
			</Tr>
			<Tr>
			<Td style="width:20%;height:30;text-align:left"><b>Finish</b></Td>
			<Td style="width:40%;height:30;text-align:left" colspan=2><%=retDet.getFieldValueString(0,"EMM_FINISH")%>&nbsp;</Td>
			</Tr>
			<Tr>
			<Td style="width:20%;height:30;text-align:left"><b>Specification 1</b></Td>
			<Td style="width:40%;height:30;text-align:left" colspan=2><%=retDet.getFieldValueString(0,"EMD_SPECS1")%>&nbsp;</Td>
			</Tr>
			<Tr>
			<Td style="width:20%;height:30;text-align:left"><b>Specification 2</b></Td>
			<Td style="width:40%;height:30;text-align:left" colspan=2><%=retDet.getFieldValueString(0,"EMD_SPECS1")%>&nbsp;</Td>
			</Tr>
			<Tr>
			<Td style="width:20%;height:30;text-align:left"><b>Specification 3</b></Td>
			<Td style="width:40%;height:30;text-align:left" colspan=2><%=retDet.getFieldValueString(0,"EMD_SPECS1")%>&nbsp;</Td>
			</Tr>
			<Tr>
			<Td style="width:20%;height:30;text-align:left"><b>Specification 4</b></Td>
			<Td style="width:40%;height:30;text-align:left" colspan=2><%=retDet.getFieldValueString(0,"EMD_SPECS1")%>&nbsp;</Td>
			</Tr>
			<Tr>
			<Td style="width:20%;height:30;text-align:left"><b>Weight</b></Td>
			<Td style="width:40%;height:30;text-align:left" colspan=2><%=retDet.getFieldValueString(0,"EMM_WEIGHT_NUM")%>&nbsp;</Td>
			</Tr>
			<Tr>
			<Td style="width:20%;height:30;text-align:left"><b>Weight UOM</b></Td>
			<Td style="width:40%;height:30;text-align:left" colspan=2><%=retDet.getFieldValueString(0,"EMM_WEIGHT_UOM")%>&nbsp;</Td>
			</Tr>			
	</Table>
	</Div>
<%
	}
	else
	{
%>

	<%@ include file="../Misc/ezDisplayNoData.jsp"%> 

<%
	}
%>

	


<br>	
	
   <DIV style='overflow:auto;position:absolute;top:90%;left:42%'>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Close");
	buttonMethod.add("window.close()");
		
	out.println(getButtonStr(buttonName,buttonMethod));	
%>

  </div>   

</form>
</body>
</html>



<%
/*

retDetretDet::::
 --------------- Row 0 --------------------- 
 0 ::  Field Name : EMM_ID ----> Field Value : 2855 
 0 ::  Field Name : EMM_CATALOG_NO ----> Field Value : 10001 
 0 ::  Field Name : EMM_NO ----> Field Value : 1274382 
 0 ::  Field Name : EMM_MANUFACTURER ----> Field Value : Acc4 
 0 ::  Field Name : EMM_UNIT_OF_MEASURE ----> Field Value : EA 
 0 ::  Field Name : EMM_UNIT_PRICE ----> Field Value : 21.65 
 0 ::  Field Name : EMM_IMAGE_FLAG ----> Field Value : Y 
 0 ::  Field Name : EMM_DELETION_FLAG ----> Field Value : N 
 0 ::  Field Name : EMM_AVAIL_QUANTITY ----> Field Value : 0 
 0 ::  Field Name : EMM_VARIABLE_PRICE_FLAG ----> Field Value : N 
 0 ::  Field Name : EMM_IMAGE_PATH ----> Field Value :  
 0 ::  Field Name : EMM_STATUS ----> Field Value :  
 0 ::  Field Name : EMM_FAMILY ----> Field Value : Accessories 
 0 ::  Field Name : EMM_TYPE ----> Field Value : Accessories 
 0 ::  Field Name : EMM_COLOR ----> Field Value :  
 0 ::  Field Name : EMM_SIZE ----> Field Value :  
 0 ::  Field Name : EMM_LENGTH ----> Field Value :  
 0 ::  Field Name : EMM_WIDTH ----> Field Value :  
 0 ::  Field Name : EMM_FINISH ----> Field Value :  
 0 ::  Field Name : EMM_SPECS ----> Field Value : null 
 0 ::  Field Name : EMM_EXT_NO ----> Field Value :  
 0 ::  Field Name : EMM_EAN_UPC_NO ----> Field Value : 0 95969 07729 3 
 0 ::  Field Name : EMM_CURR_KEY ----> Field Value : null  
 0 ::  Field Name : EMM_FUTURE_PRICE ----> Field Value : 21.65 
 0 ::  Field Name : EMM_EFFECTIVE_DATE ----> Field Value : 1900-01-01 00:00:00.0 
 0 ::  Field Name : EMM_WEIGHT_NUM ----> Field Value : 0.00 
 0 ::  Field Name : EMM_WEIGHT_UOM ----> Field Value :    
 0 ::  Field Name : EMM_LEAD_TIME ----> Field Value : 6 
 0 ::  Field Name : EMM_ID ----> Field Value : 2855 
 0 ::  Field Name : EMM_CATALOG_NO ----> Field Value : 10001 
 0 ::  Field Name : EMM_NO ----> Field Value : 1274382 
 0 ::  Field Name : EMD_LANG ----> Field Value : EN 
 0 ::  Field Name : EMD_DESC ----> Field Value : TEST LEAD SET,PREMIUM DMM 
 0 ::  Field Name : EMD_WEB_DESC ----> Field Value : TEST LEAD SET,PREMIUM DMM 
 0 ::  Field Name : EMD_SPECS1 ----> Field Value :  
 0 ::  Field Name : EMD_SPECS2 ----> Field Value :  
 0 ::  Field Name : EMD_SPECS3 ----> Field Value :  
 0 ::  Field Name : EMD_SPECS4 ----> Field Value :  
 0 ::  Field Name : EMD_EXTERNAL_URL ----> Field Value : 
 --------------- End Of Row 0 -------------- 
 
 */
 %>