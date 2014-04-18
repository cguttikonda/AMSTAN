<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/BusinessCatalog/iListFavGroups.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iListFavGroups_Lables.jsp"%>

<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@ page import="ezc.ezdisplay.*" contentType="text/html; charset=UTF-8" %>

<%
	
	int pageSize = 0;
	String clearSession="";
	try{
		if(request.getParameter("pageSize") != null){
			pageSize = Integer.parseInt(request.getParameter("pageSize"));
		}else{
			pageSize = 5;
		}
	}catch(Exception ex)
	{
		pageSize = 5; 
	}
	
	if(request.getParameter("d-49520-p") != null || request.getParameter("d-49520-o")!=null){
		clearSession = "N";
	}
	
	pageContext.setAttribute("tableclass", "its");
	
		
	if("Y".equals(clearSession)){
		session.removeAttribute("DISOBJ");
	}
	ResultSet rSet = null;
	
	if(retprodfav!=null && retprodfav.getRowCount()>0){
		String rFields[] = new String[]{PROD_GROUP_NUMBER,PROD_GROUP_DESC,PROD_GROUP_WEB_DESC};
		rSet = new ResultSet();
		rSet.addObject(retprodfav,rFields);
		session.setAttribute( "DISOBJ", rSet); 

	}
	
%>	

<html>
<head>
   <title>Display tag</title>
   <meta http-equiv="Expires" content="-1" />
   <meta http-equiv="Pragma" content="no-cache" />
   <meta http-equiv="Cache-Control" content="no-cache" />
   <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
   <style type="text/css" media="all">
          @import url("/CRI/css/maven-base.css");
          @import url("/CRI/css/maven-theme.css");
          @import url("/CRI/css/screen.css");
          
          .inputbox
          	{
          		font-size: 9px;
          		border-right:#00385D 1px inset;
          		border-top: white 1px inset;
          		border-left: white 1px inset;
          		border-bottom: #00385D 1px inset;
          		font-family: verdana, arial
   	}       
   	
   </style>
   <Script src="../../Library/JavaScript/Misc/ezTrim.js"></Script>
   
   <Script>
     function callFun(selOption){
	
	if('N' == selOption){
		document.myForm.action='ezAddGroup.jsp';
		document.myForm.submit();
	}else if('D' == selOption){
		var catalogObj = document.myForm.myCatalog;
		var len = catalogObj.length;
		var selData ="";
		if(isNaN(len)){
			if(catalogObj.checked)
			selData=catalogObj.value;
		}else{
			for(i=0;i<len;i++){
				if(catalogObj[i].checked)
				selData=catalogObj[i].value;
			}
		}
	
		
		if("" != selData){
		
		      if(confirm("Are you sure to delete the catalog ?")){
			var resultText	= selData.split("#");
			document.myForm.favGrp.value = resultText[0];
			document.myForm.action="ezConfirmDelFavNew.jsp";
			document.myForm.submit();
		      }
		}else{
			alert('Please select the catalog to delete');
		}
	}else if('V' == selOption){

		var catalogObj = document.myForm.myCatalog;
		var len = catalogObj.length;
		var selData ="";
		if(isNaN(len)){
			if(catalogObj.checked)
			selData=catalogObj.value;
		}else{
			for(i=0;i<len;i++){
				if(catalogObj[i].checked)
				selData=catalogObj[i].value;
			}
		}
	
		
		if("" != selData){
			var resultText	= selData.split("#");
			document.myForm.favGrp.value = resultText[0];
			
			document.myForm.ProductGroup.value = resultText[0];
			document.myForm.GroupDesc.value = resultText[1];
			//document.myForm.target="_parent"
			document.myForm.action="ezFavGroupFinalLevelDT.jsp";
			document.myForm.submit();
		}else{
			alert('Please select the catalog to view');
		}
	}else if("E" == selOption){
		document.myForm.action="ezGroupDesc.jsp";
		document.myForm.submit();
	}
	
      
     }
     
    
   </Script>
   
   
<link rel="stylesheet" href="./css/print.css" type="text/css" media="print" />
</head>
<body scroll="yes">
<Form name="myForm">
<input type='hidden' name='favGrp'>
<input type='hidden' name='ProductGroup'>
<input type='hidden' name='GroupDesc'>
<input type='hidden' name='onceSubmit' value='1'  >
<input type='hidden' name='personalize' value='Y' >



<center>

<%
	if(rSet!=null && rSet.size()>0){
		String selStr="checked";
		String tableclass = (pageContext.getAttribute("tableclass")).toString();
		ezc.ezdisplay.ResultSetData rsData=null;
		String prodCode ="";
		String prodDesc ="";
		String webDesc  ="";
		
%>
		
		<Div style='wdith:40%'>
		<table border="0" width="100%" cellpadding="0" cellspacing="0" align=center style="border:0" class='blankcell'>
			<tr class='blankcell'>
				<td valign='center' align="left">
					<Strong>
					<a href="JavaScript:callFun('N')"><Font color ='red' >New</a> &nbsp;&nbsp;
					<a href="JavaScript:callFun('V')"><Font color ='red' >View</a> &nbsp;&nbsp;
					<a href="JavaScript:callFun('E')"><Font color ='red' >Edit</a>&nbsp;&nbsp;
					<a href="JavaScript:callFun('D')"><Font color ='red' >Delete</a>
				</td>
				
			</tr>
		</table>
		</Div>
		
		
		<display:table name="sessionScope.DISOBJ"  id="list" pagesize="<%=pageSize%>" class="<%=tableclass%>"> defaultsort="1" defaultorder="descending">
		
<%
		rsData = (ezc.ezdisplay.ResultSetData)pageContext.getAttribute("list");
		
		prodCode =(rsData.getColumn1()).toString();
                prodDesc =(rsData.getColumn2()).toString();
                webDesc =(rsData.getColumn3()).toString();
                
	
%>		
		<display:column  style="width:5%;text-align:left">
		<input type='radio' name ='myCatalog'  <%=selStr%> value='<%=prodCode+"#"+prodDesc+"#"+webDesc%>'>
                </display:column>
                <display:column title="Catalog"     style="width:40%;text-align:left" sortable="true" headerClass="sortable">
		<%=prodDesc%>
		</display:column>
		<display:column title="Description"     style="width:60%;text-align:left" >
		<%=webDesc%>
<%
		selStr="";
%>
		</display:column>
		
		</display:table>
		

<%
	}
	else
	{
		String noDataStatement ="No Favourites present. <BR>Click on New to create favourites";   
		
%>
		<Div style='wdith:40%'>
		<table border="0" width="100%" cellpadding="0" cellspacing="0" align=center style="border:0" class='blankcell'>
			<tr class='blankcell'>
				<td valign='center' align="left">
					<Strong>
					<a href="JavaScript:callFun('N')"><Font color ='red' >New</a> &nbsp;&nbsp;
				</td>
				
			</tr>
		</table>
		</Div>


		<%@ include file="../Misc/ezDisplayNoData.jsp"%> 
<%
	}
%>

</center>
</Form>
</Body>
</Html>