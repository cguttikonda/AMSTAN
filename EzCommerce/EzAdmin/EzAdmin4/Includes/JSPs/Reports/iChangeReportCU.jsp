<%
	// this part of code is if all the fields are hidden fields then no need to display the page can redirect the page to execution
	boolean redirect =false;
	String chkHiddRed="";
	java.util.Vector toBeChkVect=new java.util.Vector();
	
	if(retSelTabCount>0)
	{
		for(int i=0;i<retSelTabCount;i++)
		{	
			ezRepSelTableRow=(EzReportSelectRow)ezRepSelTable.getRow(i);
			chkHiddRed=ezRepSelTableRow.getIsHidden();
			if("N".equals(chkHiddRed))
			{
				redirect=true;
				break;
			}
		}
	}
	// ends here


	Hashtable domainsDescHash= new Hashtable();
	domainsDescHash.put("1","Sales");
	domainsDescHash.put("2","Vendor");
	domainsDescHash.put("3","Service");
	domainsDescHash.put("4","ReverseAuction");


	Hashtable reportsDescHash= new Hashtable();
	reportsDescHash.put("1","On-Line");
	reportsDescHash.put("2","Back End");
	
	Hashtable exeDescHash= new Hashtable();
	exeDescHash.put("O","On-Line");
	exeDescHash.put("B","Back Ground");
	exeDescHash.put("A","Both");

	Hashtable visibleDescHash= new Hashtable();
	visibleDescHash.put("I","Internal Users");
	visibleDescHash.put("B","Business users");
	visibleDescHash.put("A","All");

	Hashtable statusDescHash= new Hashtable();
	statusDescHash.put("A","Active");
	statusDescHash.put("I","In Active");




	ezc.ezbasicutil.EzDefaults def = new ezc.ezbasicutil.EzDefaults(Session);
	ReturnObjFromRetrieve repDefaults =null;
	int repDefaultsCount =0;



	String reportDomain =request.getParameter("reportDomain");
	String sysDesc =request.getParameter("sysDesc");
	String reportDesc ="";
	String reportType ="";
	String exeType = "";
	String visibility ="";
	String status ="";
	
	if(ezRepInfoStruct != null)
	{
		reportDesc =ezRepInfoStruct.getReportDesc();
		reportType =ezRepInfoStruct.getReportType();
		exeType = ezRepInfoStruct.getExecType();
		visibility =ezRepInfoStruct.getVisibilityLevel();
		status =ezRepInfoStruct.getReportStatus();
		reportDomain =ezRepInfoStruct.getBusinessDomain();
	}
%>


