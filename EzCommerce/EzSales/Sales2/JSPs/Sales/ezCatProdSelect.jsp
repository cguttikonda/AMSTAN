<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ page import="ezc.ezparam.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<jsp:useBean id="EzCatalogManager" class="ezc.client.EzCatalogManager"/>
<html>
<head>
<title>Catalog</title>
<%
	String retVal  = request.getParameter("retVal");
	String pGroupNumber = request.getParameter("ProductGroup");
	String pGroupDesc = request.getParameter("GroupDesc");
	ReturnObjFromRetrieve retSO = null;
	int retCount 	= 0;
	if(!(pGroupNumber=="" || pGroupNumber==null))
	{
		EzCatalogParams ezread = new EzCatalogParams();
		ezread.setLanguage("EN");
		ezread.setProductGroup(pGroupNumber);
		Session.prepareParams(ezread);
		retSO = (ReturnObjFromRetrieve) EzCatalogManager.readCatalogDetails(ezread);		
		retCount = retSO.getRowCount();	
	}
	
	
	
	java.util.StringTokenizer st 	= null; 
	java.util.ArrayList prdList	= new java.util.ArrayList();
		
	if(retVal!=null)	
	{
		st = new StringTokenizer(retVal,"@@@");

		if(st!=null)
		{
			String productNo ="";
			while(st.hasMoreElements())
			{
				
				productNo = st.nextElement()+"";
				prdList.add(productNo.trim());
				
				/*
				try
				{
						 		
					String productNoTemp=""+Integer.parseInt(productNo);
					productNoTemp="000000000000000000"+productNoTemp;
					productNoTemp=productNoTemp.substring(productNoTemp.length()-18,productNoTemp.length());
					prdList.add(productNoTemp.trim());
					
 				}catch(Exception err){
					prdList.add((productNo).trim().toUpperCase());
				}
				*/
			}
		}

	}
	
	
%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<Script>
	  var tabHeadWidth=80
 	  var tabHeight="60%"
</Script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>

<Script>
		var o 	= new Object();
		var prodCount = "<%=retCount%>";
		function selectAll(obj)
		{
			prodLen = document.myForm.prodCode.length
			if(obj.checked==true)
			{
				
				if(isNaN(prodLen))
				{
					if(document.myForm.prodCode!=null)
						document.myForm.prodCode.checked = true;
				}	
				else
				{
					for(var i=0;i<prodLen;i++)
					{
						if(document.myForm.prodCode[i]!=null)
							document.myForm.prodCode[i].checked=true;
					}
				}
			}
			else
			{
				if(isNaN(prodLen))
				{
					if(document.myForm.prodCode!=null)
						document.myForm.prodCode.checked = false;
				}		
				else
				{
					for(var i=0;i<prodLen;i++)
					{
						if(document.myForm.prodCode[i]!=null)
							document.myForm.prodCode[i].checked=false;
					}
				}
			}
		}
	
		function CheckSelect() 
		{
			var code="",desc="",uom="",upc="",venCatalog="",brand="",listPrice="";
			var prodObj = document.myForm.prodCode;
			var len = 0;
			if(prodObj!=null)
				len = prodObj.length;
			var chk_len = 0;
			if(isNaN(len))
			{
				if(document.myForm.prodCode.checked)
					chk_len++;
			}
			else
			{
				for (var i=0;i<len;i++)
				{
					if(document.myForm.prodCode[i].checked)
						chk_len++;
				}
			}
		
			if(chk_len == 0)
				alert("select atleast one product or click close");
			else
			{
				var chkCount = 0;
				if(isNaN(len))
				{
					if(document.myForm.prodCode.checked)
					{
						code		= document.myForm.prodCode.value;
						desc		= document.myForm.matDesc.value;
						uom		= document.myForm.uom.value;
						upc		= document.myForm.upcNo.value;
						venCatalog	= document.myForm.VendCatalog.value;
						brand  		= document.myForm.brand.value;
						listPrice  	= document.myForm.listPrice.value;
					}
				}
				else
				{
					for (var i=0;i<len;i++)
					{
						if(document.myForm.prodCode[i].checked)
						{
							if(code!="")
							{
								code	   = code+"¥"+document.myForm.prodCode[i].value;
								desc	   = desc+"¥"+document.myForm.matDesc[i].value;
								uom	   = uom+"¥"+document.myForm.uom[i].value;
								upc	   = upc+"¥"+document.myForm.upcNo[i].value;
								venCatalog = venCatalog+"¥"+document.myForm.VendCatalog[i].value;
								brand 	   = brand+"¥"+document.myForm.brand[i].value;
								listPrice  = listPrice+"¥"+document.myForm.listPrice[i].value;
								
							}
							else
							{
								code	   = document.myForm.prodCode[i].value;
								desc	   = document.myForm.matDesc[i].value;
								uom	   = document.myForm.uom[i].value;
								upc	   = document.myForm.upcNo[i].value;
								venCatalog = document.myForm.VendCatalog[i].value;
								brand      = document.myForm.brand[i].value;
								listPrice  = document.myForm.listPrice[i].value;
							}
							chkCount++;
						}
					}
				}		

				o.retProd	= code;
				o.retDesc	= desc;
				o.retUom	= uom;
				o.retUpc	= upc;
				o.retCat	= venCatalog;
				o.retBrand	= brand;
				o.retListPrice	= listPrice;
				
				o.count		= chkCount;
				
				
				window.returnValue=o;
				window.close();	
			}
		}
	
		function winClose()
		{
			o.retProd = "CLOSE"
			window.returnValue = o;
			window.close();
		}			   	  
	</Script>
