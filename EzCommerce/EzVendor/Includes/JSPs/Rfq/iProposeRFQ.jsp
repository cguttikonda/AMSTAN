<%
	ezc.ezpreprocurement.client.EzPreProcurementManager  ezPreProcurementMgr = new ezc.ezpreprocurement.client.EzPreProcurementManager();
	ezc.ezparam.EzcParams propEzcParams = new ezc.ezparam.EzcParams(false);

	ezc.ezpreprocurement.params.EziRFQHeaderTable  riRfqheaderTable = new ezc.ezpreprocurement.params.EziRFQHeaderTable();
	ezc.ezpreprocurement.params.EziRFQHeaderTableRow riRfqheaderTableRow = null;
	
	String str[]  	 = request.getParameterValues("propose");
	String allrfqs[] = request.getParameterValues("allrfqs");
	String proposeFlg= request.getParameter("proposeFlg");
	
	ezc.ezparam.ReturnObjFromRetrieve proposeRFQRet = null;
	if(str != null)
	{
		if(!"disabled".equals(proposeFlg)){
			String proposedrfqs="";
			for(int i=0;i<str.length;i++)
			{
				proposedrfqs +=","+str[i];
				riRfqheaderTableRow = new ezc.ezpreprocurement.params.EziRFQHeaderTableRow();

				riRfqheaderTableRow.setModifiedBy(Session.getUserId());
				riRfqheaderTableRow.setReleaseIndicator("R");
				riRfqheaderTableRow.setRFQNo(str[i]);

				riRfqheaderTable.appendRow(riRfqheaderTableRow);
			}

			for(int k=0;k<allrfqs.length;k++)
			{
				if(proposedrfqs.indexOf(allrfqs[k])<=0)
				{

					riRfqheaderTableRow = new ezc.ezpreprocurement.params.EziRFQHeaderTableRow();
					riRfqheaderTableRow.setModifiedBy(Session.getUserId());
					riRfqheaderTableRow.setReleaseIndicator("N");
					riRfqheaderTableRow.setRFQNo(allrfqs[k]);
					riRfqheaderTable.appendRow(riRfqheaderTableRow);
				}		
			}

			propEzcParams.setLocalStore("Y");	
			propEzcParams.setObject(riRfqheaderTable);
			Session.prepareParams(propEzcParams);
			proposeRFQRet = (ezc.ezparam.ReturnObjFromRetrieve)ezPreProcurementMgr.ezUpdateRFQ(propEzcParams);
		}	
	}	
%>