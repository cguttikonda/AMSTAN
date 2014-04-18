<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="UploadManager" class="ezc.ezupload.client.EzUploadManager" />
<jsp:useBean id="ShipManager" class="ezc.ezshipment.client.EzShipmentManager" />

<%	

	String SampleId = request.getParameter("sampleId");	
	String ItemNumber = request.getParameter("itemNumber");	
	String LineNumber = request.getParameter("lineNumber");	

	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(true);
	mainParams.setLocalStore("Y");
	ezc.ezshipment.params.EziCOAParams iParams= new ezc.ezshipment.params.EziCOAParams();
	iParams.setDocumentNo(SampleId);
	iParams.setItemNumber(ItemNumber);
	iParams.setLineNumber(LineNumber);
	mainParams.setObject(iParams);
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve ret=(ezc.ezparam.ReturnObjFromRetrieve)ShipManager.ezGetCOA(mainParams);

	String[] coaFields = new String[9];
	coaFields[0] = "DESCRIPTION";
	coaFields[1] = "DIMLENGTH";
	coaFields[2] = "DIMWIDTH";
	coaFields[3] = "DIMHEIGHT";
	coaFields[4] = "GRAMMAGE";
	coaFields[5] = "FLAPCUTTING";
	coaFields[6] = "PRINTING";
	coaFields[7] = "SHADE";
	coaFields[8] = "AQLDEFECTS";

	ezc.ezparam.ReturnObjFromRetrieve retOther = null;
 	ezc.ezparam.EzcParams oParams = new ezc.ezparam.EzcParams(true);
  	ezc.ezupload.params.EziDocumentTextsTable table =  new ezc.ezupload.params.EziDocumentTextsTable();
  	ezc.ezupload.params.EziDocumentTextsTableRow tableRow=null;

	String flag1 = request.getParameter("flag");
        String docNo="";
        if(flag1.equals("SHIPMENT"))
	{
	  docNo = SampleId+"COA"+ItemNumber+LineNumber;	  	
        }
        else
        {
          docNo = SampleId+"COA"+LineNumber;	
        }

	for(int i=0;i<coaFields.length;i++)
	{
	    tableRow =  new ezc.ezupload.params.EziDocumentTextsTableRow();
   	    tableRow.setDocType(flag1);
	    tableRow.setDocNo(docNo);
    	    tableRow.setSysKey((String)session.getValue("SYSKEY"));
	    tableRow.setKey(coaFields[i]);
    	    table.appendRow(tableRow);
	}

  	oParams.setObject(table);	
   	Session.prepareParams(oParams);
	retOther=(ezc.ezparam.ReturnObjFromRetrieve)UploadManager.getDocumentTextDetails(oParams);
        int Count = retOther.getRowCount();
	
%>