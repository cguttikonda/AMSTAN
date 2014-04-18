
<%@ include file="../../Lib/EzWorkFlowBean.jsp"%>

<%
	String graphType=request.getParameter("graphType");
	String sysKey=request.getParameter("sysKey");
	String template=request.getParameter("template");
	String fromDate=request.getParameter("fromDate");
	String toDate=request.getParameter("toDate");
	String authKey=request.getParameter("authKey");
	String step=request.getParameter("step");
	String gNo=request.getParameter("NO");
	String fileName=session.getId();
	//out.println(	graphType +"<<<"+sysKey+"<<<"+template+"<<<"+fromDate+"<<<"+toDate+"<<<"+authKey+"<<<"+step+"<<<"+gNo+"<<<"+fileName);

	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWFDocHistoryParams params=new ezc.ezworkflow.params.EziWFDocHistoryParams();
	params.setAuthKey("'"+authKey+"'");
	params.setSysKey(sysKey);
	params.setTemplateCode(template);
	if("1".equals(gNo))
		params.setGraphNo(params.GRAPH1);
	else if("2".equals(gNo))
		params.setGraphNo(params.GRAPH2);
	else if("3".equals(gNo))
		params.setGraphNo(params.GRAPH3);
	else if("4".equals(gNo))
		params.setGraphNo(params.GRAPH4);	
	params.setModifiedOn1(fromDate);
	params.setModifiedOn2(toDate);
	mainParams.setObject(params);
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve infoRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWFDocHistory(mainParams);

    if(infoRet.getRowCount() == 0)
    {
%>    
	<br><br><br>
	<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
	<Tr>
		<Th width="100%" align=center>
		No data in selected region to show graph
		</Th>
	</Tr>
	</Table><br><center>
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
	</center>
<%    	
    }
    else
    {
	String[] colorsArr=new String[]{"#ff0000","#ffff00","#0000ff","#00ffff","#f0f0f0","#0f0f0f","#000fff","#ff0f0f","#f0fff0","#00ff00","#ff0000","#ffff00","#0000ff","#00ffff","#f0f0f0","#0f0f0f","#000fff","#ff0f0f","#f0fff0","#00ff00"};

	//pageContext.release();

	pageContext.setAttribute("TYPE",graphType);
	pageContext.setAttribute("TITLE",params.GRAPH1);
	pageContext.setAttribute("fileName",fileName+".jpg");
	int infoCount=infoRet.getRowCount();
	if(gNo.equals("1"))
	{
		//ezc.ezparam.ReturnObjFromRetrieve ret=new ezc.ezparam.ReturnObjFromRetrieve(new String[]{"DOCID","DELAY"});
    		ezc.ezparam.ReturnObjFromRetrieve legends=new ezc.ezparam.ReturnObjFromRetrieve(new String[]{"PARTICIPANT","COLOR"});	
    	
    		pageContext.setAttribute("X","STEPDESC");
		pageContext.setAttribute("Y","DOCCOUNT");
		pageContext.setAttribute("RETOBJ",infoRet);
		
		for(int i=0;i<infoCount;i++)
		{		
			legends.setFieldValue("PARTICIPANT",infoRet.getFieldValueString(i,"STEPDESC"));
			legends.setFieldValue("COLOR",colorsArr[i]);
			legends.addRow();
		}
		
		pageContext.setAttribute("LEGENDS",legends);
		pageContext.setAttribute("COLOR","COLOR");
		pageContext.setAttribute("PARTICIPANT","PARTICIPANT");
	}
	else if(gNo.equals("2"))
	{
		//ezc.ezparam.ReturnObjFromRetrieve ret=new ezc.ezparam.ReturnObjFromRetrieve(new String[]{"DOCID","DELAY","GROUP"});
    		ezc.ezparam.ReturnObjFromRetrieve legends=new ezc.ezparam.ReturnObjFromRetrieve(new String[]{"TEMPLATEDESC","PARTICIPANT","COLOR"});	
    		pageContext.setAttribute("X","STEPDESC");
    		pageContext.setAttribute("Y","DOCCOUNT");
    		pageContext.setAttribute("GROUP","TEMPLATEDESC");
    		pageContext.setAttribute("COLOR","COLOR");
    		pageContext.setAttribute("PARTICIPANT","PARTICIPANT");
    		pageContext.setAttribute("TITLE",params.GRAPH2);
    		pageContext.setAttribute("RETOBJ",infoRet);
    		
		for(int i=0;i<infoCount;i++)
		{
    			legends.setFieldValue("TEMPLATEDESC",infoRet.getFieldValueString(i,"TEMPLATEDESC"));
    			legends.setFieldValue("PARTICIPANT",infoRet.getFieldValueString(i,"STEPDESC"));
    			legends.setFieldValue("COLOR",colorsArr[i]);
	    		legends.addRow();
		}

    		/*legends.setFieldValue("TEMPLATEDESC","Field Service Request WF");
		legends.setFieldValue("PARTICIPANT","Customer");
		legends.setFieldValue("COLOR","#00ff00");
    		legends.addRow();
    		legends.setFieldValue("TEMPLATEDESC","Online Service Request WF");
		legends.setFieldValue("PARTICIPANT","Customer");
		legends.setFieldValue("COLOR","#ff0000");
    		legends.addRow();
    		legends.setFieldValue("TEMPLATEDESC","Online Service Request WF");
		legends.setFieldValue("PARTICIPANT","Engineer");
		legends.setFieldValue("COLOR","#00ff00");
    		legends.addRow();
		*/
    		
    		pageContext.setAttribute("LEGENDS",legends);
    	
	}
	if(gNo.equals("3"))
	{
		ezc.ezparam.ReturnObjFromRetrieve ret=new ezc.ezparam.ReturnObjFromRetrieve(new String[]{"DOCID","DELAY"});
    		ezc.ezparam.ReturnObjFromRetrieve legends=new ezc.ezparam.ReturnObjFromRetrieve(new String[]{"PARTICIPANT","COLOR"});	
    	
		legends.setFieldValue("PARTICIPANT","Customer");
		legends.setFieldValue("COLOR","#ffcc00");
		legends.addRow();
		legends.setFieldValue("PARTICIPANT","Manager");
		legends.setFieldValue("COLOR","#00ff00");
		legends.addRow();
		
		String docId=infoRet.getFieldValueString(0,"DOCID");
		java.util.Vector infoVect=new java.util.Vector();
		
		for(int i=0;i<infoCount;i++)
		{
			if(docId.equals(infoRet.getFieldValueString(i,"DOCID")))
			{
				infoVect.addElement(infoRet.getFieldValueString(i,"DELAY"));
			}
			else
			{
				ret.setFieldValue("DOCID",docId);
				ret.setFieldValue("DELAY",infoVect);
				ret.addRow();
				infoVect=new java.util.Vector();
				docId=infoRet.getFieldValueString(i,"DOCID");
				infoVect.addElement(infoRet.getFieldValueString(i,"DELAY"));
				
			}
		}
		ret.setFieldValue("DOCID",docId);
		ret.setFieldValue("DELAY",infoVect);
		ret.addRow();
		
		pageContext.setAttribute("X","DOCID");
		pageContext.setAttribute("Y","DELAY");
		pageContext.setAttribute("RETOBJ",ret); 
		pageContext.setAttribute("LEGENDS",legends);
		pageContext.setAttribute("COLOR","COLOR");
		pageContext.setAttribute("TITLE",params.GRAPH3);
	}
		
	
	
    }		
	      
      
%>	