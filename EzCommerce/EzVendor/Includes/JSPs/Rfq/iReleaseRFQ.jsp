<%

	ezc.ezpreprocurement.client.EzPreProcurementManager  ezPreProcurementRFQMgr = new ezc.ezpreprocurement.client.EzPreProcurementManager();
	ezc.ezparam.EzcParams RFQEzcParams = new ezc.ezparam.EzcParams(false);

	ezc.ezpreprocurement.params.EziRFQHeaderTable  rfqTable	=  new ezc.ezpreprocurement.params.EziRFQHeaderTable();
	ezc.ezpreprocurement.params.EziRFQHeaderTableRow rfqTableRow	= null;

	ezc.ezpreprocurement.params.EziAuditTrailTable eziaudittable = new ezc.ezpreprocurement.params.EziAuditTrailTable();
	ezc.ezpreprocurement.params.EziAuditTrailTableRow 	eziaudittablerow 	= null;	

	String purchOrg    = (String)Session.getUserPreference("PURORG");
	String purGrp  	   = (String)Session.getUserPreference("PURGROUP");

	String relrfq[] = request.getParameterValues("propose");


	ezc.ezparam.ReturnObjFromRetrieve relRFQRet = null;
	boolean rfqReleased = false;
	if(relrfq != null)
	{

		for(int i=0;i<relrfq.length;i++)
		{

			rfqTableRow = new ezc.ezpreprocurement.params.EziRFQHeaderTableRow();
			rfqTableRow.setRFQNo(relrfq[i]);
			rfqTable.appendRow(rfqTableRow);


			/*eziaudittablerow 	= new ezc.ezpreprocurement.params.EziAuditTrailTableRow();	
			eziaudittablerow.setDocId(relrfq[i]);
			eziaudittablerow.setDocType("AN");
			eziaudittablerow.setDocCategory("A");
			eziaudittablerow.setUserName(Session.getUserId());
			eziaudittablerow.setFMName("Z_EZ_RFQ_CHANGE");
			eziaudittablerow.setIPAddress(request.getRemoteAddr());
			eziaudittablerow.setPurOrg(purchOrg);
			eziaudittablerow.setPurGrp(purGrp);
			eziaudittablerow.setComments("RFQ has been released");
			eziaudittablerow.setChangeInd("U");
			eziaudittable.appendRow(eziaudittablerow);
			*/

		}	

		//RFQEzcParams.setLocalStore("Y");	
		RFQEzcParams.setObject(rfqTable);
		Session.prepareParams(RFQEzcParams);
		relRFQRet = (ezc.ezparam.ReturnObjFromRetrieve)ezPreProcurementRFQMgr.ezClosePR(RFQEzcParams);
		
		
		boolean saveAudTrl = false;

		if(relRFQRet!=null && relRFQRet.getRowCount()>0)
		{
			int relRFQRetCnt = relRFQRet.getRowCount();
			for(int r=0;r<relRFQRetCnt;r++)
			{
				String status = relRFQRet.getFieldValueString(r,"TYPE").trim();
				
				if("E".equals(status))
				{
					errRelRfq = true;
					errMsg += relRFQRet.getFieldValueString(r,"MESSAGE")+"<Br>";
				}
				else
				if("S".equals(status) && "RFQ".equals(relRFQRet.getFieldValueString(r,"MESSAGE_V1")))
				{
					String rfqNumber = relRFQRet.getFieldValueString(r,"MESSAGE_V2");
					
					eziaudittablerow 	= new ezc.ezpreprocurement.params.EziAuditTrailTableRow();	
					eziaudittablerow.setDocId(rfqNumber);
					eziaudittablerow.setDocType("AN");
					eziaudittablerow.setDocCategory("A");
					eziaudittablerow.setUserName(Session.getUserId());
					eziaudittablerow.setFMName("Z_EZ_RFQ_CHANGE");
					eziaudittablerow.setIPAddress(request.getRemoteAddr());
					eziaudittablerow.setPurOrg(purchOrg);
					eziaudittablerow.setPurGrp(purGrp);
					eziaudittablerow.setComments("RFQ has been released");
					eziaudittablerow.setChangeInd("U");
					eziaudittable.appendRow(eziaudittablerow);
					
					saveAudTrl = true;
				
				}
			}		
			if(saveAudTrl)
			{
				RFQEzcParams.setObject(eziaudittable);
				Session.prepareParams(RFQEzcParams);
				ezPreProcurementRFQMgr.ezAddAuditTrail(RFQEzcParams);
			}
		}  
	}
%>	
	