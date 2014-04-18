<%!
	private String checkQueries(ezc.session.EzSession Session,String docNo,String userId)
	{
		int retCount=0,noRplyCount = 0,rplyCount = 0;
		String tempString = "";
		String rtrnStmt = "";
		ezc.ezpreprocurement.client.EzPreProcurementManager qcfManager = new ezc.ezpreprocurement.client.EzPreProcurementManager();
		ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
		mainParams.setLocalStore("Y");
		ezc.ezpreprocurement.params.EziQcfCommentParams qcfParams= new ezc.ezpreprocurement.params.EziQcfCommentParams();
		qcfParams.setQcfExt1("QRYCHK");
		qcfParams.setQcfCode(docNo);
		qcfParams.setQcfType("QUERY");
		qcfParams.setQcfUser(userId);
		mainParams.setObject(qcfParams);
		Session.prepareParams(mainParams);
		ezc.ezparam.ReturnObjFromRetrieve qcsRet = (ezc.ezparam.ReturnObjFromRetrieve)qcfManager.getQcfCommentList(mainParams);
		if(qcsRet != null)
		{
			retCount = qcsRet.getRowCount();
			if(retCount > 0)
			{
				rtrnStmt = "Q";
				for(int i=0;i<retCount;i++)
				{
					if("0".equals(qcsRet.getFieldValueString(i,"QUERY_STATUS")))
					{
						noRplyCount++;
					}
				}
		
				if(noRplyCount > 0)
				{
					rtrnStmt = "Q";
				}
				else if(noRplyCount == 0)
				{
					tempString = qcsRet.getFieldValueString(retCount-1,"QUERY_STATUS");	
					/*
					if("0".equals(tempString))
						rtrnStmt = "Q";
					if("-1".equals(tempString))
						rtrnStmt = "R";
					*/
					try
					{
						int tempVar = Integer.parseInt(tempString);
						
						if(tempVar >= 0)
							rtrnStmt = "Q";
						else
							rtrnStmt = "R";
					}
					catch(Exception ex){rtrnStmt = "Q";}					
				}
			}
			else
			{
				rtrnStmt = "N";
			}
		}
		return rtrnStmt;
	}
%>	