<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ page import="ezc.ezparam.ReturnObjFromRetrieve" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="catalogObj" class="ezc.client.EzCatalogManager" scope="page"></jsp:useBean>

<%
          String syskey        = (String)session.getValue("SalesAreaCode"); 
          
          String type = request.getParameter("type");
          	if(type==null || "null".equals(type)) type ="";
          
          String prdCode = request.getParameter("prdCode");
	        if(prdCode==null || "null".equals(prdCode)) prdCode ="";

	  String vendCatalog = request.getParameter("vendCatalog");
          	if(vendCatalog==null || "null".equals(vendCatalog)) vendCatalog ="";
          	
 	  String matId = request.getParameter("matId");
          	if(matId==null || "null".equals(matId)) matId ="";          	

          String attachFile = request.getParameter("attachFile");
          	if(attachFile==null || "null".equals(attachFile)) attachFile ="";
          
	  String dirName = request.getParameter("dirName");
	  	if(dirName==null || "null".equals(dirName)) dirName =""; 
	  	
	  String attachPath=dirName+"/"+attachFile;
	  
	  if(prdCode!=null)
    	  prdCode = prdCode.replaceAll("@@@","#");  
	  
	      
    try{
	  EzProdSyncParams prodSyncParams = new EzProdSyncParams();
	  EzCatalogParams catalogParams = new EzCatalogParams();

	  EzbapimatTable ebmt = new EzbapimatTable();
	  EzbapimatTableRow bapimatTableRow = null;
	
	  EzbapimtdTable ebmd = new EzbapimtdTable();
	  EzbapimtdTableRow bapimtdTableRow = null;
	          
          bapimatTableRow = new EzbapimatTableRow();
          bapimtdTableRow = new EzbapimtdTableRow();
          
         
          bapimatTableRow.setCatalogNumber(vendCatalog + "' AND EMM_ID = '"+matId); 
	  bapimatTableRow.setMaterial(prdCode);
	  
	  bapimtdTableRow.setMaterial(prdCode);
	  
	  if(!"".equals(type) && "I".equals(type)){
	  	bapimatTableRow.setImagePath(attachPath);
	  }
	  if(!"".equals(type) && "S1".equals(type)){
	  	bapimtdTableRow.setSpec1(attachPath);
	  }
	  if(!"".equals(type) && "S2".equals(type)){
	  	bapimtdTableRow.setSpec2(attachPath);
	  }
	  if(!"".equals(type) && "S3".equals(type)){
	  	bapimtdTableRow.setSpec3(attachPath);
	  }
	  if(!"".equals(type) && "S4".equals(type)){
	  	bapimtdTableRow.setSpec4(attachPath);
	  }
	
	bapimatTableRow.setType("B");
	ebmt.appendRow(bapimatTableRow);
	ebmd.appendRow(bapimtdTableRow);
	 
     
	prodSyncParams.setSysKey(syskey);
	prodSyncParams.setMaterialTable(ebmt);
	prodSyncParams.setMaterialDescTable(ebmd);
	catalogParams.setSysKey(syskey);
	catalogParams.setLanguage("EN");
	catalogParams.setObject(prodSyncParams);
	catalogParams.setIndicator("UPLOAD");
	catalogParams.setLocalStore("Y");
	Session.prepareParams(catalogParams);
	
		
	catalogObj.updateMaterialMaster(catalogParams); 
       
   }catch(Exception e){ }
	
%>
