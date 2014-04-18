<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="EzCatalogManager" class="ezc.client.EzCatalogManager"/>
<jsp:useBean id="webCatalogObj" class="ezc.client.EzWebCatalogManager" scope="page"></jsp:useBean>
<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "java.util.*" %>

<%

    String selOpt=request.getParameter("selOpt");
    String addProduct=request.getParameter("addProduct");
    String FavGroup=request.getParameter("FavGroup");
    String GroupDesc=request.getParameter("GroupDesc");
    
    String dispStr="";
    
    if("IN".equals(selOpt))
          dispStr="Product ID";
    else if("ID".equals(selOpt))
          dispStr="Product Description";
          
    
    EzCatalogParams ezcpparams = new EzCatalogParams();
    ReturnObjFromRetrieve retcat = null;
    int retCatCount=0;
    
    if("AS".equals(selOpt))
    {
       Session.prepareParams(ezcpparams);
       ezcpparams.setLanguage("EN");
       retcat = (ReturnObjFromRetrieve)EzCatalogManager.getCatalogList(ezcpparams);
       retcat.check();
       
       if(retcat!=null){
       	retCatCount= retcat.getRowCount();
       }
       
       if(retCatCount> 0){
          String sortField[]={"EPC_NAME"};
          retcat.sort(sortField,true);
       }

    }  
    
	String subStr        = request.getParameter("submitStr");
	ReturnObjFromRetrieve retObj = null;
	EzCatalogParams catalogParams = new ezc.ezparam.EzCatalogParams();
	EzWebCatalogSearchParams searchParams = new EzWebCatalogSearchParams();
	
	String syskey        = (String)session.getValue("SalesAreaCode");
	String prodCode      = "";
	int retObjCount=0;
	String tempPrdCode ="";
        
     	if(subStr!=null && !"null".equals(subStr) && "Y".equals(subStr))
    	{
    		prodCode      = request.getParameter("search");
    			
    		if(prodCode==null || "null".equals(prodCode))
    			prodCode = "";
            
           	 tempPrdCode = prodCode;
            	 prodCode = "%"+prodCode+"%";
    	
    	    	searchParams.setSearchType("GLOBAL");
    		searchParams.setProductCode(prodCode);
    		catalogParams.setSysKey(syskey);
    		catalogParams.setLanguage("EN");
    		catalogParams.setObject(searchParams);
    		Session.prepareParams(catalogParams);
    
    		retObj =(ReturnObjFromRetrieve)webCatalogObj.searchByOptions(catalogParams);
    	
    		if(retObj!=null)
    			retObjCount = retObj.getRowCount();	
    }

    
%>