</head>
<body onLoad="scrollInit();" scroll=no>
<form method="post" name="myForm">
<input type="hidden" name=selAllImg value="0">
<table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
<tr>
	<td height="30" class="displayheaderback" align=center  width="100%"><%=pGroupDesc%></td>
</tr>
</table>
<br>
<Div id='theads' >
<Table width="80%"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	<Tr >
		<th width="5%" ><input type="checkbox" name="select" onClick="selectAll(this)" title="Select/Deselect All"></th>
		<th width="20%">Product</th>
		<th width="35%">Description</th>
		<th width="5%">UOM</th>
		<th width="20%">Brand</th>
		<th width="10%">List Price</th> 
	</Tr>
</Table>
</Div>
<Div   id='InnerBox1Div' style='overflow:auto;position:relative;width:80%;height:60%;'>
<Table id='InnerBox1Tab' align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>
<%	
	int prdcount  = 0;
	String prCode = "";
	for(int i=0;i<retCount;i++)
   	{  
   		try
   		{
   			prCode = Integer.parseInt(retSO.getFieldValueString(i,"EPF_MAT_NO").trim())+"";
   			
   		}
   		catch(Exception e)
   		{
   			prCode = retSO.getFieldValueString(i,"EPF_MAT_NO").trim();
   		}
   	
   		if(prdList.contains(retSO.getFieldValueString(i,"EPF_MAT_NO").trim()))
   			continue;
   		else
   			prdcount++;
%>   
		<tr>
			<Td width="5%" 	align="left" ><input type='checkbox' name='prodCode' value='<%=retSO.getFieldValueString(i,"EPF_MAT_NO")%>'></Td>
			<Td width="20%" align="left" >&nbsp;<%=prCode%></Td>
			<Td width="35%" align="left" >&nbsp;<%=retSO.getFieldValueString(i,"EMD_WEB_DESC")%></Td>
			<Td width="10%" align=center >&nbsp;<%=retSO.getFieldValueString(i,"EMM_UNIT_OF_MEASURE")%></Td>
			<Td width="20%" >&nbsp;<%=retSO.getFieldValueString(i,"EMM_MANUFACTURER")%></Td>
			<Td width="10%" >&nbsp;<%=retSO.getFieldValueString(i,"EMM_UNIT_PRICE")%></Td>
			<!--<Td width="15%" align=center >&nbsp;<%=retSO.getFieldValueString(i,"EMM_EAN_UPC_NO")%></Td>-->
			<input type="hidden" name="VendCatalog" value="<%=retSO.getFieldValue(i,"EMM_CATALOG_NO")%>">
			<input type='hidden' name='matDesc' value="<%=retSO.getFieldValueString(i,"EMD_WEB_DESC")%>">
			<input type='hidden' name='uom' value='<%=retSO.getFieldValueString(i,"EMM_UNIT_OF_MEASURE")%>'>
			<input type='hidden' name='upcNo' value='<%=retSO.getFieldValueString(i,"EMM_EAN_UPC_NO")%>'>
			<input type='hidden' name='brand' value='<%=retSO.getFieldValueString(i,"EMM_MANUFACTURER")%>'>
			<input type='hidden' name='listPrice' value='<%=retSO.getFieldValueString(i,"EMM_UNIT_PRICE")%>'>
			
		</tr>
<%	}
	if(prdcount==0)
	{
%>
		<tr>
			<Td colspan=6 width="100%">
				All products in this catalog have been already added.
			</Td>				
		</tr>		
	
	<script>	
		document.myForm.select.disabled=true;
	</script>
			
<%	
	}
%>	
	</Table>
</Div>


<Div id="buttonDiv" align='center' style='Position:Absolute;width:100%;top:90%'>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	if(prdcount>0)
	{
		buttonName.add("Select");
		buttonMethod.add("CheckSelect()");
	}	
	buttonName.add("Close");
	buttonMethod.add("winClose()");

	out.println(getButtonStr(buttonName,buttonMethod));
%>
</Div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>


