<%
		java.util.Hashtable hashReqType = new java.util.Hashtable();
		hashReqType.put("Acknowledged",noAckPo_L);
		hashReqType.put("NotAcknowledged",allPoAck_L);
		hashReqType.put("Rejected",noRejectedPo_L);
		hashReqType.put("Open",noOpnPoEx_L);
		hashReqType.put("Closed",noClPoEx_L);
		hashReqType.put("All",noPoEx_L);
		hashReqType.put("New",allPoAck_L);
		hashReqType.put("CDate",noAckPo_L);
		hashReqType.put("",noPoEx_L);
		
		
		
		
		java.util.Hashtable hashReqStmt = new java.util.Hashtable();
		hashReqStmt.put("Acknowledged",noOpPo_L);
		hashReqStmt.put("NotAcknowledged",toBeAckPo_L);
		hashReqStmt.put("Rejected",rejPo_L);
		hashReqStmt.put("Open",opnPo_L);
		hashReqStmt.put("Closed",cloPo_L);
		hashReqStmt.put("All",purOrds_L);
		hashReqStmt.put("",purOrds_L);

%>