<HTML>
<HEAD>
<script>
        var req;
        var addProduct='<%=addProduct%>'
        var FavGroup='<%=FavGroup%>'
        var GroupDesc='<%=GroupDesc%>'
        var prodCode ="<%=tempPrdCode%>"
        var catType  ="V";
        
	function funShow(catNo,catDesc)
	{
	   var catStr = catNo+"$$"+catDesc+"$$"+catType;
	   
	   prodCode = prodCode.replace('#','@@@');  	   
	   
	   if(addProduct=='Y')
		 parent.document.getElementById("subDisplay").src="ezAddProductsToFav.jsp?gProdStr="+prodCode+"&searchType=GCP&catalogStr="+catStr+"&FavGroup="+FavGroup+"&GroupDesc="+GroupDesc;
           else    
                 parent.document.getElementById("subDisplay").src="ezCatalogSearchDisplaytag.jsp?gProdStr="+prodCode+"&searchType=GCP&catalogStr="+catStr; 
	}

        
	function Initialize()
	{
		try
		{
		        req = new ActiveXObject("Msxml2.XMLHTTP");
		}
		catch(e)
		{
			try
			{
				req = new ActiveXObject("Microsoft.XMLHTTP");
			}
			catch(oc)
			{
				req = null;
			}
		}
		if(! req&&typeof XMLHttpRequest != "undefined")
		{
			req = new XMLHttpRequest();
		}
	}
	function SendQuery(id)
	{
		try
		{
			req = new ActiveXObject("Msxml2.XMLHTTP");
		}
		catch(e)
		{
			try
			{
				req = new ActiveXObject("Microsoft.XMLHTTP");
			}
			catch(oc)
			{
				req = null;
			}
		}
		if(!req&&typeof XMLHttpRequest!="undefined")
		{
			req = new XMLHttpRequest();
		}
	
		        var url=location.protocol+"//<%=request.getServerName()%>/j2ee/EzCommerce/EzSales/Sales2/JSPs/DrillDownCatalog/ezAjaxBrandNameList.jsp";
			//url=location.protocol+"//<%=request.getServerName()%>/j2ee/EzCommerce/EzSales/Sales2/JSPs/ShoppingCart/ezAjaxAddCartNew.jsp?product="+product.value+"&quantity="+quantity.value+"&catalog="+catalog.value;
		
		        alert(url)
		if(req!=null)
		{
			req.onreadystatechange = Process;
			req.open("GET", url, true);
			req.send(null);
		}

	}
	function Process()
	{
		if (req.readyState == 4)
		{
			var resText = req.responseText;	 	        	
			var resultText	= resText.split("¥");

			if (req.status == 200)
			{
				alert("success")
			}
			else
			{
				if(req.status == 500)	
				alert("Error");
			}

		}
	}
         
         var selOpt="<%=selOpt%>";
      
         function funsearch()
         {     
             var searchObj = document.myForm.search
             var searchVal = searchObj.value
             
             if(searchObj.value==""){
                alert("Please enter the search data")
                searchObj.focus();
                return ;
             }
             else{  
                   //if(addProduct=='Y')
               		 // parent.document.getElementById("subDisplay").src="ezAddProductsToFav.jsp?searchStr="+searchVal+"&searchType="+selOpt+"&FavGroup="+FavGroup+"&GroupDesc="+GroupDesc;
                   //else{
                       document.myForm.action="ezSearchOptions.jsp";
                       document.myForm.submit(); 
                   //}
             }
         }
         function funAdvSearch()
         {
           var catalogObj = document.myForm.venCatalog
           var itemNoObj     = document.myForm.itemNo
           var itemDescObj   = document.myForm.itemDesc
           
           if(catalogObj.value=="-"){
              alert("Please select vendor catalog")
              catalogObj.focus();
              return ;
           }
           else if(itemNoObj.value==""){
	      alert("Please enter item number")
	      itemNoObj.focus();
	      return ;
           }
           else if(itemDescObj.value==""){
	      alert("Please enter item description")
	      itemDescObj.focus();
	      return ;
           }
           
           var selCatalog = catalogObj.value;
           var res = selCatalog.split("¥");
           
           var catStr = res[0]+"$$"+res[1]+"$$"+catType;
           var itemNoTemp = itemNoObj.value;
           
           itemNoTemp = itemNoTemp.replace('#','@@@');  
           
           if(addProduct=='Y') 
	           parent.document.getElementById("subDisplay").src="ezAddProductsToFav.jsp?searchType="+selOpt+"&FavGroup="+FavGroup+"&GroupDesc="+GroupDesc+"&vendCatalog="+res[0]+"&itemNo="+itemNoTemp+"&itemDesc="+itemDescObj.value;
           else
           	   parent.document.getElementById("subDisplay").src="ezCatalogSearchDisplaytag.jsp?vendCatalog="+res[0]+"&itemNo="+itemNoTemp+"&itemDesc="+itemDescObj.value+"&searchType="+selOpt+"&catalogStr="+catStr;
                    
         }
</script>
</Head>  

<Body scroll=NO>
<Form name="myForm" method="post">
<input type="hidden" name="submitStr" value="Y">
<input type="hidden" name="selOpt" value="<%=selOpt%>">
<input type="hidden" name="addProduct" value="<%=addProduct%>">
<input type="hidden" name="FavGroup" value="<%=FavGroup%>">
<input type="hidden" name="GroupDesc" value="<%=GroupDesc%>">

	<Div id='inputDiv' style='position:absolute;align:center;width:100%;'>
	<Table width="90%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
	<Tr>
	<Td height="5" style="background-color:'DDEEFF'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
	<Td height="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
	<Td height="5" style="background-color:'DDEEFF'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
	</Tr>
	<Tr>
	<Td width="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
	<Td style="background-color:'DDEEFF'" valign=middle>
	
