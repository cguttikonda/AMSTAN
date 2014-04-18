<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="PreProManager" class="ezc.ezpreprocurement.client.EzPreProcurementManager" scope="session" />
<jsp:useBean id="ConfigManager" class="ezc.client.EzSystemConfigManager" scope="session"></jsp:useBean>





<%
	int collRFQCount=0;
	java.util.Vector collRFQVect=new java.util.Vector();
	String collRFQInStr="";
	String collectiveRFQNo[] = request.getParameterValues("chk1");
	String qcfCloseFlg="Y";
	String approvedVend = request.getParameter("approvedVend");
	java.util.Vector appVendVect=null;
	String partialPORFQStr="";
	java.util.Hashtable consumedRFQQtyHT=new java.util.Hashtable();
	EzStringTokenizer appVendSt=null;
	appVendSt = new EzStringTokenizer(approvedVend,"ее");
	appVendVect=appVendSt.getTokens();
	 
	
	if(collectiveRFQNo!=null)
		collRFQCount=collectiveRFQNo.length;
	
	if(collRFQCount>0){
		collRFQInStr=collectiveRFQNo[0];
		for(int i=1;i<collRFQCount;i++){
			collRFQInStr +="','"+collectiveRFQNo[i];
		}
	}
	
	
	
	int collRfqRetCount=0;
	int vendorCount=0;
	java.util.Vector rfqVendors=new java.util.Vector();
	java.util.Hashtable venInfo=new java.util.Hashtable();
	String []fields=new String[]{"RFQ_NO","COLLECTIVE_RFQ_NO","SYS_KEY","SOLD_TO","SOLD_TO_NAME","LINE_NO","MATERIAL","MATERIAL_DESC","UOM","DELIVERY_DATE","QUANTITY","PRICE","CURRENCY","PLANT","VAL_TYPE","TAX_CODE","PAYMENT_TERMS"};
	EzcParams ezContainer	= new EzcParams(false);
	EziRFQHeaderParams rfqHeaderParams = new EziRFQHeaderParams();
	rfqHeaderParams.setCollectiveRFQNo(collRFQInStr);
	rfqHeaderParams.setStatus("Y");
	rfqHeaderParams.setReleaseIndicator("R");
	rfqHeaderParams.setExt1("QCFPO");	
	ezContainer.setObject(rfqHeaderParams);
	ezContainer.setLocalStore("Y");
	Session.prepareParams(ezContainer);
	ReturnObjFromRetrieve collRfqRet = (ReturnObjFromRetrieve)PreProManager.ezGetRFQList(ezContainer);
  
	
	java.util.Hashtable openQCFHT = new java.util.Hashtable();
	
	
	ReturnObjFromRetrieve vendorRet=null;
	if(collRfqRet!=null)
		collRfqRetCount=collRfqRet.getRowCount();
	if(collRfqRetCount>0){	
		String vendor="";
		String vendName="";
		String collRfqNo="";
		String searchMat="";
		String vendRFQ="";
		for(int i=0;i<collRfqRetCount;i++){
			vendor		= collRfqRet.getFieldValueString(i,"SOLD_TO");
		collRfqNo = collRfqRet.getFieldValueString(i,"COLLECTIVE_RFQ_NO");
		vendRFQ   = collRfqRet.getFieldValueString(i,"RFQ_NO");
		if("".equals(partialPORFQStr))
		partialPORFQStr=vendRFQ;
		else
		partialPORFQStr +="','"+vendRFQ;

      
		if(vendor!=null) vendor=vendor.trim();

		if(!appVendVect.contains(vendor)){
			openQCFHT.put(collRfqNo,"N");
			qcfCloseFlg="N";
			continue;
		}	
			
				
			if(!rfqVendors.contains(vendor)){
				rfqVendors.add(vendor);
				vendorRet=new ReturnObjFromRetrieve(fields);
				
				
				for(int k=0;k<fields.length;k++){
					vendorRet.setFieldValue(fields[k],collRfqRet.getFieldValue(i,fields[k]));
				}
				
				vendorRet.addRow();
				
				
			}else{
			      	vendorRet=(ReturnObjFromRetrieve)venInfo.get(vendor);
			      	for(int k=0;k<fields.length;k++){
			      	   	vendorRet.setFieldValue(fields[k],collRfqRet.getFieldValue(i,fields[k]));
				}
				vendorRet.addRow();
			      	
			}
			
			venInfo.put(vendor,vendorRet);
     
      
		}
	}
	
	vendorCount=rfqVendors.size();
  if(!"".equals(partialPORFQStr))
  {
    ezContainer	= new EzcParams(false);
    rfqHeaderParams = new EziRFQHeaderParams();
    rfqHeaderParams.setCollectiveRFQNo(collRFQInStr);
    rfqHeaderParams.setExt1("PPDTL");	
    rfqHeaderParams.setRFQNo(partialPORFQStr);
    ezContainer.setObject(rfqHeaderParams);
    ezContainer.setLocalStore("Y");
    Session.prepareParams(ezContainer);
    ReturnObjFromRetrieve partialPOQtyRet = (ReturnObjFromRetrieve)PreProManager.ezGetRFQList(ezContainer);
    if(partialPOQtyRet!=null)
    {
      String rfqNoTemp="";  
      String rfqItemTemp="";
      String consumedQtyTemp="";
      String htKey="";
      for(int i=0;i<partialPOQtyRet.getRowCount();i++)
      {
        rfqNoTemp=partialPOQtyRet.getFieldValueString(i,"RFQ_NO");
        rfqItemTemp=partialPOQtyRet.getFieldValueString(i,"ITEM_NO");
        consumedQtyTemp=partialPOQtyRet.getFieldValueString(i,"PO_QTY");
        if(rfqNoTemp!=null&&rfqItemTemp!=null){
          htKey=rfqNoTemp.trim()+rfqItemTemp.trim();
          consumedRFQQtyHT.put(htKey,consumedQtyTemp);
                   
        } 
               
      }
            
    }
    
  }   

%>