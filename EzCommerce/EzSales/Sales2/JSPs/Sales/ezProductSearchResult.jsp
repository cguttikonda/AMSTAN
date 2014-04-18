 <%@ page import = "java.util.*"%>
 <%@ page import = "ezc.ezutil.FormatDate"%>
 <%@ page import ="ezc.ezutil.*" %>
 <%@ page import ="ezc.ezparam.*" %>
 <jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
 <jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
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
 	 
 	/*
 	try{
 		if(productNo.startsWith("2"))
 		{
 			String productNoTemp=""+Integer.parseInt(productNo);
 			productNoTemp="000000000000000000"+productNoTemp;
 			productNo=productNoTemp.substring(productNoTemp.length()-18,productNoTemp.length());
 		}
 	}catch(Exception err){}
 	*/
 	ArrayList mat = new ArrayList();
 	ArrayList Desc = new ArrayList();
 	ArrayList Uom = new ArrayList();
 	ArrayList UPC = new ArrayList();
 	String skey=(String) session.getValue("SalesAreaCode");
 	 
 	ezc.ezprojections.client.EzProjectionsManager ProjManager1 = new ezc.ezprojections.client.EzProjectionsManager();
 	ezc.ezparam.EzcParams ezcpparams1 = new ezc.ezparam.EzcParams(true);
 
 	ezc.ezprojections.params.EziProjectionHeaderParams inparamsProj1=new ezc.ezprojections.params.EziProjectionHeaderParams();
 	
 	inparamsProj1.setSystemKey(skey+"') AND ECG_CATALOG_NO ='"+catalogCode+"' AND EMM_NO LIKE ('"+productNo);
 	ezcpparams1.setObject(inparamsProj1);
 	ezcpparams1.setLocalStore("Y");
 	
 	Session.prepareParams(ezcpparams1);
 	
 	
 	 	
 	ezc.ezparam.ReturnObjFromRetrieve retpro1 = (ezc.ezparam.ReturnObjFromRetrieve)ProjManager1.ezGetMaterialsByCountry(ezcpparams1);
 	
 	
 	if(retpro1!=null && retpro1.getRowCount()>0)
 	{
 	
 		String sortField[]={"MATNO"};
		retpro1.sort(sortField,true);
 	
 		String matNo = "";
 	
 		for(int i=0;i<retpro1.getRowCount();i++)
 		{
 			try
 			{
 				matNo = Integer.parseInt(retpro1.getFieldValueString(i,"MATNO"))+"";
 			}
 			catch(Exception e)
 			{
 				matNo = retpro1.getFieldValueString(i,"MATNO");
 			}
 			
 			mat.add(matNo);
 			Desc.add(retpro1.getFieldValueString(i,"MATDESC"));
 			Uom.add(retpro1.getFieldValueString(i,"UOM"));
 			String minQ =retpro1.getFieldValueString(i,"UPC_NO");
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
			for(int i=0;i<rowCount;i++)
			{

				xmlrep += "<strong><font size=2>"+(String)mat.get(i)+"==></strong> <i>"+(String)Desc.get(i)+"</i></font><br>";
				
			}
		}else{
			xmlrep+="<strong>No Match Found</strong>";
		}
		
		
		
	}else{
		if(rowCount>0){
			xmlrep=(String)mat.get(0)+"$$"+(String)Desc.get(0)+"$$"+(String)Uom.get(0)+"$$"+(String)UPC.get(0);
		}else{
			xmlrep="#No";
		}
	}
	

 	out.println(xmlrep);
 	
 	
 	
 %>
 
