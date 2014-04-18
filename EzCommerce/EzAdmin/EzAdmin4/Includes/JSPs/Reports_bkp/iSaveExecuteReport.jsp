<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.client.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "ezc.session.EzLogonStructure" %>
<%@ page import = "ezc.ezparam.EzLogonStatus" %>
<%@ page import = "ezc.ezparam.EzExecReportParams" %>
<%@ include file="../../Lib/AdminBean.jsp"%>
<%@ include file="../../Lib/ServerFunctions.jsp"%>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" />
<%

	//-------------REPORT PARAMS----------------------
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
	String system = request.getParameter("system");
String reportNo =request.getParameter("reportNo");
String reportName= request.getParameter("reportName");
String reportDesc= request.getParameter("reportDesc");
String reportType= request.getParameter("reportType");
String exeType= request.getParameter("exeType");
String visibility= request.getParameter("visibility");
String status= request.getParameter("status");

String execTC=request.getParameter("execTC");
exeType=("A".equals(exeType))?execTC:exeType;


String paramName[]= request.getParameterValues("paramName");
String paramNo[]= request.getParameterValues("paramNo");
String paramType[]= request.getParameterValues("paramType");
String paramDataType[]= request.getParameterValues("paramDataType");
String paramMulti[]= request.getParameterValues("paramMulti");
String lowValue[]= request.getParameterValues("lowValue");
String highValue[]= request.getParameterValues("highValue");
String paramIsDef[]= request.getParameterValues("paramIsDef");
String paramMod[]= request.getParameterValues("paramMod");
String paramOpt[]= request.getParameterValues("paramOpt");



StringTokenizer st = null;
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
			st=new StringTokenizer(paramMulti[i],"¤");
			String valColumns[]=new String[st.countTokens()];
			int j=0;
			while(st.hasMoreTokens())
			{
				valColumns[j]=st.nextToken();
				j++;
			}
			try
			{
				//for(int k=0;k<valColumns.length;k++) //for no of columns in each line
				//{
					st1=new StringTokenizer(valColumns[0],"µ");
					st2=new StringTokenizer(valColumns[1],"µ");
					st3=new StringTokenizer(valColumns[2],"µ");
					st4=new StringTokenizer(valColumns[3],"µ");
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
							 mn = low.substring(0,2);
							 dt = low.substring(3,5);
							 yr = low.substring(6,10);
							low=yr+mn+dt;
							}catch(Exception e){out.println(e);}
							if(high.trim().length() == 10)
							{
								try{
								// Set values for high if date
								mn = high.substring(0,2);
								dt = high.substring(3,5);
								yr = high.substring(6,10);
								high=yr+mn+dt;
								}catch(Exception e){out.println(e);}
							}

						}
						mode=("µ".equals(mode) || "N".equals(mode))?"I":mode;
						operator=("µ".equals(operator) || "N".equals(operator))?"EQ":operator;
						selectRow.setSelname(paramName[i]);
						selectRow.setLow(low);
						selectRow.setHigh(high);
						selectRow.setKind(paramType[i]);
						selectRow.setOption(mode);
						selectRow.setSign(operator);

						selectTable.appendRow(selectRow);
						selectRow = null;
					}
				}
			}catch(Exception e){}

			if(lowValue[i].trim().length()!=0 &&  !"µ".equals(lowValue[i]))
			{
				highValue[i]=("µ".equals(highValue[i]))?"":highValue[i];
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
							selectRow.setOption("I");
							selectRow.setSign("EQ");

							selectTable.appendRow(selectRow);
							selectRow = null;
						}
					}

				}else
				{

					if("DATS".equals(paramDataType[i]))
					{
						try{

							// Set values for low if date
							mn = lowValue[i].substring(0,2);
							dt = lowValue[i].substring(3,5);
							yr = lowValue[i].substring(6,10);
							lowValue[i]=yr+mn+dt;
						}catch(Exception e){}
						if(high.trim().length() == 10)
						{
							try{
								// Set values for high if date
								mn = highValue[i].substring(0,2);
								dt = highValue[i].substring(3,5);
								yr = highValue[i].substring(6,10);
								highValue[i]=yr+mn+dt;
							}catch(Exception e){out.println(e);}

						}
					}
					paramMod[i]=("µ".equals(paramMod[i]) || "N".equals(paramMod[i]))?"I":paramMod[i];
					paramOpt[i]=("µ".equals(paramOpt[i]) || "N".equals(paramOpt[i]))?"EQ":paramOpt[i];


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
		
		if("B".equals(exeType))
		{
			java.util.Date current = new java.util.Date();
			ezc.ezutil.FormatDate fd= new ezc.ezutil.FormatDate();
			String dat = fd.getStringFromDate(current,"/",ezc.ezutil.FormatDate.DDMMYYYY);
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

			String time= String.valueOf( current.getHours())+"."+String.valueOf( current.getMinutes())+"."+String.valueOf( current.getSeconds());
			String day =String.valueOf( current.getDay())+"."+String.valueOf( current.getMonth())+"."+String.valueOf( current.getYear());
			//out.println(day +"...." + time);
		
			selectRow = new EzReportTableRow();
			selectRow.setSelname("");
			selectRow.setLow("EZ_LIST_TITLE");
			selectRow.setHigh(reportName+Session.getUserId()+dat);
			selectRow.setKind("S");
			selectRow.setOption("");
			selectRow.setSign("");


			selectTable.appendRow(selectRow);
			selectRow = null;

			//Added by Suresh Parimi on 08272004 for Printer Selection Row
			
			selectRow = new EzReportTableRow();
			selectRow.setSelname("");
			selectRow.setLow("PRINTER_NAME");
			selectRow.setHigh("ZDUM");
			selectRow.setKind("S");
			selectRow.setOption("");
			selectRow.setSign("");

			selectTable.appendRow(selectRow);
			selectRow = null;
			
			selectRow = new EzReportTableRow();
			selectRow.setSelname("");
			selectRow.setLow("TARGET_SERVER");
			selectRow.setHigh("appl09_PRD_00");
			selectRow.setKind("S");
			selectRow.setOption("");
			selectRow.setSign("");

			selectTable.appendRow(selectRow);
			selectRow = null;
			
			//Addition ends here

			/*selectRow = new EzReportTableRow();
			selectRow.setSelname("");
			selectRow.setLow("EZ_EXE_TYPE");
			selectRow.setHigh(exeType);
			selectRow.setKind("");
			selectRow.setOption("");
			selectRow.setSign("");

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
			//out.println("Hi......");
			bexec =(ReturnObjFromRetrieve)rprtObj.executeReport(in);
			//out.println("HI" + bexec.toEzcString());
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
		out.println(e);
		//response.sendRedirect("../Htmls/Error.htm");
	}

	
	for(int i=0;i<selectTable.getRowCount();i++)
	{
		selectRow=(EzReportTableRow)selectTable.getRow(i);
		//out.println(selectRow.getSelname()+"----"+selectRow.getLow()+"-----"+selectRow.getHigh()+"----"+selectRow.getKind()+"----"+selectRow.getOption()+"-----"+selectRow.getSign()+"<br>");
	}
%>