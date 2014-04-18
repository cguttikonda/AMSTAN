<%
	
	String brandName = "";
	String imgLink = "";
	String poProgType = "N";
	String poProgDisp = "";
	
	/*EzcParams prodParamsMiscV = new EzcParams(false);
	EziMiscParams prodParamsV = new EziMiscParams();

	ReturnObjFromRetrieve prodDetailsRetObjV = null;

	prodParamsV.setIdenKey("MISC_SELECT");
	String queryV="SELECT EZP_BRAND,EZP_ATTR2,EZP_ATTR1 FROM EZC_PRODUCTS WHERE EZP_PRODUCT_CODE = '"+prodCode_S+"'";

	prodParamsV.setQuery(queryV);

	prodParamsMiscV.setLocalStore("Y");
	prodParamsMiscV.setObject(prodParamsV);
	Session.prepareParams(prodParamsMiscV);	

	try
	{
		prodDetailsRetObjV = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(prodParamsMiscV);
	}
	catch(Exception e){}
	
	if(prodDetailsRetObjV!=null && prodDetailsRetObjV.getRowCount()>0)
	{
		brandName = nullCheck(prodDetailsRetObjV.getFieldValueString(0,"EZP_BRAND"));
		//imgLink   = nullCheck(prodDetailsRetObjV.getFieldValueString(0,"EZP_ATTR2"));
		poProgType = nullCheck(prodDetailsRetObjV.getFieldValueString(0,"EZP_ATTR1"));
	}
	*/

	/** BY MB  Replace Classification Code related checks with Commissions Group , CODE FOR EPCL READ ETC ABOVE THIS SHOULD BE REMOVED**/
	

	if("QS".equals(poProgType)){
		poProgDisp = "Quick Ship Item";	
		poProgType = "Q";
		}
	else if("CS".equals(poProgType)){
		poProgDisp = "Custom Item";
		poProgType = "C";
		}
	
%>

