<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ page import = "java.util.*" %>
<%@ include file="../../../Includes/JSPs/Reports/iChangeReport.jsp"%>
<%@ include file="../../../Includes/JSPs/Reports/iChangeReportCU.jsp"%>
<Html>
<Head>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<Script>
	var tabHeadWidth=90
	var tabHeight="65%"
</Script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<Script src="../../Library/JavaScript/ezTrim.js"></Script>
<Script>
	function goHome()
	{
		document.addForm.action  = "../Misc/ezSBUWelcome.jsp";
		document.addForm.submit()
	}
	function ezChkValid()
	{
		var flag=false;
<%
		for(int i=0;i<toBeChkVect.size();i++)
		{
%>
			if( !chkMand("<%=toBeChkVect.elementAt(i)%>"))
			{
<%
				i=toBeChkVect.size();
%>
				flag=true;
			}
<%
		}
%>
	return !flag;
	}
</Script>
<Script src="../../Library/JavaScript/Reports/ezChangeReportCU.js"></Script> 
</Head>
<Body onLoad="scrollInit()" onresize="scrollInit()" scroll=no>
<Form name="addForm" method="post">
<%--<input type="hidden" name="FromPage" value="B">--%>
<%
	if(redirect)
	{
%>
		<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr align="center">
			<Td class="displayheader">Execute Report <%=reportDesc%></Td>
		</Tr>
		</Table>
<%
	}
%>
<% 
	if(ezRepInfoStruct != null)
   	{
%>
		<input type="hidden" name="system" value="<%=system%>">
		<input type="hidden" name="reportDesc" value="<%=reportDesc%>">
		<input type="hidden" name="reportDomain" value="<%=reportDomain%>">
		<input type="hidden" name="reportType" value="<%=reportType%>">
		<input type="hidden" name="reportName" value="<%=reportName%>">
		<input type="hidden" name="exeType" value="<%=exeType%>">
		
		<Table  align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
      		<Tbody>
		
		<%	
			if(redirect)
			{
		%>
       				<Tr>
					<Th align="right" width="25%">Type</Th>
					<Td  align="left" width="25%"><%=reportsDescHash.get(reportType)%></Td>
					<Th align="right" width="25%">Execution Type</Th>
					<Td  align="left"><%=exeDescHash.get(exeType)%></Td>
				</Tr>
		<%
			}
		%>
    		</Tbody>
  		</Table>
<%
	}
%>

