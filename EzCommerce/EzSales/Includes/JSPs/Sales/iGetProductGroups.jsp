<jsp:useBean id="EzCatalogManager" class="ezc.client.EzCatalogManager"/>
<%
   ReturnObjFromRetrieve retCatManager = null;
   EzCatalogParams ezcpparams1 = new EzCatalogParams();
   ezcpparams1.setLanguage("EN");
   ezcpparams1.setSysKey((String) session.getValue("SalesAreaCode"));
   ezcpparams1.setCatalogNumber((String) session.getValue("CatalogCode"));

   Session.prepareParams(ezcpparams1);
   //retCatManager = (ReturnObjFromRetrieve) EzCatalogManager.getProductGroups(ezcpparams1);
   retCatManager = (ReturnObjFromRetrieve) EzCatalogManager.readCatalogSelected(ezcpparams1);

%>
