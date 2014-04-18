<%@ include file="../../../Includes/Lib/Countries.jsp" %>
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session"/>
<%@ include file="../../../Includes/JSPs/Config/iListAddress.jsp"%>
<%@ page import="ezc.ezparam.*" %>

<%
	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
        snkparams.setLanguage("EN");
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);
	ReturnObjFromRetrieve retlang = (ReturnObjFromRetrieve)sysManager.getAllLangKeys(sparams);

	String myLang=ret.getFieldValueString(0,"LANG");
	for(int i=0;i<retlang.getRowCount();i++)
	{
		if(myLang.equals(retlang.getFieldValueString(i,"ELK_ISO_LANG")))
		{
			myLang=retlang.getFieldValueString(i,"ELK_LANG_DESC");
			break;
		}
	}

%>

<html>
<head>

	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>



</head>
<body>
<form name=myForm >
<center>
<br>

<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
  		<Tr align="center">
    			<Td class="displayheader"> Address Details  for "<%=ret.getFieldValue(0,"NUM")%>"</Td>
  		</Tr>
	</Table>



    <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
      <Tr>
        <Th colspan="4">
          <div align="center"></div>
        </Th>
      </Tr>
      <Tr>
        <Td class="labelcell" width="17%">
          <div align="right"> Language:</div>
        </Td>
        <Td width="23%">
         <%= myLang%>
	 
        </Td>
        <Td class="labelcell" width="17%">
          <div align="right">Company Name :</div>
        </Td>
         <Td width="23%">
	         <%String name=(String)ret.getFieldValue(0,"COMPANYNAME");
		 if(name == null || name.equals(""))
		 {
		 	name="&nbsp;";
		}%><%=name%>
        </Td>
        </Tr>
     	<Tr>
		<Td class="labelcell" width="17%">
		  <div align="right"> URL:</div>
		</Td>
		<Td width="23%">
		<% String url= (String)ret.getFieldValue(0,"URL"); 
		if(url == null || url.equals(""))
		{
			url="&nbsp;";
		}%><%=url%>
		</Td>
		<Td class="labelcell" width="17%">
		  <div align="right">Email :</div>
		</Td>
		 <Td width="23%">
		<% String email=(String)ret.getFieldValue(0,"EMAIL");
		 if(email == null || email.equals(""))
		 {
			email="&nbsp;";
		 }%><%=email%>
		</Td>
	</Tr>
		<Tr>
			<Td class="labelcell" width="17%">
			  <div align="right"> Address 1:</div>
			</Td>
			<Td width="23%">
			 <%String add1=(String)ret.getFieldValue(0,"ADDRESS1");
			 if(add1==null || add1.equals(""))
			 {
			 	add1="&nbsp;";
			 }
			  %><%=add1%>
			</Td>
			<Td class="labelcell" width="17%">
			  <div align="right">Address 2 :</div>
			</Td>
			 <Td width="23%">
				  <%String add2=(String)ret.getFieldValue(0,"ADDRESS2");
				 if(add2==null || add2.equals(""))
				 {
					add2="&nbsp;";
				 }
			  %><%=add2%>
			</Td>
		</Tr>
		<Tr>
			<Td class="labelcell" width="17%">
			  <div align="right"> City:</div>
			</Td>
			<Td width="23%">
			  <%String city=(String)ret.getFieldValue(0,"CITY");
			  if(city == null || city.equals(""))
			  {
			  	city="&nbsp;";
			  }%><%=city%>
			</Td>
			<Td class="labelcell" width="17%">
			  <div align="right">District :</div>
			</Td>
			 <Td width="23%">
				  <%String district=(String)ret.getFieldValue(0,"DISTRICT");
				  if(district==null || district.equals(""))
				  {
				  	district="&nbsp;";
				  }%><%=district%>
			</Td>
		</Tr>
			<Tr>
				<Td class="labelcell" width="17%">
				  <div align="right"> State:</div>
				</Td>
				<Td width="23%">
				  <% String state=(String)ret.getFieldValue(0,"STATE");
				  if(state==null || state.equals(""))
				  {
				  	state="&nbsp;";
				  }%><%=state%>
				</Td>
				<Td class="labelcell" width="17%">
				  <div align="right">Country :</div>
				</Td>
				 <Td width="23%">
					 <%String country=(String)ret.getFieldValue(0,"COUNTRY");
					if(country==null || country.equals(" "))
					{
						country="&nbsp;";
					}
					else
					{%>
					 <%
						  for(int j=0;j<countryList.length;j++)
						  {
							if(ret.getFieldValueString(0,"COUNTRY").equals(countryList[j][1]))
							  country=countryList[j][0];
						  }		    
					}%>			
				<%=country%>
				</Td>
			</Tr>
			<Tr>
				<Td class="labelcell" width="17%">
				  <div align="right"> Zipcode:</div>
				</Td>
				<Td width="23%">
				  <%String zip=(String)ret.getFieldValue(0,"ZIPCODE");

				  if(zip == null || zip.equals(""))
				  {
				  	zip="&nbsp;";
				  }%><%=zip%>
				</Td>
				<Td class="labelcell" width="17%">
				  <div align="right">Phone 1 :</div>
				</Td>
				 <Td width="23%">
					  <%String ph1=(String)ret.getFieldValue(0,"PHONE1");
					  if(ph1==null || ph1.equals(""))
					  {
					  	ph1="&nbsp;";
					  }%><%=ph1%>
				</Td>
			</Tr>
			<Tr>
				<Td class="labelcell" width="17%">
				  <div align="right"> Phone 2:</div>
				</Td>
				<Td width="23%">
  					<%String ph2=(String)ret.getFieldValue(0,"PHONE2");
					  if(ph2==null || ph2.equals(""))
					  {
					  	ph2="&nbsp;";
					  }%><%=ph2%>				</Td>
				<Td class="labelcell" width="17%">
				  <div align="right">Mobile :</div>
				</Td>
				 <Td width="23%">
					<%String mobile=(String)ret.getFieldValue(0,"MOBILE");
					if(mobile==null || mobile.equals(""))
					{
						mobile="&nbsp;";
					}%><%=mobile%>
				</Td>
			</Tr>
			<Tr>
				<Td class="labelcell" width="17%">
				  <div align="right">Bus Domain:</div>
				</Td>
				<Td width="23%">
				  <%String bd=(String)ret.getFieldValue(0,"BUSDOMAIN");
				  if(bd==null || bd.equals(""))
				  {
				  	bd="&nbsp;";
				  }
				  %><%=bd%>
				</Td>
				<Td class="labelcell" width="17%">
				  <div align="right">Type :</div>
				</Td>
				 <Td width="23%">
					  <%String type=(String)ret.getFieldValue(0,"TYPE");
					  if(type==null || type.equals(" "))
					  {
					  	type="&nbsp;";
					  }
					  else if(type.equals("I"))
					  {
					  	type="Internal Address";
					  }
					  else if(type.equals("C"))
					  {
					  	type="Customer Address";
					  }
					  else if(type.equals("S"))
					  {
					  	type="Stockist Address";
					  }
					  %><%=type%>
				</Td>
			</Tr>
			<Tr>
				<Td class="labelcell" width="17%">
				  <div align="right">Fax :</div>
				</Td>
				<Td colspan=3 width="23%">
				  <%String fax=(String)ret.getFieldValue(0,"FAX");
				  if(fax==null || fax.equals(""))
				  {
				  	fax="&nbsp;";
				  }%><%=fax%>
				</Td>
				
			</Tr>
			
       		
    </Table>
	<br>
	 <a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>
</form>
</body>
</html>
