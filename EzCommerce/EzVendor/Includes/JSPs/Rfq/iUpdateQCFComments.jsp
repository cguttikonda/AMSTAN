<%
	String collNo = "";
	if(request.getParameter("wf_trail_list") != null)
		collNo = request.getParameter("wf_trail_list");
	String userId = Session.getUserId();
	
	ezc.ezparam.ReturnObjFromRetrieve commentsRet = null;
	String commentNo = "";
	
	ezc.ezpreprocurement.client.EzPreProcurementManager qcfManager = new ezc.ezpreprocurement.client.EzPreProcurementManager();
	if(collNo != null)
	{
		ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
		ezc.ezpreprocurement.params.EziQcfCommentParams qcfParams= new ezc.ezpreprocurement.params.EziQcfCommentParams();
		qcfParams.setQcfCode(collNo);
		qcfParams.setQcfType("COMMENTS");
		qcfParams.setQcfExt1("$$");
		mainParams.setLocalStore("Y");
		mainParams.setObject(qcfParams);
		Session.prepareParams(mainParams);
		commentsRet = (ezc.ezparam.ReturnObjFromRetrieve)qcfManager.getMaxCommentNo(mainParams);

		if(commentsRet!= null || !"null".equals(commentsRet))
		{
			commentNo = commentsRet.getFieldValueString("COMMENT_NO");
			if(commentNo == "null" || "null".equals(commentNo))
				commentNo = "1";
		}		
		else
			commentNo = "1";
		commentsRet = (ezc.ezparam.ReturnObjFromRetrieve)qcfManager.getQcfCommentList(mainParams);
		
		if(commentsRet != null)
		{
			retCount = commentsRet.getRowCount();
		}
	}	
%>