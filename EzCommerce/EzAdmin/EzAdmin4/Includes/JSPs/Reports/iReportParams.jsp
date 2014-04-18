<%
	ezc.ezbasicutil.EzDefaults def = new ezc.ezbasicutil.EzDefaults(Session);
	ReturnObjFromRetrieve repDefaults =null;
	int repDefaultsCount =0;


	String system = request.getParameter("system");
	String sysDesc =request.getParameter("sysDesc");
	String reportDomain =request.getParameter("reportDomain");
	String reportName= request.getParameter("reportName");
	String reportDesc= request.getParameter("reportDesc");
	String reportType= request.getParameter("reportType");
	String exeType= request.getParameter("exeType");
	String visibility= request.getParameter("visibility");
	String status= request.getParameter("status");


	String paramName[]= request.getParameterValues("paramName");
	String paramDesc[]= request.getParameterValues("paramDesc");
	String paramIsSel[]= request.getParameterValues("paramIsSel");
	String paramIshide[]= request.getParameterValues("paramIshide");
	String paramLen[]= request.getParameterValues("paramLen");
	String paramType[]= request.getParameterValues("paramType");
	String paramDataType[]= request.getParameterValues("paramDataType");
	String paramIsmand[]= request.getParameterValues("paramIsmand");
	String paramIsDef[]= request.getParameterValues("paramIsDef");
	String paramMethod[]= request.getParameterValues("paramMethod");
	
	
	
	
	
	String displayrow="";
	
	String RETREIVE_CONDITION1="",RETREIVE_CONDITION2="",RETREIVE_CONDITION3="";
	String OPERATOR_CONDITION1="",OPERATOR_CONDITION2="",OPERATOR_CONDITION3="";
	
	
	String chkDataType = "", checkBoxType = "checkbox",checkBoxName = "",noDisplay  = "",defaultValue = "";
	String  checked="";
	String defaultCheckValue="";
	
	String mandcolor="",mandscript="";
	String retreiveMode = "",operator="",from="",to="";
	
	

	int paramCount=0;
	if(paramName != null)
	paramCount=paramName.length;
	
	
	
	
	
	

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



	//////// Condition Based HashTables
	Hashtable retreiveModeHash = new Hashtable();
	Hashtable operatorHash = new Hashtable();
	



	// Retreive Mode Hashtable
	
	String[][] modeList = {{"I","Include"},{"E","Exclude"}};
	int modeListC=modeList.length;


	RETREIVE_CONDITION1 = "<select name='paramMod' id='ListBoxDiv'>";
	for(int mo=0;mo<modeListC;mo++)
		RETREIVE_CONDITION1 += "<option value='"+modeList[mo][0]+"'>"+modeList[mo][1]+"</option>"; 
	RETREIVE_CONDITION1 += "</select>";

	RETREIVE_CONDITION2 = "<input type='hidden' name='paramMod' value='I'>Include";
	RETREIVE_CONDITION3 = "<input type='hidden' name='paramMod' value='I'>";


	retreiveModeHash.put("Condition1",RETREIVE_CONDITION1);
	retreiveModeHash.put("Condition2",RETREIVE_CONDITION2);
	retreiveModeHash.put("Condition3",RETREIVE_CONDITION3);


	//Operator Hashtable
	String[][] operatorList = {{"EQ","="},{"GT",">"},{"LT","<"},{"NE","!="},{"LE","<="},{"GE",">="},{"BT","BT"}};
	int operatorListC=operatorList.length;

	

	OPERATOR_CONDITION1 = "<select name='paramOpt' id='ListBoxDiv'>";
	for(int op=0;op<operatorListC;op++)
		OPERATOR_CONDITION1 += "<option value='"+operatorList[op][0]+"'>"+operatorList[op][1]+"</option>";
	OPERATOR_CONDITION1 += "</select>";

	OPERATOR_CONDITION2 = "<input type='hidden' name='paramOpt' value='EQ'>=";
	OPERATOR_CONDITION3 = "<input type='hidden' name='paramOpt' value='EQ'>";


	operatorHash.put("Condition1",OPERATOR_CONDITION1);
	operatorHash.put("Condition2",OPERATOR_CONDITION2);
	operatorHash.put("Condition3",OPERATOR_CONDITION3);


	
	
	ReturnObjFromRetrieve finalReturnObject = new ReturnObjFromRetrieve();
	
	finalReturnObject.addColumn("DESCRIPTION");
	finalReturnObject.addColumn("RETREIVE_MODE");
	finalReturnObject.addColumn("OPERATOR");
	finalReturnObject.addColumn("FROM");
	finalReturnObject.addColumn("TO");
	finalReturnObject.addColumn("MULTIPLE");
	finalReturnObject.addColumn("DISPLAY_ROW");

	
	
	boolean IS_DEFAULT = false;
	boolean IS_PARAM= false;
	boolean IS_MANDATORY= false;
	boolean IS_DATE=false;
	
	
	;
					
	
	
	for(int i=0;i<paramCount;i++)
	{
		 IS_DEFAULT = "Y".equals(paramIsDef[i]);
		 IS_PARAM="P".equals(paramType[i]);
		 IS_MANDATORY="X".equals(paramIsmand[i]);
		 IS_DATE=paramDataType[i].startsWith("D");

		if(IS_DEFAULT)
		{
			try
			{
				repDefaults =def.getDefaultValues(paramMethod[i]);
			}
			catch(Exception e)
			{
				repDefaults=new ReturnObjFromRetrieve();
			}
			repDefaultsCount =repDefaults.getRowCount();
		}

		
		ezc.ezbasicutil.EzStringTokenizer chkToken = new ezc.ezbasicutil.EzStringTokenizer(paramDataType[i],",");
		Vector myTokens= chkToken.getTokens();
		int myTokensSize = myTokens.size();
		chkDataType = (String)myTokens.get(0);
		checkBoxType = (String)myTokens.get(1);
		noDisplay  = (String)myTokens.get(3);
		if(myTokensSize == 5)
			defaultValue = (String)myTokens.get(4);



		


		
		
		if(paramDesc[i].length() == 0)
		{
			finalReturnObject.setFieldValue("DESCRIPTION","&nbsp;");	
		}	
		else
			finalReturnObject.setFieldValue("DESCRIPTION",paramDesc[i]);
			
		
		
		

		if( (!(IS_PARAM && "1".equals(paramLen[i]))) && (!(IS_DEFAULT )))
			retreiveMode = (String)retreiveModeHash.get("Condition1");
		else if((IS_DEFAULT))
			retreiveMode = (String)retreiveModeHash.get("Condition2");
		else
			retreiveMode = (String)retreiveModeHash.get("Condition3");


		finalReturnObject.setFieldValue("RETREIVE_MODE",retreiveMode);




		if( (!(IS_PARAM && "1".equals(paramLen[i]))) && (!(IS_DEFAULT )))
			operator = (String)operatorHash.get("Condition1");
		else if((IS_DEFAULT))
			operator = (String)operatorHash.get("Condition2");
		else
			operator = (String)operatorHash.get("Condition3");


		finalReturnObject.setFieldValue("OPERATOR",operator);
		

		if(IS_DEFAULT)
		{
			if(repDefaultsCount ==1)
				from = fromCondition1(repDefaults.getFieldValueString(0,"DEF_VALUE"));
			else if(repDefaultsCount==0)
				from = fromCondition1(repDefaults.getFieldValueString(0,"null"));
			else 
				from = fromCondition2(i,repDefaults);
		}
		else
		{
			if(IS_DATE)
				from = fromCondition3(i,paramLen[i]);
			else if(IS_PARAM && "1".equals(paramLen[i]))
			{
				
				
				if("R".equals(checkBoxType))
				{
					checkBoxType = "radio";
					checkBoxName = (String)myTokens.get(2);
					displayrow = "DISPLAY";
				}	
				else 
				{
					if("X".equals(noDisplay))
					{
						checkBoxType = "hidden";
						displayrow = "NODISPLAY";
					}	
					else
					{
						checkBoxType = "checkbox";	
						displayrow = "DISPLAY";
					}	

					checkBoxName = "lowValue1";	
				}	




				if( "X".equals(defaultValue))
				{
					checked = "checked";
					defaultCheckValue="X";
				}
				else
				{
					checked = "";
					defaultCheckValue="µ";
				}


				from = fromCondition4(checkBoxType,checkBoxName,checked,defaultCheckValue,i);
			}
			else
			{
				if(IS_MANDATORY || "L".equals(paramIsmand[i]))
					mandscript = mandscript;
				else
					mandscript = "onblur='validate(\""+chkDataType+"\",this,"+i+")'";

				from = fromCondition5(i,mandscript,paramLen[i]);
			}

		}

		finalReturnObject.setFieldValue("FROM",from);
		finalReturnObject.setFieldValue("DISPLAY_ROW",displayrow);




		if("S".equals(paramType[i]) && (!IS_DEFAULT))
		{
			if(IS_DATE)
				to = toCondition1(i);
			else
				to = toCondition2(i,true,paramLen[i],chkDataType);
		}
		else
				to = toCondition2(i,false,paramLen[i],chkDataType);
				
				
		finalReturnObject.setFieldValue("TO",to);
		
		
		String multiple="";
		if((IS_PARAM && "1".equals(paramLen[i])) || (IS_DEFAULT ))
			multiple= "&nbsp;";
		else
			multiple= "<a href='JavaScript:ezOpenWindow("+i+")' name='Multi'>Click</a>";
			
		finalReturnObject.setFieldValue("MULTIPLE",multiple);
		
		finalReturnObject.addRow();
	}	
	
	
	int returnRowCount = finalReturnObject.getRowCount();
		