<%
        if("AS".equals(selOpt))
        {
%>
                
		<Table border="0" align="center" valign=middle width="100%" cellpadding=0 cellspacing=0 class=welcomecell>

                <tr><td align=center valign=center><b>Manufacturer Catalog</b></td></tr>
                <tr>
			<td align=center valign=center>
			<select name="venCatalog" style="width:60%" id="ListBoxDiv1">
			<option value="-" selected>select</option>
<%
			String catNum="",catalogName="",cat_num="";
			for (int i = 0 ;i<retCatCount;i++ ){
				catNum      = retcat.getFieldValue(i,"EPC_NO").toString();
				catalogName = (String)retcat.getFieldValue(i,"EPC_NAME");			
%>
				<option value="<%=catNum%>¥<%=catalogName%>"><%=catalogName%> </option>
<%			
		        }
%>
			</select>

			</td>
		</tr>
		<tr><td align=center valign=center><b>Item Id</b></td></tr>
		<tr>
			<td align=center valign=center>
				<input type=text name="itemNo" class=InputBox size=20 maxlength="100" value="" >
			</td>
		</tr>
		<tr><td align=center valign=center ><b>Item Description</b></td></tr>
		<tr>
			<td align=center valign=center>
				<input type=text name="itemDesc" class=InputBox size=20 maxlength="100" value="" >
			</td>
                </tr>
                <tr>
                	<Td valign=middle align=right>
				<Img src="../../Images/Common/left_arrow.gif" style="cursor:hand" border="none" onClick="funAdvSearch()" onMouseover="window.status=''; return true" onMouseout="window.status=' '; return true">
			</Td>
                </tr>
 	</table>
 
<%
        }
        else
        {
%>
			<Table border="0" align="center" valign=middle width="100%" cellpadding=0 cellspacing=0 class=welcomecell>
			<tr><td VALIGN=TOP colspan=2 align=center><b>Lookup by <%=dispStr%></b><td></tr>
			<Tr>
				<Td style='background:#DDEEFF;font-size=11px;color:#00355D;font-weight:bold;' width='100%' align=center valign=center>
				<input type=text name="search" class=InputBox size=20 maxlength="100" value="<%=tempPrdCode%>" >
				</Td>
				<Td valign=middle align=left>
					<Img src="../../Images/Common/left_arrow.gif" style="cursor:hand" border="none" onClick="funsearch()" onMouseover="window.status=''; return true" onMouseout="window.status=' '; return true">
				</Td>
			</Tr>
			</Table>
		

<%
        }
%>
		</Td>
		<Td width="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="Cb_e3.gif" ></Td>
		</Tr>
		<Tr>
		<Td width="5" style="background-color:'DDEEFF'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
		<Td height="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
		<Td width="5" style="background-color:'DDEEFF'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
		</Tr>
		</Table>
		</Div>
		
	        
	
	
<%
	if("Y".equals(subStr) && retObjCount==0){
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
	else if("Y".equals(subStr) && retObjCount>0){
%>
			<br><br><br>
		<table  align="center" width='100%'>
		<tr> 
		    <td style="background:transparent" bgcolor='#003366' width='50%' align=center> <b><font size = '-1' >Family</font></b></td>
		    <td style="background:transparent" bgcolor='#003366' width='50%' align=center> <b><font size = '-1' >Total</font></b></td>
		</tr>
		</table>
		

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

	<Div style='position:absolute;align:center;top:20%;width:90%;height:80%;overflow:auto;left:10%'>
	<table  align="center" width='90%'>
	
		    <tr>
			<td style="background:transparent" width='50%' align=left noWrap><b>
			<a href = "JavaScript:funShow('<%=catalogNo%>','<%=catalogDesc%>')"><font size = '1' color='blue'><%=catalogDesc%></font></a></b></td>
			<td  style="background:transparent" width='50%' align=right><b><font size = '1' color='blue'><%=total%></font></b></td>
		    </tr>

<%
		}//End for
%>
		</Table>
		</Div>
<%
	}
%>

	
	

</form>
<Div id="MenuSol"></Div>
</Body>
</Html>