<%!
	private String getRetrieveMode(String paramMode,int condition)
	{
		
		String RETREIVE_CONDITION="";
		
		if(condition == 1)
		{
			String[][] modeList = {{"I","Include"},{"E","Exclude"}};
			int modeListC=modeList.length;

			RETREIVE_CONDITION = "<select name='paramMod' id='ListBoxDiv'>";
			for(int mo=0;mo<modeListC;mo++)
			{	
				if(paramMode.equals(modeList[mo][0]))
					RETREIVE_CONDITION += "<option selected value='"+modeList[mo][0]+"'>"+modeList[mo][1]+"</option>"; 
				else
					RETREIVE_CONDITION += "<option value='"+modeList[mo][0]+"'>"+modeList[mo][1]+"</option>"; 
			}	
			RETREIVE_CONDITION += "</select>";
		}	
		else if(condition == 2)
		{
			RETREIVE_CONDITION = "<input type='hidden' name='paramMod' value='I'>Include";
		}	
		else 
			RETREIVE_CONDITION = "<input type='hidden' name='paramMod' value='I'>";
		return RETREIVE_CONDITION;
	}
	
	
	private String getOperatorMode(String operatorMode,int condition)
	{
		String OPERATOR_CONDITION = "";
		if(condition == 1)
		{
			String[][] operatorList = {{"EQ","="},{"GT",">"},{"LT","<"},{"NE","!="},{"LE","<="},{"GE",">="},{"BT","BT"}};
			int operatorListC=operatorList.length;
			
			
			OPERATOR_CONDITION = "<select name='paramOpt' id='ListBoxDiv'>";
			for(int op=0;op<operatorListC;op++)
			{
				if(operatorMode.equals(operatorList[op][0]))
					OPERATOR_CONDITION += "<option selected value='"+operatorList[op][0]+"'>"+operatorList[op][1]+"</option>";
				else
					OPERATOR_CONDITION += "<option value='"+operatorList[op][0]+"'>"+operatorList[op][1]+"</option>";
			}	
			OPERATOR_CONDITION += "</select>";
		}
		else if(condition == 2)
			OPERATOR_CONDITION = "<input type='hidden' name='paramOpt' value='EQ'>=";
		else
			OPERATOR_CONDITION = "<input type='hidden' name='paramOpt' value='EQ'>";
		return OPERATOR_CONDITION;
	}
	
	
	private String getFromField(String lowDefaultValue)
	{
		return "<input type=hidden name=lowValue value='"+lowDefaultValue+"'>";
	}
	
	private String getFromField(String lowDefaultValue,ReturnObjFromRetrieve reportDefaults,int i)
	{
		String FROM_CONDITION="",defvalue="";
		int reportDefaultCount = reportDefaults.getRowCount();
		
		ArrayList al = new ArrayList();
		try{
			StringTokenizer st1=new StringTokenizer(lowDefaultValue,",");
			while(st1.hasMoreTokens())
			{
				al.add(st1.nextToken());
			}
		}catch(Exception e){}
		
		FROM_CONDITION = "<select name='lowValue1' size='2' multiple id=ListBoxDiv onChange=setSelLow(this,"+i+")>";
		for(int k=0;k<reportDefaultCount;k++)
		{
			defvalue=reportDefaults.getFieldValueString(k,"DEF_VALUE");
			if(al.contains(defvalue))
				FROM_CONDITION += "<option selected value="+defvalue+">"+defvalue+"</option>";
			else
				FROM_CONDITION += "<option value="+defvalue+">"+defvalue+"</option>";
		}	
		FROM_CONDITION += "</select>";
		FROM_CONDITION += "<input type='hidden' name='lowValue' value='"+lowDefaultValue+"'>";
		return FROM_CONDITION;
	}
	
	private String getFromField(String lowDefaultValue,String lowValue,int condition,int i,String size,String mandScript)
	{
		String FROM_CONDITION="";
		if(condition == 1)
		{
			FROM_CONDITION = "<input type='text' name='lowValue' class='InputBox' readonly style='width:100%' value='"+lowDefaultValue+"' nowrap >";
			FROM_CONDITION += "<a href='javascript:showCal(\"document.addForm.lowValue["+i+"]\",200,650)'><img border=no style='cursor:hand' src='../../Library/JavaScript/calender.gif' alt='Calender' align='middle'></a>";	
		}	
		else if(condition == 3)
		{
			FROM_CONDITION = "<input type='text' name='lowValue' class = 'InputBox'  style = 'width:100%' maxlength='"+size+"' "+mandScript+" value="+lowDefaultValue+">";
		}
		return FROM_CONDITION;
	}
	
	
	private String getFromCheckField(String checkboxType,String checkboxName,String checked,String checkBoxValue,int i)
	{
		String indexString = "";
		if("radio".equals(checkboxType))	
		{
			indexString = "ezLowIndex="+i;
			checked="checked";
		}		
		else
			indexString = "";
		String FROM_CONDITION = "<input type='"+checkboxType+"' name='"+checkboxName+"' "+checked+" onClick='setLowVal(this,"+i+")' "+indexString+">";
		FROM_CONDITION += "<input type='hidden' name='lowValue' value='"+checkBoxValue+"'>";
		return FROM_CONDITION;
	}
	
	private String getToField(String highDefaultValue,int condition,int i,String size,char paramDataType)
	{
		String TO_CONDITION = "";
		if(condition == 1)
		{
			TO_CONDITION  = "<input type='text' name='highValue' class = 'InputBox' readonly style = 'width:100%'   value='"+highDefaultValue+"' nowrap>";
			TO_CONDITION  += "<a href='javascript:showCal(\"document.addForm.highValue["+i+"]\",200,650)'><img border=no style='cursor:hand' src='../../Library/JavaScript/calender.gif' alt='Calender' align='middle'></a>";
		}
		else if(condition == 2)
		{
			TO_CONDITION = "<input type='text' name='highValue' class='InputBox'  style='width:100%' maxlength='"+size+"' onblur='validate(\""+paramDataType+"\",this,"+i+")' value="+highDefaultValue+">";
		}
		else 
		{
			TO_CONDITION = "<input type='hidden' name='highValue' value='µ'>";
		}
		return TO_CONDITION;
	}
%>