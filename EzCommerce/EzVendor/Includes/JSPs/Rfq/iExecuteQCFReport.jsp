<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.client.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "ezc.session.EzLogonStructure" %>
<%@ page import = "ezc.ezparam.EzLogonStatus" %>
<%@ page import = "ezc.ezparam.EzExecReportParams" %>
<%@ include file="../../Lib/ServerFunctions.jsp"%>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" />
<%

	//-------------REPORT PARAMS----------------------
	String repCollRFQ=collNo;
	java.util.Vector repRFQVect=rfqVector;
	
	
	session.putValue("repCollRFQ",collNo);
	session.putValue("repRFQVect",rfqVector);
	
	
	String rfqStr1="";
	String rfqStr2="";
	String parammodStr="";
	String comoptionStr="";
	String isDefStr="";
	if(repRFQVect!=null && repRFQVect.size()>0){
		rfqStr1=(String)repRFQVect.get(0);
		for(int i=1;i<repRFQVect.size();i++){
			if("".equals(rfqStr2)){
				rfqStr2=(String)repRFQVect.get(i);
				parammodStr="I";
				comoptionStr="EQ";
				isDefStr="N";
			}else{
				rfqStr2 +=("�"+(String)repRFQVect.get(i));
				parammodStr +=("�"+"I");
				comoptionStr +=("�"+"EQ");
				isDefStr +=("�"+"N");
				
			}	
			
		}
		rfqStr2=(rfqStr2+"�"+isDefStr+"�"+parammodStr+"�"+comoptionStr);
	}
	
	EzReportInfoStructure repInfo = new EzReportInfoStructure();
	EzReportSelectTable repTable = new EzReportSelectTable();
	EzReportSelectRow repRow = null;

	EzReportTable selectTable = new EzReportTable();
	EzReportTableRow selectRow = null;
	//EzReportAsciiTable outTable = null;
        EzReportHtmlTable outTable = null;
	//ezc.ezsap.V46B.generated.ZrawtabTable outTable=null;
	EzExecReportParams repParams = null;

	EzExecReportParams in = new EzExecReportParams();
	EzReportManager rprtObj = new EzReportManager();
	
	ReturnObjFromRetrieve bexec=null;

	// Prepare Parameters from Session Object
	Session.prepareParams(in);
	//-------------END REPORT PARAMS----------------------

	// Get the input parameters
	
	String system ="999";
	String reportNo ="944";
	String reportName="ZMRQCF99";
	String reportDesc="ZMRQCF99_NEW";
	String reportType="2";
	String exeType= "O";
	String visibility= request.getParameter("visibility");
	String status= request.getParameter("status");


	System.out.println("reportNo="+reportNo);
	System.out.println("reportName="+reportName);
	System.out.println("reportDesc="+reportDesc);
	System.out.println("reportType="+reportType);
	System.out.println("exeType="+exeType);
	System.out.println("visibility="+visibility);
	System.out.println("status="+status);


String execTC=request.getParameter("execTC");
exeType=("A".equals(exeType))?execTC:exeType;


String paramName[]= new String[]{"P_EKORG","P_MATNR","P_SUBMI","P_EBELN","P_LIFNR"};
String paramNo[]= {"1","2","3","4","5"};
String paramType[]= new String[]{"P","P","P","S","S"};
String paramDataType[]= new String[]{"C,,,,","C,,,,","C,,,,","C,,,,","C,,,,"};
String paramMulti[]= new String[]{"���","���","���",rfqStr2,"���"};
String lowValue[]= new String[]{"1000","",repCollRFQ,rfqStr1,""};
String highValue[]= new String[]{"","","","",""};
String paramIsDef[]= new String[]{"N","N","N","N","N"};
String paramMod[]= new String[]{"I","�","I","I","�"};
String paramOpt[]= new String[]{"EQ","�","EQ","EQ","�"};

for(int i=0;i<paramDataType.length;i++)
{
	System.out.println("paramName===="+paramName[i]);
	//System.out.println("paramNo===="+paramNo[i]);
	System.out.println("paramType===="+paramType[i]);
	System.out.println("paramDataType===="+paramDataType[i]);
	System.out.println("paramMulti===="+paramMulti[i]);
	System.out.println("lowValue===="+lowValue[i]);
	System.out.println("highValue===="+highValue[i]);
	System.out.println("paramIsDef===="+paramIsDef[i]);
	System.out.println("paramMod===="+paramMod[i]);
	System.out.println("paramOpt===="+paramOpt[i]);
}	

StringTokenizer st0 = null;
StringTokenizer st1 = null;
StringTokenizer st2 = null;
StringTokenizer st3 = null;
StringTokenizer st4 = null;

