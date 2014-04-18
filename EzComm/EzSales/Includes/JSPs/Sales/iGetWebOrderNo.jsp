<%
	EzcSalesOrderParams  ezcWebOrderParams = new EzcSalesOrderParams();
	ezcWebOrderParams.setSalesDocNum(strSalesOrder);
	ezcWebOrderParams.setLocalStore("Y");
	Session.prepareParams(ezcWebOrderParams);
	ReturnObjFromRetrieve  webRetObj = new ReturnObjFromRetrieve();
	ReturnObjFromRetrieve retWeb=null;
	int webRetObjCount = 0;
	try{
	
	
       		webRetObj = (ReturnObjFromRetrieve)EzSalesOrderManager.ezGetWebOrderNo(ezcWebOrderParams);
       		
		if(webRetObj!=null) webRetObjCount =webRetObj.getRowCount();


  		Vector types2 = new Vector();
  		Vector names2 = new Vector();
		types2.addElement("date");
		names2.addElement("ORDER_DATE");
		EzGlobal.setColTypes(types2);
		EzGlobal.setColNames(names2);
		retWeb = EzGlobal.getGlobal(webRetObj);
		
	}catch(Exception e){}


%>



