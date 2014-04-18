<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%
	//out.println("&****************************IN PAGE*********");
	String groupbykeys[]=request.getParameterValues("chk1");

	String authkey=request.getParameter("authKey");
	String Status=request.getParameter("Status");
	String Step=request.getParameter("Step");
	String Participant=request.getParameter("Participant");
	String ParticipantType=request.getParameter("ParticipantType");
	String CreatedOn1 =request.getParameter("CreatedOn1");
	String CreatedOn2 =request.getParameter("CreatedOn2");
	String ModifiedOn1=request.getParameter("ModifiedOn1");
	String ModifiedOn2=request.getParameter("ModifiedOn2");
	String CreatedBy=request.getParameter("CreatedBy");
	String ModifiedBy =request.getParameter("ModifiedBy");
	String DocDate =request.getParameter("DocDate");
	String Ref1 = request.getParameter("Ref1");
	String Ref2 =request.getParameter("Ref2");
	String SysKey = request.getParameter("SysKey");
	String docId=request.getParameter("DocId");
	String key=request.getParameter("key");
	//out.println("authkey----"+authkey+"---"+"<BR>");
	//out.println("Status----"+Status+"---"+"<BR>");
	//out.println("Step----"+Step+"---"+"<BR>");
	//out.println("Participant----"+Participant+"---"+"<BR>");
	//out.println("ParticipantType----"+ParticipantType+"---"+"<BR>");
	//out.println("CreatedOn----"+CreatedOn1+"---"+"<BR>");
	//out.println("ModifiedOn----"+ModifiedOn1+"---"+"<BR>");
	//out.println("CreatedBy----"+CreatedBy+"---"+"<BR>");
	//out.println("ModifiedBy----"+ModifiedBy+"---"+"<BR>");
	//out.println("DocDate ----"+DocDate +"---"+"<BR>");
	//out.println("Ref1----"+Ref1+"---"+"<BR>");
	//out.println("Ref2----"+Ref2+"---"+"<BR>");
	//out.println("SysKey----"+SysKey+"---"+"<BR>");
	//out.println("docId----"+docId+"---"+"<BR>");
	//out.println("key----"+key+"---"+"<BR>");

	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWFDocHistoryParams params= new ezc.ezworkflow.params.EziWFDocHistoryParams();
	if(authkey!=null && !"".equals(authkey) && !("null".equals(authkey)))
	{
		//out.println("**authkey**"+authkey);
		params.setAuthKey("'"+authkey+"'");
	}
	if(Status!=null && !"".equals(Status) && !("null".equals(Status)))
	{
		//out.println("**Status**"+Status);
		params.setStatus("'"+Status+"'");
	}
	if(Step!=null && !"".equals(Step) && !("null".equals(Step)))
	{
		//out.println("**Step**"+Step);
		params.setCurrentStep("'"+Step+"'");
	}
	if(Participant!=null && !"".equals(Participant) && !("null".equals(Participant)))
	{
		//out.println("**Participant**"+Participant);
		params.setParticipant("'"+Participant+"'");
	}
	if(ParticipantType!=null  && !"".equals(ParticipantType) && !("null".equals(ParticipantType)))
	{
		//out.println("**ParticipantType**"+ParticipantType);
		params.setParticipantType("'"+ParticipantType+"'");
	}
	if(CreatedBy!=null && !"".equals(CreatedBy) && !("null".equals(CreatedBy)))
	{
		//out.println("**CreatedBy**"+CreatedBy);
		params.setCreatedBy("'"+CreatedBy+"'");
	}
	if(ModifiedBy!=null && !"".equals(ModifiedBy) &&  !("null".equals(ModifiedBy)))
	{
		//out.println("**ModifiedBy**"+ModifiedBy);
		params.setModifiedBy("'"+ModifiedBy+"'");
	}
	if(DocDate!=null && !"".equals(DocDate) && !("null".equals(DocDate)))
	{
		//out.println("**DocDate**"+DocDate);
		params.setDocDate("'"+DocDate+"'");
	}
	if(Ref1!=null && !"".equals(Ref1) && !("null".equals(Ref1)))
	{
		//out.println("**Ref1**"+Ref1);
		params.setRef1(Ref1);
	}

	if(SysKey!=null && !"".equals(SysKey) && !("null".equals(SysKey)))
	{
		//out.println("**SysKey**"+SysKey);
		params.setSysKey("'"+SysKey+"'");
	}
	if(docId!=null && !"".equals(docId) && !("null".equals(docId)))
	{
		//out.println("**docId**"+docId);
		params.setDocId("'"+docId+"'");
	}
	if(Ref2!=null && !"".equals(Ref2) && !("null".equals(Ref2)))
	{
			//out.println("**Ref2**"+Ref2);
			params.setRef2(Ref2);
	}
	if(key!=null && !"".equals(key) && !("null".equals(key)))
	{
		//out.println("**key**"+key);
		params.setKey("'"+key+"'");
	}

	if((CreatedOn1!=null && !"".equals(CreatedOn1) && !("null".equals(CreatedOn1))) && (CreatedOn2!=null && !"".equals(CreatedOn2) && !("null".equals(CreatedOn2))) )
	{
		params.setCreatedOn1("'"+CreatedOn1+"'");
		params.setCreatedOn2("'"+CreatedOn2+"'");
	}
	if((ModifiedOn1!=null && !"".equals(ModifiedOn1) &&!("null".equals(ModifiedOn1))) && (ModifiedOn1!=null && !"".equals(ModifiedOn1) &&!("null".equals(ModifiedOn1))))
	{
		params.setModifiedOn1("'"+ModifiedOn1+"'");
		params.setModifiedOn2("'"+ModifiedOn2+"'");
	}
	if(groupbykeys!=null)
	{
		params.setIsGroupBy("true");
		params.setGroupOn(groupbykeys);
	}

	mainParams.setObject(params);
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve listRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWFDocList(mainParams);
	//out.println("*******************FASDFASfasf********"+listRet);
	
	
	if(listRet.getRowCount() == 0)
	{
%>	
		<br><br><br>
		<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
		<Tr>
			<Th width="100%" align=center>
			No Documents to List
			</Th>
		</Tr>
		</Table>

<%		
	}
	else
	{
%>

		<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
		<Tr>
		<%
			for(int i=0;i<listRet.getColumnCount();i++)
			{
	
			 out.println("<Th>"+ listRet.getFieldName(i) + "</Th>");
			}
		
		out.println("</Tr>");
		for(int i=0;i<listRet.getRowCount();i++)
		{
	
		 	out.println("<Tr>");
			for(int j=0;j<listRet.getColumnCount();j++)
			{
			
				out.println("<Td>"+ listRet.getFieldValueString(i,listRet.getFieldName(j)) + "</Td>");
			}
			out.println("</Tr>");
		}
		
	}			
			

%>