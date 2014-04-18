<%@ page import="ezc.ezparam.*"%>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<jsp:useBean id="EzCatalogManager" class="ezc.client.EzCatalogManager"/>
<%@ include file="../../../Includes/JSPs/Sales/iGetMaterials.jsp" %>
<%@ include file="../../../Includes/JSPs/ShoppingCart/iViewCart.jsp" %>
<%	
	ReturnObjFromRetrieve retSO = null;
	int cartRows 	= Cart.getRowCount();
	int count 	= 0;
	
	if(retpro!=null)
		count = retpro.getRowCount();
	
	
	log4j.log("countcountcountcount>>>>>>"+count,"W");
	
	String pGroupNumber = request.getParameter("ProductGroup");
	Hashtable selectdMet =(Hashtable)session.getAttribute("SELECTEDMET");
	Set matSet = new HashSet();

	if(selectdMet!=null)
		matSet = selectdMet.keySet(); 

	//log4j.log("pGroupNumberpGroupNumberpGroupNumber"+selectdMet,"W");
	int retCount = 0;
	if(!(pGroupNumber=="" || pGroupNumber==null))
	{
		EzCatalogParams ezread = new EzCatalogParams();
		ezread.setLanguage("EN");
		ezread.setProductGroup(pGroupNumber);
		Session.prepareParams(ezread);
		retSO = (ReturnObjFromRetrieve) EzCatalogManager.readCatalogDetails(ezread);
		retCount = retSO.getRowCount();	
	}
	
	

	out.println("<?xml version=\"1.0\"?>");		
	out.println("<rows>");
	for(int i=0; i<retCount;i++)
	{
		String prodCode     = retSO.getFieldValueString(i,"EPF_MAT_NO");
		String prodDesc     = retSO.getFieldValueString(i,"EMD_WEB_DESC");
		String vendCatalog  = retSO.getFieldValueString(i,"EMM_CATALOG_NO");
		String itemBrand     = retSO.getFieldValueString(i,"EMM_MANUFACTURER");
		String itemlistPrice= retSO.getFieldValueString(i,"EMM_UNIT_PRICE");
		String matId        = retSO.getFieldValueString(i,"EMM_ID");
		String rowId="";
		
		rowId=prodCode+"¥"+vendCatalog+"¥"+matId;
		
		prodDesc=prodDesc.replace('\"',' ');
		prodDesc=prodDesc.replace('\'',' ');	
		prodDesc=prodDesc.replace('<',' ');	
		prodDesc=prodDesc.replace('>',' ');	
		prodDesc=prodDesc.trim();
		prodDesc=replaceChar(prodDesc,'&');		
		String uom	=retSO.getFieldValueString(i,"EMM_UNIT_OF_MEASURE");		
		String chkStatus ="0";
		if(matSet.contains(prodCode))
			chkStatus ="1"; 
			
		out.println("<row id='"+rowId+"'><cell>"+chkStatus+"</cell><cell>"+prodCode+"</cell><cell>"+prodDesc+"</cell><cell>"+itemBrand+"</cell><cell>"+itemlistPrice+"</cell><cell>"+uom+"</cell></row>");
		//log4j.log("<row id='"+rowId+"'><cell>"+chkStatus+"</cell><cell>"+prodCode+"</cell><cell>"+prodDesc+"</cell><cell>"+itemBrand+"</cell><cell>"+itemlistPrice+"</cell><cell>"+uom+"</cell></row>","W");
	}
	
	if(retCount==0)
	{		
		out.println("<row id='"+retCount+"'></row>");
		//log4j.log("<row id='"+retCount+"'></row>","W");
	}
	out.println("</rows>");
%>	
<%!
	public static String replaceChar(String s, char c) 
	{
	      StringBuffer r = new StringBuffer(s.length()+4);
	      r.setLength( s.length()+4); 	       
	      int current = 0;
	      for (int i = 0; i < s.length(); i ++) 
	      {
	           char cur = s.charAt(i);
	           if (cur == c) 
	           {
	            	r.setCharAt(current++,cur);
	            	r.setCharAt(current++,'a');
	            	r.setCharAt(current++,'m');
	            	r.setCharAt(current++,'p');
	            	r.setCharAt(current++,';');
	           }	
	           else
	            	r.setCharAt( current++, cur);
	      }
	      return r.toString();
	}
%>