String low,operator,mode,high="";

	try
	{
		String yr,mn,dt="";
		for(int i=0;i<paramName.length;i++)
		{
			st0=new StringTokenizer(paramMulti[i],"�");
			String valColumns[]=new String[st0.countTokens()];
			int j=0;
			while(st0.hasMoreTokens())
			{
				valColumns[j]=st0.nextToken();
				j++;
			}
			try
			{
				//for(int k=0;k<valColumns.length;k++) //for no of columns in each line
				//{
					st1=new StringTokenizer(valColumns[0],"�");
					st2=new StringTokenizer(valColumns[1],"�");
					st3=new StringTokenizer(valColumns[2],"�");
					st4=new StringTokenizer(valColumns[3],"�");
				//}

				while(st1.hasMoreTokens())
				{
					low=st1.nextToken();
					try{
						high=st2.nextToken();
					}catch(Exception e){high="";}
					try
					{
						mode=st3.nextToken();
					}catch(Exception e){mode="I";}
					try{
					operator=st4.nextToken();
					}catch(Exception e){operator="EQ";}

					high=("N".equals(high))?"":high;

					if(!"N".equals(low))
					{
						selectRow = new EzReportTableRow();
		
						if(paramDataType[i].startsWith("D"))       
						{
					
							try{
							// Set values for low if date
							 dt = low.substring(0,2);
							 mn = low.substring(3,5);
							 yr = low.substring(6,10);
							low=yr+mn+dt;
							}catch(Exception e){out.println(e);}
							if(high.trim().length() == 10)
							{
								try{
								// Set values for high if date
								dt = low.substring(0,2);
								mn = low.substring(3,5);
							 	yr = low.substring(6,10);
								high=yr+mn+dt;
								}catch(Exception e){out.println(e);}
							}

						}
						mode=("�".equals(mode) || "N".equals(mode))?"I":mode;
						operator=("�".equals(operator) || "N".equals(operator))?"EQ":operator;
						selectRow.setSelname(paramName[i]);
						selectRow.setLow(low);
						selectRow.setHigh(high);
						selectRow.setKind(paramType[i]);
						selectRow.setOption(operator);
						selectRow.setSign(mode);

						selectTable.appendRow(selectRow);
						selectRow = null;
					}
				}
			}catch(Exception e){}

			if(lowValue[i].trim().length()!=0 &&  !"�".equals(lowValue[i]))
			{
				highValue[i]=("�".equals(highValue[i]))?"":highValue[i];
				///out.println("paramIsDef[i]"+paramIsDef[i]);
				if("Y".equals(paramIsDef[i]))
				{
					////out.println("lowValue[i]"+lowValue[i]);
					st1=new StringTokenizer(lowValue[i],",");
					String wast="";
					while(st1.hasMoreTokens())
					{
						wast=st1.nextToken();
						if(wast.trim().length()!=0)
						{
							selectRow = new EzReportTableRow();

							selectRow.setSelname(paramName[i]);
							selectRow.setLow(wast);
							selectRow.setHigh(highValue[i]);
							selectRow.setKind(paramType[i]);
							selectRow.setOption("EQ");
							selectRow.setSign("I");

							selectTable.appendRow(selectRow);
							selectRow = null;
						}
					}

				}else
				{
					// Commented by Venkat Sanampudi to change the entered date format
					//if("DATS".equals(paramDataType[i]))
					//if("DATES".equals(paramName[i]))	
					if(paramDataType[i].startsWith("D"))
					{
						try{
							// Set values for low if date
							mn = lowValue[i].substring(3,5);
							dt = lowValue[i].substring(0,2);
							yr = lowValue[i].substring(6,10);
							lowValue[i]=yr+mn+dt;
						}catch(Exception e){}
						// Commented by Venkat Sanampudi to change the entered date format
						//if(high.trim().length() == 10)
						if(highValue[i].trim().length() == 10)
						{
							try{
								// Set values for high if date
								mn = highValue[i].substring(3,5);
								dt = highValue[i].substring(0,2);
								yr = highValue[i].substring(6,10);
								highValue[i]=yr+mn+dt;
							}catch(Exception e){out.println(e);}

						}
					}
					paramMod[i]=("�".equals(paramMod[i]) || "N".equals(paramMod[i]))?"I":paramMod[i];
					paramOpt[i]=("�".equals(paramOpt[i]) || "N".equals(paramOpt[i]))?"EQ":paramOpt[i];

					
					// This block is added by Sanapudi temporarly for provideng month option in Performance Chart Report
					if("SL_SPMON".equals(paramName[i]))
					{
						if(lowValue[i].indexOf(".")==2)
						{
							mn = lowValue[i].substring(0,2);
							yr = lowValue[i].substring(3,7);
						}
						else
						{
							yr = lowValue[i].substring(0,4);
							mn = lowValue[i].substring(5,7);
						}
						lowValue[i]=yr+mn;
						
						if(highValue[i].trim().length() == 7)
						{
							if(highValue[i].indexOf(".")==2)
							{
								mn = highValue[i].substring(0,2);
								yr = highValue[i].substring(3,7);
							}
							else
							{
								yr = highValue[i].substring(0,4);
								mn = highValue[i].substring(5,7);
							}
							highValue[i]=yr+mn;
						}
					}
					////////// Block ends here


					selectRow = new EzReportTableRow();
	
					selectRow.setSelname(paramName[i]);
					selectRow.setLow(lowValue[i]);
					selectRow.setHigh(highValue[i]);
					selectRow.setKind(paramType[i]);
					selectRow.setOption(paramOpt[i]);
					selectRow.setSign(paramMod[i]);
					selectTable.appendRow(selectRow);
					selectRow = null;
			
		
				}

			}

		}
		/*selectRow = new EzReportTableRow();
		selectRow.setSelname("");
		selectRow.setLow("EZ_LIST_NAME");
		selectRow.setHigh("SURESH1");
		selectRow.setKind("");
		//selectRow.setOption();
		//selectRow.setSign();

		selectTable.appendRow(selectRow);
		selectRow = null;*/
		if("B".equals(exeType))
		{
			java.util.Date current = new java.util.Date();
			ezc.ezutil.FormatDate fd1= new ezc.ezutil.FormatDate();
			String dat = fd1.getStringFromDate(current,"/",ezc.ezutil.FormatDate.DDMMYYYY);
			java.text.SimpleDateFormat sdf =new java.text.SimpleDateFormat("HH:mm:ss");

			String email ="";


			ReturnObjFromRetrieve retUserData = null;
			EzcUserParams uparams= new EzcUserParams();

			uparams.setUserId(Session.getUserId());
			EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
			ezcUserNKParams.setLanguage("EN");
			uparams.createContainer();
			uparams.setObject(ezcUserNKParams);
			Session.prepareParams(uparams);
			try{
			retUserData = (ReturnObjFromRetrieve)UserManager.getUserData(uparams);
			retUserData.check();
			email = retUserData.getFieldValueString(0,"EU_EMAIL");
			}catch(Exception e){}

			//String time= String.valueOf( current.getHours())+"."+String.valueOf( current.getMinutes())+"."+String.valueOf( current.getSeconds());
			//String day =String.valueOf( current.getDay())+"."+String.valueOf( current.getMonth())+"."+String.valueOf( current.getYear());
			selectRow = new EzReportTableRow();
			selectRow.setSelname("");
			selectRow.setLow("EZ_LIST_TITLE");
			selectRow.setHigh(reportName+Session.getUserId()+dat);
			selectRow.setKind("S");
			selectRow.setOption("");
			selectRow.setSign("");


			selectTable.appendRow(selectRow);
			selectRow = null;

			/*selectRow = new EzReportTableRow();
			selectRow.setSelname("");
			selectRow.setLow("EZ_EXE_TYPE");
			selectRow.setHigh(exeType);
			selectRow.setKind("");
			//selectRow.setOption();
			//selectRow.setSign();

			selectTable.appendRow(selectRow);
			selectRow = null;*/
			EzReportParams ezreportparams= new EzReportParams();

			EzReportExecStoreStructure exestore = new EzReportExecStoreStructure();
			exestore.setReportNo(reportNo);
			exestore.setSystemNo(system);
			///in.setCounter();
			exestore.setSpoolNo(" ");
			exestore.setUserId(Session.getUserId());
			exestore.setCreationDate(dat);
			exestore.setCreationTime(sdf.format(current));
			exestore.setReportPath(" ");
			exestore.setViewFlag("N");
			exestore.setEmail(email);
			exestore.setReportFormat(" ");
			exestore.setExt1(" ");
			exestore.setExt2(" ");

			ezreportparams.setReportExecStore(exestore);
			in.setReportParams(ezreportparams);
		}

		in.setIsWithCustomer(false);
		in.setReportName(reportName);
		in.setSelTable(selectTable);
		in.setSystemNo(system);
		in.setSysNum(system);	// for fill call
		in.setExecutionType(exeType);


		if("B".equals(exeType))
		{
			//bexec =(ReturnObjFromRetrieve)rprtObj.executeReport(in);
		}else
		{
			//outTable = (EzReportAsciiTable)rprtObj.executeReport(in);
                        outTable  = (EzReportHtmlTable) rprtObj.executeReport(in);
		}
		//outTable=(ezc.ezsap.V46B.generated.ZrawtabTable)rprtObj.executeReport(in);
		
		

	}
	catch(Exception e)
	{
		e.printStackTrace();
		//out.println(e);
		//response.sendRedirect("../Htmls/Error.htm");
	}

	
	/*for(int i=0;i<selectTable.getRowCount();i++)
	{
		selectRow=(EzReportTableRow)selectTable.getRow(i);
		out.println(selectRow.getSelname()+"----"+selectRow.getLow()+"-----"+selectRow.getHigh()+"----"+selectRow.getKind()+"----"+selectRow.getOption()+"-----"+selectRow.getSign()+"<br>");
	}*/
%>
