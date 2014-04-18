<%	

	String userRole=(String)session.getValue("UserRole");
	ArrayList statKeys=new ArrayList();
	ArrayList statDesc=new ArrayList();
	ArrayList allStatKeys=new ArrayList();
	
	statKeys.add("'New'"); 					statDesc.add("Saved");
	statKeys.add("'RetNew'");				statDesc.add("Saved Return");
	statKeys.add("'Transfered'");				statDesc.add("Accepted");
	statKeys.add("'RETTRANSFERED'");			statDesc.add("Posted Return");

	if("CU".equals(userRole) || "AG".equals(userRole))
	{
		statKeys.add("'New'"); 							statDesc.add("Saved");
		statKeys.add("'RetNew'");						statDesc.add("Return");
		statKeys.add("'Submitted','Approved','SubmittedToBP','ReturnedByBP'");	statDesc.add(submitted_L);
		statKeys.add("'ReturnedBYCM'");						statDesc.add(returnByCM_L);
		statKeys.add("'ReturnedBYLF'");						statDesc.add(returnByLF_L);
		statKeys.add("'Rejected'");						statDesc.add(rejected_L);
		statKeys.add("'Transfered'");						statDesc.add("Accepted");
		statKeys.add("'RETTRANSFERED','RETCMTRANSFER'");			statDesc.add("Posted Return");
		statKeys.add("'RETTRANSFERED'");					statDesc.add("Posted Return");
		statKeys.add("'RETCMTRANSFER'");					statDesc.add("Posted Return");
	}
	else if("CM".equals(userRole))
	{

		statKeys.add("'Submitted'");					statDesc.add(submitted_L);
		statKeys.add("'New'"); 						statDesc.add("Saved");
		statKeys.add("'RetNew'");					statDesc.add("Return ");
		statKeys.add("'ReturnedBYCM'");					statDesc.add(returnByCM_L);
		statKeys.add("'ReturnedBYLF'");					statDesc.add(returnByLF_L);
		statKeys.add("'Approved','SubmittedToBP','ReturnedByBP'"); 	statDesc.add(approvByCM_L);
		statKeys.add("'Rejected'");					statDesc.add(rejected_L);
		statKeys.add("'Transfered'");					statDesc.add("Accepted");
		statKeys.add("'Rettransfered','Retcmtransfer'");		statDesc.add("Posted Return");
		statKeys.add("'Rettransfered'");				statDesc.add("Posted Return");
		statKeys.add("'RETCMTRANSFER'");				statDesc.add("Blocked Delivery");
	}
	else if("LF".equals(userRole))
	{
		statKeys.add("'Approved'"); 					statDesc.add(approvByCM_L);
		statKeys.add("'Rejected'");					statDesc.add(rejected_L);
		statKeys.add("'ReturnedBYLF'");					statDesc.add(returnByLF_L);
		statKeys.add("'Transfered'");					statDesc.add(accepted_L);
		statKeys.add("'SubmittedToBP'");				statDesc.add(subToBP_L);
		statKeys.add("'ReturnedByBP'");					statDesc.add(retByBP_L);
		statKeys.add("'RetTransfered'");				statDesc.add("Posted Return ");
	}
	else if("BP".equals(userRole))
	{
		statKeys.add("'Rejected'");					statDesc.add(rejected_L);
		statKeys.add("'ReturnedBYLF'");					statDesc.add(returnByLF_L);
		statKeys.add("'Transfered'");					statDesc.add(accepted_L);
		statKeys.add("'SubmittedToBP'");				statDesc.add(subToBP_L);
		statKeys.add("'ReturnedByBP'");					statDesc.add(retByBP_L);
	}
	
%>	