%>













<%!

	private String fromCondition1(String repDefaultValue)
	{
		String FROMCONDITION = "<input type='hidden' name='lowValue'";
		if("null".equals(repDefaultValue))
			FROMCONDITION += " value='null'>";
		else
			FROMCONDITION += " value="+repDefaultValue+">"+repDefaultValue;
		return FROMCONDITION;
	}
	
	
	private String fromCondition2(int i,ReturnObjFromRetrieve repDefaults)
	{
		int repDefaultsCount = repDefaults.getRowCount();
		String FROMCONITION = "<select name='lowValue1' size='2' multiple id=ListBoxDiv onChange=setSelLow(this,"+i+")>";
		for(int k=0;k<repDefaultsCount;k++)
			FROMCONITION += "<option value="+repDefaults.getFieldValueString(k,"DEF_VALUE")+">"+repDefaults.getFieldValueString(k,"DEF_VALUE")+"</option>";
		FROMCONITION += "</select>";
		FROMCONITION += "<input type='hidden' name='lowValue' value='µ'>";
		return FROMCONITION;
	}
	
	private String fromCondition3(int i,String size)
	{
		String FROMCONDITION = "";
		FROMCONDITION += "<input type='text' name='lowValue' class = 'InputBox' size='"+size+"' maxlength='"+size+"' readonly>";
		FROMCONDITION += "<a href='javascript:showCal(\"document.addForm.lowValue["+i+"]\",50,150)'>"; 
		FROMCONDITION += "<img border=no style='cursor:hand' src='../../Library/JavaScript/calender.gif' alt='Calender' align='middle'>";
		FROMCONDITION += "</a>";
		return FROMCONDITION;
	}
	
	private String fromCondition4(String checkBoxType,String checkBoxName,String checked,String defaultCheckValue,int i)
	{
		String FROMCONDITION = "";
		FROMCONDITION += "<input type="+checkBoxType+" name='"+checkBoxName+"' "+checked+" onClick='setLowVal(this,"+i+")'>";
		FROMCONDITION += "<input type='hidden' name='lowValue' value="+defaultCheckValue+">";
		return FROMCONDITION;
	}
	
	private String fromCondition5(int i,String mandScript,String size)
	{
		String FROMCONDITION = "";
		FROMCONDITION = "<input type='text' name='lowValue' class = 'InputBox' size='"+size+"' maxlength='"+size+"' "+mandScript+">";
		return FROMCONDITION;
	}



	private String toCondition1(int i)
	{
		String TOCONDITION = "";
		TOCONDITION += "<input type='text' name='highValue' class = 'InputBox' size='10' readonly>";
		TOCONDITION += "<a href='javascript:showCal(\"document.addForm.highValue["+i+"]\",50,150)'>"; 
		TOCONDITION += "<img border=no style='cursor:hand' src='../../Library/JavaScript/calender.gif' alt='Calender' align='middle'>";
		TOCONDITION += "</a>";
		return TOCONDITION;
	}
	private String toCondition2(int i,boolean sendExt,String size,String dataType)
	{
		String TOCONDITION="";
		if(sendExt == true)
			TOCONDITION += "<input type='text' name='highValue' class = 'InputBox' size='"+size+"' maxlength='"+size+"' onblur='validate(\""+dataType+"\",this,"+i+")'>";
		else
			TOCONDITION += "<input type='hidden' name='highValue' value='µ'>&nbsp;";
		return TOCONDITION;
	}
%>




