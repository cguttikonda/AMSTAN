 <%@ page import = "java.util.*"%>
 <%@ page import = "ezc.ezutil.FormatDate"%>
 <%@ page import ="ezc.ezutil.*" %>
 <%@ page import ="ezc.ezparam.*" %>
 <jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
 <jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
 <jsp:useBean id="webCatalogObj" class="ezc.client.EzWebCatalogManager" scope="page"></jsp:useBean>
 <%
 	String productNo   = request.getParameter("productNo");
 	String myReqType   = request.getParameter("myReqType");
 	String catalogCode = (String)session.getValue("CatalogCode");
 	boolean flag = false;
 	if(productNo!=null){
 		try
		{
 			if(productNo.indexOf("*")!=-1)
 			{
 				productNo=productNo.replace('*',' ');
 				productNo=productNo.trim();
 				flag = true;
 			}	
		}
		catch(Exception err)
 		{}
 		
 		try
 		{
 			if(productNo.startsWith("2")||productNo.startsWith("0"))
 		     		productNo	= "%000"+Integer.parseInt(productNo.trim());
 		     
 		     if(flag)
 		        productNo  = productNo+"*";
 		}
 		catch(Exception err)
 		{
 			productNo=productNo.trim();
 			
 			if(flag)
 				productNo=productNo+"*";
 			
 		}
 		productNo=productNo.replace('*','%');
 		
 	}
 	 
 	try{
 		if(productNo.startsWith("2"))
 		{
 			String productNoTemp=""+Integer.parseInt(productNo);
 			productNoTemp="000000000000000000"+productNoTemp;
 			productNo=productNoTemp.substring(productNoTemp.length()-18,productNoTemp.length());
 		}
 	}catch(Exception err){}
 	ArrayList mat = new ArrayList();
 	ArrayList Desc = new ArrayList();
 	ArrayList Uom = new ArrayList();
 	ArrayList UPC = new ArrayList();
 	ArrayList VenCatalog = new ArrayList();
 	ArrayList itemBrand = new ArrayList();
 	ArrayList itemListPrice = new ArrayList();
 	
 	String skey=(String) session.getValue("SalesAreaCode");
 	
 	EzCatalogParams catalogParams = new EzCatalogParams();
 	EzWebCatalogSearchParams searchParams = new EzWebCatalogSearchParams();
 	searchParams.setSearchType("P");
 	searchParams.setProductCode(productNo);
 	
 	catalogParams.setSysKey(skey);
	catalogParams.setLanguage("EN");
	catalogParams.setObject(searchParams);
	
	Session.prepareParams(catalogParams);
		
	ezc.ezparam.ReturnObjFromRetrieve retpro1 =(ezc.ezparam.ReturnObjFromRetrieve)webCatalogObj.searchByOptions(catalogParams);
 	 
 	/*ezc.ezprojections.client.EzProjectionsManager ProjManager1 = new ezc.ezprojections.client.EzProjectionsManager();
 	ezc.ezparam.EzcParams ezcpparams1 = new ezc.ezparam.EzcParams(true);
 
 	ezc.ezprojections.params.EziProjectionHeaderParams inparamsProj1=new ezc.ezprojections.params.EziProjectionHeaderParams();
 	
 	inparamsProj1.setSystemKey(skey+"') AND ECG_CATALOG_NO ='"+catalogCode+"' AND EMM_NO LIKE ('"+productNo);
 	ezcpparams1.setObject(inparamsProj1);
 	ezcpparams1.setLocalStore("Y");
 	
 	Session.prepareParams(ezcpparams1);
 	
 	
 	 	
 	ezc.ezparam.ReturnObjFromRetrieve retpro1 = (ezc.ezparam.ReturnObjFromRetrieve)ProjManager1.ezGetMaterialsByCountry(ezcpparams1);*/
 	
 	
 	
 	
 	
 	if(retpro1!=null && retpro1.getRowCount()>0)
 	{
 	
 		String sortField[]={"EMM_NO"};
		retpro1.sort(sortField,true);
 	
 		String matNo = "";
 		String venCatNo="";
 		String brand="";
 		String itemPrice="";
 	
 		for(int i=0;i<retpro1.getRowCount();i++)
 		{
 			try
 			{
 				matNo = Integer.parseInt(retpro1.getFieldValueString(i,"EMM_NO"))+"";
 			}
 			catch(Exception e)
 			{
 				matNo = retpro1.getFieldValueString(i,"EMM_NO");
 			}
 			
 			mat.add(matNo);
 			Desc.add(retpro1.getFieldValueString(i,"EMD_DESC"));
 			Uom.add(retpro1.getFieldValueString(i,"EMM_UNIT_OF_MEASURE"));
 			venCatNo =retpro1.getFieldValueString(i,"EMM_CATALOG_NO");
 			brand=retpro1.getFieldValueString(i,"EMM_MANUFACTURER");
 			itemPrice=retpro1.getFieldValueString(i,"EMM_UNIT_PRICE");
 			
 			if(venCatNo != null && !"".equals(venCatNo) && !"null".equals(venCatNo))
 				venCatNo=venCatNo.trim();
 			
 			VenCatalog.add(venCatNo);
 			itemBrand.add(brand);
 			itemListPrice.add(itemPrice);
 			String minQ = null;
 			if(minQ == null || "".equals(minQ)|| "null".equals(minQ)){
				minQ="1";
			}else{	
				minQ = minQ.trim();
			}
			UPC.add(minQ);			
 		}
 	}
 	
 
 
 	int rowCount = mat.size();
 	String xmlrep="";
 	
 	if("A".equals(myReqType)){
		
		if(rowCount>0){
			
			xmlrep="<table style='width:100%'><tr><td align=right style='background:#F5F5F5'><img src='../../../../EzCommon/Images/Common/close_icon.gif' border=0 style='cursor:hand' onClick='ezCCDivOut()'></td></tr></table><table id='productsTable' style='width:100%'>";
			for(int i=0;i<rowCount;i++)
			{
				xmlrep += "<tr><td class='initial' style='cursor:hand' onkeyPress='moveFocus()' onMouseOver=\"this.className='highlight'\" onMouseOut=\"this.className='normal'\" onClick=\"selectData('"+(String)mat.get(i)+"$$"+(String)Desc.get(i)+"$$"+(String)Uom.get(i)+"$$"+(String)UPC.get(i)+"$$"+(String)VenCatalog.get(i)+"$$"+(String)itemBrand.get(i)+"$$"+(String)itemListPrice.get(i)+"')\"><strong><font size=2>"+(String)mat.get(i)+"==></strong> <i>"+(String)Desc.get(i)+"</i></font><br></td></tr>";
				
			}
			xmlrep+="</table>";
			
		}else{
			xmlrep="<table style='width:100%'><tr><td align=right style='background:#F5F5F5'><img src='../../../../EzCommon/Images/Common/close_icon.gif' border=0 style='cursor:hand' onClick='ezCCDivOut()'></td></tr></table><table id='productsTable' style='width:100%'>";
			//xmlrep+="<table id='productsTable'>"; 
			xmlrep+="<tr><td class='initial'><strong>No Match Found</strong></td></tr>";
			xmlrep+="</table>";
		}
		
		
		
	}else{
		if(rowCount>0){
			xmlrep=(String)mat.get(0)+"$$"+(String)Desc.get(0)+"$$"+(String)Uom.get(0)+"$$"+(String)UPC.get(0)+"$$"+(String)VenCatalog.get(0)+"$$"+(String)itemBrand.get(0)+"$$"+(String)itemListPrice.get(0);
		}else{
			xmlrep="#No";
		}
	}
	

 	out.println(xmlrep);
 	
 	
 	
 %>
 
