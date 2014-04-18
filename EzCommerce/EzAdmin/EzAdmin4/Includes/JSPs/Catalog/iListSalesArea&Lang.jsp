
<%
  
   ReturnObjFromRetrieve retsyskey = null;
   ReturnObjFromRetrieve retlang = null;
   
   
   String sys_key = null;
   String lang = null;
   
   EzcSysConfigParams sparams = new EzcSysConfigParams();
   EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
   snkparams.setLanguage("EN");
   sparams.setObject(snkparams);
   Session.prepareParams(sparams);
   
   
   //Read All Languages
   retlang = (ReturnObjFromRetrieve)ezsc.getLangKeys(sparams);
   retlang.check();
   int langRows = retlang.getRowCount();
   
   // Get List Of System Keys
   retsyskey = (ReturnObjFromRetrieve)ezsc.getCatalogAreas(sparams);
   retsyskey.check();
   
   
   //Number of Catalog Areas
   int numCatArea = retsyskey.getRowCount();
%>