<%
	if ( retSelTabCount > 0 )
	{
		ezRepSelTableRow=(EzReportSelectRow)ezRepSelTable.getRow(0);
%>
		<input type="hidden" name="reportNo" value="<%=ezRepSelTableRow.getReportNo()%>">
		<Div id="theads">
		<%
			if(redirect)
			{
		%>
  				<!--<Table id="tabHead" align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
  				-->
  				<TABLE id="tabHead" width="90%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
				<Tr align="center" valign="middle">
					<Th width="30%" >Description</Th>
					<Th width="17%">Retreving Mode</Th>
					<Th width="11%">Operator</Th>
					<Th width="16%" >From</Th>
					<Th width="16%" >To</Th>
					<Th width="10%" >Multiple</Th>
				</Tr>
				</Table>
		<%
			}
		%>
		</Div>

		<!--<DIV id="InnerBox1Div">
			<Table id="InnerBox1Tab" align=center  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		-->	
		<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:90%;height:60%;left:5%">
		<TABLE id="InnerBox1Tab" width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>	
		<%
			String paramNo,paramName,paramDesc,paramIsSel,paramIshide,paramLen,paramType;
			String paramDataType,paramIsmand,paramIsDef,paramMethod,chkDef,mandDis="";
			String mandcolor,mandscript="";
			
			
			boolean ishide=false;
			boolean isdat=false;
			boolean ismand=false;
			boolean isdefault=false;
			boolean ischk=false;
			
			int acti=0;
			
			
			String checkBoxName="",displayrow="",checked="",defaultCheckValue="";
			String chkDataType="",checkBoxType="",noDisplay="",defaultValue="";
			
			for(int i=0;i<retSelTabCount;i++)
			//for(int i=0;i<10;i++)
			{
				ezRepSelTableRow=(EzReportSelectRow)ezRepSelTable.getRow(i);
				paramName	= ezRepSelTableRow.getParameterName();
				paramNo		= ezRepSelTableRow.getParamNo();
				paramDesc	= ezRepSelTableRow.getParameterDesc();
				paramLen	= ezRepSelTableRow.getLength();
				paramType	= ezRepSelTableRow.getParameterType();
				paramDataType	= ezRepSelTableRow.getDataType();
				paramIsmand	= ezRepSelTableRow.getIsMandatory();
				paramIsDef 	= ezRepSelTableRow.getChkDefaults();
				paramIshide	= ezRepSelTableRow.getIsHidden();
				paramIsSel	= ezRepSelTableRow.getIsCustomer();
				paramMethod	= ezRepSelTableRow.getMethodName();
				paramNo		= ezRepSelTableRow.getParamNo();
				ishide		= ("N".equals(paramIshide))?true:false;
				
		
				ezc.ezbasicutil.EzStringTokenizer chkToken = new ezc.ezbasicutil.EzStringTokenizer(paramDataType,",");
				Vector myTokens= chkToken.getTokens();
				int myTokensSize = myTokens.size();
				chkDataType = (String)myTokens.get(0);
				checkBoxType = (String)myTokens.get(1);
				noDisplay  = (String)myTokens.get(3);
				if(myTokensSize == 5)
					defaultValue = (String)myTokens.get(4);
					
					
				isdat	  = (paramDataType.startsWith("D"))?true:false;
				ismand	  = ("X".equals(paramIsmand) || "L".equals(paramIsmand))?true:false;
				isdefault = ("Y".equals(paramIsDef))?true:false;
				ischk	  = ("P".equals(paramType) && "1".equals(paramLen))?true:false;
		
					
				if(ismand)
				{
					mandcolor="class='changeC'";
					//mandscript="onblur='chkMand("+i+")'";
					mandscript="";
					toBeChkVect.add(""+i);
				}
				else
				{
					mandcolor="";
					mandscript="";
				}
				
				
				
				String TALow="",TAHigh="",TAMode="",TAOpet="",low="µ",high="µ";
				String mod="µ",opt="µ",paramMulti="",valReportNO,valParamNo;
				String valLow,valHigh,valMode,valOp="";
				for(int k=0;k<retvalTabCount;k++)
				{
					ezRepValTableRow = (EzReportValuesRow)ezRepValTable.getRow(k);
					valReportNO =ezRepValTableRow.getReportNo();
					valParamNo=ezRepValTableRow.getParamNo();
					if(paramNo.equals(valParamNo))
					{
						valLow  = ezRepValTableRow.getParameterValueLow();
						valHigh = ezRepValTableRow.getParameterValueHigh();
						valMode = ezRepValTableRow.getRetreivalMode();
						valOp   = ezRepValTableRow.getOperator();
						valLow  = (valLow == null || valLow=="")?"N":valLow;
						valHigh = (valHigh == null || valHigh == "")?"N":valHigh;
						valMode = (valMode == null || valMode =="")?"N":valMode;
						valOp   = (valOp == null || valOp == "" )?"N":valOp;
						if("X".equals(paramIsDef))
						{
							low=("µ".equals(low))?"":low;
							if(!"N".equals(valLow))
								low +=valLow+",";
						}
						else
						{
							low=("µ".equals(low) && !"N".equals(valLow))?valLow:low;
							high=("µ".equals(high) &&!"N".equals(valHigh))?valHigh:high;
							mod=("µ".equals(mod) && !"N".equals(valMode))?valMode:mod;
							opt=("µ".equals(opt) && !"N".equals(valOp))?valOp:opt;
							if("µ".equals(low) )
							{
								if(TALow.trim().length()==0)
									TALow=valLow+"µ";
								else
									TALow +=valLow+"µ";
								if(TAHigh.trim().length()==0)
									TAHigh=valHigh+"µ";
								else
									TAHigh+=valHigh+"µ";
								if(TAMode.trim().length()==0)
									TAMode=valMode+"µ";
								else
									TAMode+=valMode+"µ";
								if(TAOpet.trim().length()==0)
									TAOpet=valOp+"µ";
								else
									TAOpet+=valOp+"µ";
							}
						}
					}
				}
				paramMulti=TALow+"¤"+TAHigh+"¤"+TAMode+"¤"+TAOpet;
				low=("µ".equals(low) || "null".equals(low))?"":low;
				high=("µ".equals(high) || "null".equals(high))?"":high;
				if(ishide)
				{
		%>
				<Tr align="center" valign="middle" <%=mandcolor%>>
				<Td width="30%" align="left" <%=mandcolor%>>
					<input 	type="hidden" 	name="paramName" 	value="<%=paramName%>" 		>
					<input 	type="hidden" 	name="paramDesc" 	value="<%=paramDesc%>" 		>
					<input 	type="hidden" 	name="paramNo"		value="<%=paramNo%>" 		>	
					<input 	type="hidden" 	name="paramIsSel" 	value="<%=paramIsSel%>"		>
					<input 	type="hidden" 	name="paramIshide" 	value="<%=paramIshide%>"	>
					<input 	type="hidden" 	name="paramLen" 	value="<%=paramLen%>" 		>
					<input 	type="hidden" 	name="paramType" 	value="<%=paramType%>" 		>
					<input 	type="hidden" 	name="paramDataType"	value="<%=paramDataType%>" 	>
					<input 	type="hidden" 	name="paramIsmand" 	value="<%= paramIsmand %>"	>	
					<input 	type="hidden" 	name="paramIsDef" 	value="<%= paramIsDef %>"	>
					<input 	type="hidden" 	name="paramMethod" 	value="<%= paramMethod %>"	>
					<input 	type="hidden" 	name="paramMulti" 	value="<%=paramMulti%>"		>
					<%
						if("".equals(paramDesc) || "null".equals(paramDesc))
							out.println("&nbsp;");
						else
							out.println(paramDesc);
					%>
				</Td>
				<Td width="17%" align="left" <%=mandcolor%>>
				<%
					if( (!ischk) && (!isdefault))
						out.println(getRetrieveMode(mod,1));
					else
					{
						if(isdefault)
							out.println(getRetrieveMode(mod,2));
						else
							out.println(getRetrieveMode(mod,3));
					}
				%>
        			</Td>
        			
        			
        			
        			<Td width="11%" align="left" <%=mandcolor%>>
				<%
					if( (!ischk) && (!isdefault))
						out.println(getOperatorMode(opt,1));
					else	
					{
						if(isdefault)
							out.println(getOperatorMode(opt,2));
						else
							out.println(getOperatorMode(opt,3));
					}
				%>
        			</Td>
			
				<Td width="16%" align="left" <%=mandcolor%> >
				<%
				if(isdefault)
				{
					try
					{
						repDefaults =def.getDefaultValues(paramMethod);
						
						
					} catch(Exception e)
					{
						repDefaults = new ReturnObjFromRetrieve();
					}
					
					if(repDefaults != null)
						repDefaultsCount =repDefaults.getRowCount();

										
					if(repDefaultsCount ==1)
					{
						out.println(getFromField(repDefaults.getFieldValueString(0,"DEF_VALUE")));
					}	
					else if(repDefaultsCount==0)
					{
						out.println(getFromField("null"));
					}	
					else 
					{
						out.println(getFromField(low,repDefaults,i));						
					}
				}
				else
				{
					if(isdat)
					{
						out.println(getFromField(low,low,1,i,"",""));
					}
					else if(ischk)
					{
						String chkLow =("µ".equals(low) || low.trim().length()==0)?"":"checked";

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
						
												
						out.println(getFromCheckField(checkBoxType,checkBoxName,checked,defaultCheckValue,i));
					}
					else
					{
						if(ismand)
						{
							out.println(getFromField(low,low,3,i,paramLen,mandscript));
						}
						else
						{
							
							mandscript = "onblur='validate(\""+paramDataType.charAt(0)+"\",this,"+i+")'";
							out.println(getFromField(low,low,3,i,paramLen,mandscript));
						}
					}
				}
			%>
			</Td>
				<Td width="16%" align="left" <%=mandcolor%>>
			<%
					if("S".equals(paramType) && !isdefault)
					{
						if(isdat)
						{
							out.println(getToField(high,1,i,"",'C'));
						}
						else
						{
							out.println(getToField(high,2,i,paramLen,paramDataType.charAt(0)));
						}
					}
					else
					{
						out.println(getToField("",3,i,"",'C'));
					}	
			%>		
				</Td>
				
				<Td width="10%" <%=mandcolor%>>
				<% 
					if(ischk || isdefault)
					{
				%>
					&nbsp;
				<%
					}
					else
					{
				%>
					<a href='JavaScript:ezOpenWindow("<%=i%>")' id="Multi">Click</a>
				<%
					}
				%>
				</Td>
				</Tr>
			<%
				
			}
			else
			{
				if(isdefault)
				{
					repDefaults =def.getDefaultValues(paramMethod);
					if(repDefaults != null)
					repDefaultsCount =repDefaults.getRowCount();

					if(repDefaultsCount ==1)
					{
						low=repDefaults.getFieldValueString(0,"DEF_VALUE");
					}
				}

			%>
				<input type="hidden" name="paramName" value="<%=paramName%>" >
				<input type="hidden" name="paramDesc" value="<%=paramDesc%>" >
				<input type="hidden" name="paramNo" value="<%=paramNo%>" >
				<input type="hidden" name="paramIsSel" value="<%=paramIsSel%>">
				<input type="hidden" name="paramIshide" value="<%=paramIshide%>">
				<input type="hidden" name="paramLen" value="<%=paramLen%>" >
				<input type="hidden" name="paramType" value="<%=paramType%>" >
				<input type="hidden" name="paramDataType" value="<%=paramDataType%>" >
				<input type="hidden" name="paramIsmand" value="<%= paramIsmand %>">
				<input type="hidden" name="paramIsDef" value="<%= paramIsDef %>">
				<input type="hidden" name="paramMethod" value="<%= paramMethod %>">
				<input type="hidden" name="paramMulti" value="<%=paramMulti%>">
				<input type="hidden" name="lowValue" value="<%=low%>">
				<input type="hidden" name="highValue" value="<%=high%>">
				<input type="hidden" name="paramOpt" value="<%=opt%>">
				<input type="hidden" name="paramMod" value="<%=mod%>" >

			<%
			}
		}

%>
	</Table>
	</div>

	<br>
	<%if(redirect){%>
  	<Div id="ButtonDiv" align = "center" style="position:absolute;top:90%;width:100%">
  	
<%
  
  		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		
		buttonName.add("Execute");
		buttonMethod.add("ezFormSubmit()");

		buttonName.add("Back");
		buttonMethod.add("goHome()");
		out.println(getButtonStr(buttonName,buttonMethod));	

%>		

		         <!--
		             <a href="JavaScript:ezFormSubmit()"><img src="../../Images/Buttons/<%= ButtonDir%>/execute.gif" alt="execute" title="execute" border="none"></a>
			     <a href="JavaScript:ezBack()"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" alt="back" title="back" border="none"></a>
			 -->
	</Div>
	<%}%>
  <% }
  	else
  	{
  %>
  
  <br><br>
  <Table  width="95%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr align="center">
    		<Td class="displayheader">No Data has been retrieved.</Td>
  	</Tr>
  </Table>

<%}%>

  <%
  if(redirect)
  {
  }
  else
  {
%>
 	 <Script>
	 ezForm=document.addForm
	 if(ezForm.exeType.value=="A")
	 {
		showConfirmDiv()
	 }
	 else
	 {
		ezForm.action="ezSaveExecuteReport.jsp"
    		ezForm.submit()
	 }
	</Script>
  <%
  }
  %>
  </form>
  <Div id="MenuSol" style="width:0%;height:0%;visibility:hidden">&nbsp;</Div>
  </Body>
</html>
