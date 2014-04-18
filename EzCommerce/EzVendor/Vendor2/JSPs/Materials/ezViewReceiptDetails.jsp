<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ page import="java.util.*,java.text.*" %>
<%@ page import="ezc.ezutil.*" %>
<%@ include file="../../../Includes/JSPs/Materials/iViewReceiptDetails.jsp" %>
<%

	FormatDate fd = new FormatDate();
	String dcdate=fd.getStringFromDate((Date)retHead.getFieldValue(0,"DC_DATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));


%>
<Html>
<Head>
	<title>Add Receipt</title>

	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
	<script src="../../Library/JavaScript/ezCountriesAndStates.js"></script>
	<script>
	var newWindow4;
	var qaViewWindow;
	function openFileWindow(file)
	{
		newWindow4 = window.open(file+"?sampleId=<%=SampleId%>&sysKey=<%=currSysKey%>","MyNewtest","center=yes,height=440,left=200,top=30,width=450,titlebar=no,status=no,resizable=no,scrollbars")
	}

 	function qaWindow(addFile,n)
	{

		  dcVal = '<%=retHead.getFieldValueString(0,"DC_NR")%>'
		  if(dcVal=="")
		  {
	            dcVal="-"
                  }

    		  matDesc = "<%=materialdesc%>";
	          if(matDesc=="null")
	          {
	            matDesc="-"
                  }

    		  dcDate = "<%=dcdate%>";
		  if(dcDate=="null")
    		  {
		      dcDate="-"
		  }

	         batNo = document.myForm.BatchNo[n].value;
                 if(batNo=="null")
                 {
			batNo="-"
    		 }

	        batQty = document.myForm.BatchQty[n].value;;
		if(batQty=="")
    		{
	           batQty="-"
    		}


		coastr=dcVal+"¤"+matDesc+"¤"+dcDate+"¤"+batNo+"¤"+batQty;
		qaViewWindow = window.open(addFile+"&coastr="+coastr,"MyNewtest1","center=yes,height=500,left=50,top=20,width=700,titlebar=no,resizable,scrollbars")
	}

	var x = false
	function showData()
	{
   		if(!x){
		      document.getElementById("abc").style.display=""
		      document.getElementById("abc").style.visibility="visible"
		      x=true
		}
   		else{
      			document.getElementById("abc").style.display="none"
      			x=false
	   	}
	}
	function createPO()
	{
	    if('<%=sampmat.getFieldValueString(0,"PONO")%>'=='Samples')
	    {
			document.myForm.action="ezCreateSamplePO.jsp";
			 entryWindow = window.open("ezEnterMaterialNumber.jsp","MyNewtest","center=yes,height=440,left=200,top=30,width=450,titlebar=no,status=no,resizable=no")
		     //entryWindow = window.showModalDialog("ezEnterMaterialNumber.jsp",arguments,"center=yes;dialogHeight=15;dialogWidth=30;help=no;titlebar=no;status=no;minimize:yes")
	    }
	    else
	    {
	  	if(window.confirm("Purchase Order already exists for this material.\nPress 'Ok' to continue or press 'Cancel' to create order later."))
		{

		     entryWindow = window.showModalDialog("ezEnterMaterialNumber.jsp",arguments,"center=yes;dialogHeight=15;dialogWidth=30;help=no;titlebar=no;status=no;minimize:yes")
		     if(entryWindow!=null)
		     {

		     	var data = entryWindow.split("^^^")		     
		     	document.myForm.matNum.value=data[0]
		     	document.myForm.plant.value=data[1]
				document.myForm.purGrp.value=data[2]				

			document.myForm.action="ezCreateSamplePO.jsp";
			document.myForm.submit();
		     }		
 	  	}

	    }
	}

	function funUnLoad()
	{
		if(newWindow4!=null && newWindow4.open)
		{
		   newWindow4.close();
		}

		if(qaViewWindow!=null && qaViewWindow.open)
		{
		  qaViewWindow.close();
		}

	}


</script>
</Head>
<Body onUnLoad="funUnLoad()">
<Form name="myForm">
<%

	String address1=detailsRet.getFieldValueString(0,"ADDRESS1");
	String address2=detailsRet.getFieldValueString(0,"ADDRESS2");
	String city=detailsRet.getFieldValueString(0,"CITY");
	String state=detailsRet.getFieldValueString(0,"STATE");
	String country=detailsRet.getFieldValueString(0,"COUNTRY");
	String zip=detailsRet.getFieldValueString(0,"ZIPCODE");
	String phone1=detailsRet.getFieldValueString(0,"PHONE1");
	String phone2=detailsRet.getFieldValueString(0,"PHONE2");
	String fax=detailsRet.getFieldValueString(0,"FAX");
	String email=detailsRet.getFieldValueString(0,"EMAIL");
	
	String suppcompanyname="";
	String suppaddress1="";
	String suppaddress2="";
	String suppcity="";
	String suppstate="";
	String suppcountry="";
	String suppzip="";
	String suppphone1="";
	String suppphone2="";
	String suppfax="";
	String suppemail="";



	if(!suppAddr.equals("0"))
	{
		suppcompanyname=detailsRet.getFieldValueString(1,"COMPANYNAME");
		suppaddress1=detailsRet.getFieldValueString(1,"ADDRESS1");
		suppaddress2=detailsRet.getFieldValueString(1,"ADDRESS2");
		suppcity=detailsRet.getFieldValueString(1,"CITY");
		suppstate=detailsRet.getFieldValueString(1,"STATE");
		suppcountry=detailsRet.getFieldValueString(1,"COUNTRY");
		suppzip=detailsRet.getFieldValueString(1,"ZIPCODE");
		suppphone1=detailsRet.getFieldValueString(1,"PHONE1");
		suppphone2=detailsRet.getFieldValueString(1,"PHONE2");
		suppfax=detailsRet.getFieldValueString(1,"FAX");
		suppemail=detailsRet.getFieldValueString(1,"EMAIL");
	}


	String lrnum=retHead.getFieldValueString(0,"LR_RR_AIR_NR");
	String invno=retHead.getFieldValueString(0,"INV_NUM");
	String carrier=retHead.getFieldValueString(0,"CARRIER");

	if(address1==null || "null".equals(address1) || "".equals(address1))
	{
		address1="&nbsp;";
	}
	if(address2==null || "null".equals(address2) || "".equals(address2))
	{
		address2="&nbsp;";
	}
	if(city==null || "null".equals(city) || "".equals(city))
	{
		city="&nbsp;";
	}
	if(state==null || "null".equals(state) || "".equals(state))
	{
		state="&nbsp;";
	}
	if(country==null || "null".equals(country) || "".equals(country))
	{
		country="&nbsp;";
	}
	if(zip==null || "null".equals(zip) || "".equals(zip))
	{
		zip="&nbsp;";
	}
	if(phone1==null || "null".equals(phone1) || "".equals(phone1))
	{
		phone1="&nbsp;";
	}
	if(phone2==null || "null".equals(phone2.trim()) || "".equals(phone2.trim()))
	{
		phone2="&nbsp;";
	}
	if(fax==null || "null".equals(fax) || "".equals(fax))
	{
		fax="&nbsp;";
	}
	if(email==null || "null".equals(email) || "".equals(email))
	{
		email="&nbsp;";
	}

	if(suppcompanyname==null || "null".equals(suppcompanyname) || "".equals(suppcompanyname))
	{
		suppcompanyname="&nbsp;";
	}
	if(suppaddress1==null || "null".equals(suppaddress1) || "".equals(suppaddress1))
	{
		suppaddress1="&nbsp;";
	}
	if(address2==null || "null".equals(address2) || "".equals(address2))
	{
		address2="&nbsp;";
	}
	if(suppcity==null || "null".equals(suppcity) || "".equals(suppcity))
	{
		suppcity="&nbsp;";
	}
	if(suppstate==null || "null".equals(suppstate) || "".equals(suppstate))
	{
		suppstate="&nbsp;";
	}
	if(suppcountry==null || "null".equals(suppcountry) || "".equals(suppcountry))
	{
		suppcountry="&nbsp;";
	}
	if(suppzip==null || "null".equals(suppzip) || "".equals(suppzip))
	{
		suppzip="&nbsp;";
	}
	if(suppphone1==null || "null".equals(suppphone1) || "".equals(suppphone1))
	{
		suppphone1="&nbsp;";
	}
	if(suppphone2==null || "null".equals(suppphone2) || "".equals(suppphone2))
	{
		suppphone2="&nbsp;";
	}
	if(suppfax==null || "null".equals(suppfax) || "".equals(suppfax))
	{
		suppfax="&nbsp;";
	}
	if(suppemail==null || "null".equals(suppemail) || "".equals(suppemail) )
	{
		suppemail="&nbsp;";
	}


	if(lrnum==null || "null".equals(lrnum) || "".equals(lrnum))
	{
		lrnum="&nbsp;";
	}
	if(invno==null || "null".equals(invno) || "".equals(invno))
	{
		invno="&nbsp;";
	}
	if(carrier==null || "null".equals(carrier) || "".equals(carrier))
	{
		carrier="&nbsp;";
	}



%>
    <TABLE width=40% align=center border=0>
    <Tr align="center">
    <Td class="displayheader">View Receipt Details</Td>
    </Tr>
    </Table>
	<br>
<div id="Sample" style="overflow:auto;position:absolute;height:65%;width:98%;left:2%;" >
    <TABLE width=100% align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
    <tr>
	<th align="left" width="25%">Description</th>
	<td colspan=3 width="75%">
		<%
			if(sampmat.getFieldValueString(0,"ISMATSPECS").equals("Y"))
			{
		%>
			<a href="ezViewMaterialSpec.jsp?sampleId=<%=SampleId%>&materialDesc=<%=materialdesc%>"><%=materialdesc%></a>
               <%	}else{         %>
			<%=materialdesc%>
		<%      } 		%>

        </td>
	</tr>
	</table>

	<%
		if(suppAddr.equals("0"))
		{
	%>

	<TABLE width=100% align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<tr>
	<th colspan=4 align="center" width="100%">Manufacturing Site</th>
	</tr>

	<tr>
	<th align="left" width="25%">Address1</th><td width="25%"> <%=address1%> </td>
	<th align="left" width="25%">Address2</th><td width="25%"><%= address2%></td>
	</tr>

	<tr>
	<th align="left" width="25%">City</th><td width="25%"><%=city%> </td>
	<th align="left" width="25%">State</th><td width="25%"><%=state%></td>
	</tr>

	<tr>
        <th align="left" width="25%">Country</th>
        <td width="25%">
	<script>
		   for(var i=0;i<CountryArr.length;i++)
		   {
		   		if(CountryArr[i].key=='<%=country%>')
		   		{
		   			document.write(CountryArr[i].value);
		   		}
		   }
	</script>
        &nbsp;</td>
        <th align="left" width="25%">Zip</th><td width="25%"><%=zip%></td>
        </tr>

	<tr>
	<th align="left" width="25%">Phone1</th><td width="25%"><%=phone1%> </td>
        <th align="left" width="25%">Phone2</th><td width="25%"><%=phone2%> </td>
        </tr>

	<tr>
        <th align="left" width="25%">Fax</th><td width="25%"><%=fax%></td>
	<th align="left" width="25%">E-mail</th>
	<td width="25%"><%=email%></td>
	</tr>
	</table>

	<%	}else{     %>

        <TABLE width=100% align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
	<tr>
	<th colspan=2 align=center width="50%">Supplier Address</th>
	<th colspan=2 align=center width="50%">Manufacturing Site Address</th>
	</tr>

	<tr>
	<th align="left" width="25%">Company Name</th><td width="25%"><%=suppcompanyname%></td>
	<td align="left" width="25%" colspan=2>&nbsp;</th></td>
	</tr>

	<tr>
	<th align="left" width="25%">Address1</th><td width="25%"><%=suppaddress1%></td>
	<th align="left" width="25%">Address1</th><td width="25%"><%=address1%></td>
	</tr>

	<tr>
	<th align="left" width="25%">Address2</th><td width="25%"><%=suppaddress2%></td>
	<th align="left" width="25%">Address2</th><td width="25%"><%=address2%></td>
	</tr>

	<tr>
	<th align="left" width="25%">City</th><td width="25%"><%=suppcity%></td>
	<th align="left" width="25%">City</th><td width="25%"><%=city%></td>
	</tr>

	<tr>
	<th align="left" width="25%">State</th><td width="25%"><%=suppstate%></td>
	<th align="left" width="25%">State</th><td width="25%"><%=state%></td>
	</tr>

	<tr>
   	<th align="left" width="25%">Country</th><td width="25%">
	<script>
		   for(var i=0;i<CountryArr.length;i++)
		   {
		   		if(CountryArr[i].key=='<%=suppcountry%>')
		   		{
		   			document.write(CountryArr[i].value);
		   		}
		   }
	</script>
	</td>
	<th align="left" width="25%">Country</th><td width="25%">
	<script>
		   for(var i=0;i<CountryArr.length;i++)
		   {
		   		if(CountryArr[i].key=='<%=country%>')
		   		{
		   			document.write(CountryArr[i].value);
		   		}
		   }
	</script>
	</td>
   	</tr>

	<tr>
	<th align="left" width="25%">Zip</th><td width="25%"><%=suppzip%></td>
	<th align="left" width="25%">Zip</th><td width="25%"><%=zip%></td>
   	</tr>

	<tr>
	<th align="left" width="25%"> Phone1</th><td width="25%"><%=suppphone1%></td>
   	<th align="left" width="25%">Phone1</th><td width="25%"><%=phone1%></td>
   	</tr>

	<tr>
	<th align="left" width="25%"> Phone2</th><td width="25%"><%=suppphone2%></td>
   	<th align="left" width="25%">Phone2</th><td width="25%"><%=phone2%></td>
   	</tr>


	<tr>
    	<th align="left" width="25%"> Fax</th><td width="25%"><%=suppfax%></td>
	<th align="left" width="25%"> Fax</th><td width="25%"><%=fax%></td>
	</tr>
	</table>

	<%   }   %>


<%


	String invdates="&nbsp;";
	if(!(retHead.getFieldValue(0,"INV_DATE") ==null))
	{
		invdates=fd.getStringFromDate((Date)retHead.getFieldValue(0,"INV_DATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
	}
	String shipdates="&nbsp;";
	if(!(retHead.getFieldValue(0,"SHIPMENT_DATE")==null))
	{
		shipdates=fd.getStringFromDate((Date)retHead.getFieldValue(0,"SHIPMENT_DATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
	}
	String expdates="&nbsp;";
	if(!(retHead.getFieldValue(0,"EXP_ARIVAL_TIME")==null))
	{
		expdates=fd.getStringFromDate((Date)retHead.getFieldValue(0,"EXP_ARIVAL_TIME"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
	}
	String text=retHead.getFieldValueString(0,"TEXT");
	if(text==null || "null".equals(text))
	{
		text="&nbsp;";
	}
%>
	<TABLE width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<tr>
	<th colspan=4 align="center">Shipment Details</th>
	</tr>

	<tr align="center" valign="middle">
	<th align="left" width="25%">DN No </th>
	<td align="left" width="25%"><%=retHead.getFieldValueString(0,"DC_NR")%></td>
	<th align="left" width="25%">DN Date </th>
	<td  align="left" valign=center width="25%">
	<%
	if(!(dcdate==null))
		out.println(dcdate);
	%></td>
	</tr>

	<tr>
	<th align="left" width="25%">Invoice No </th>
	<td align="left" width="25%"><%=invno%> </td>
	<th align="left" width="25%">Invoice Date </th>
	<td align="left" valign=center width="25%"><%=invdates%> </td>
	</tr>

	<tr>
	<th align="left" width="25%">LR/RR/AIR BILL No </th>
	<td align="left" width="25%"><%=lrnum%> </td>
	<th align="left" width="25%">Shipment Date </th>
	<td align="left" valign=center width="25%"><%=shipdates%> </td>
	</tr>

	<tr>
	<th align="left" width="25%">Carrier Name </th>
	<td width="25%"><%=carrier%></td>
	<th align="left" width="25%">Exp. Arrival Date </th>
	<Td valign=center width="25%"><%=expdates%></Td>
	</tr>

	<Tr>
	<th align="left" width="25%">General Text </th>
	<Td colspan="3" align="left" width="75%"><%=text%></Td>
	</Tr>
       	</table>
<%
	int retCount = retSchedules.getRowCount();
	
        if(retCount>0)
	{
%> 
  	<Table align="center" width="100%" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
  	<tr>
    	<th align="center" width="10%">Line</th>
    	<th align="center" width="30%">Material Description</th>
    	<th align="center" width="15%">Qty</th>
    	<th align="center" width="15%">Batch No</th>
    	<th align="center" width="15%">UOM</th>
    	<th align="center" width="15%">COA</th>
  	</tr>
  	<tr>
     	<td align="center"><%=retLines.getFieldValueString(0,"LINE_NR")%></td>
     	<td>
	<input type="hidden" name="MatDesc" value="<%=retLines.getFieldValueString(0,"MAT_DESC")%>" >
	<input type="hidden" name="UOM" value="<%=retLines.getFieldValueString(0,"UOM_QTY")%>" >
	<%=materialdesc%></td>
     	<td align="right">
	<input type="hidden" name="TotQty" value="<%=retLines.getFieldValueString(0,"TOTAL_QTY")%>" >
	<%=retLines.getFieldValueString(0,"TOTAL_QTY")%>
	</td>
     	<td colspan=3 align="center"><a href="javascript:void(0)"  onClick="showData()">Multiple Batch Details</a></td>
  	</tr>
  	</table>

  	<span id="abc" style="display:none">
  	<Table align="center" width="100%" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<%
	
	for(int i=0;i<retCount;i++)
	{
	%>
		<tr>
		<td width="10%">&nbsp;</td>
		<td width="30%">&nbsp;</td>
	     	<td width="15%" align=right><%=retSchedules.getFieldValueString(i,"BATCH_QTY")%>
		<input type="hidden" name="BatchQty" value="<%=retSchedules.getFieldValueString(i,"BATCH_QTY")%>" >
		</td>
		<td width="15%" align=center><%=retSchedules.getFieldValueString(i,"BATCH")%>
		<input type="hidden" name="BatchNo" value="<%=retSchedules.getFieldValueString(i,"BATCH")%>" >
		</td>
		<td width="15%" align=center><%=retSchedules.getFieldValueString(i,"EZSD_EXT1")%></td>

		<%
		   int retSchedCount = retSchedules.getRowCount();
		   int coaCount = listCOA.getRowCount();
		   boolean flag=false;
		           for(int j=0;j<coaCount;j++)
			   {
		   		flag=false;
			  	if(listCOA.getFieldValueString(j,"LINENUMBER").equals(retSchedules.getFieldValueString(i,"SCHD_LINE")))
				{
				   flag=true;
				   break;
				}
			   }
			   if(flag)
			   {
		%>
				  <td align="center" width="15%"><a href="javascript:void(0)" onClick="qaWindow('ezViewCertificate.jsp?sampleId=<%=SampleId%>&itemNumber=<%=retSchedules.getFieldValueString(i,"LINE_NR")%>&lineNumber=<%=retSchedules.getFieldValueString(i,"SCHD_LINE")%>&flag=SAMPLES','<%=i%>')">QA</a></td>
		<%	   }
		  	   else
		  	   {
		%>  		<td align="center" width="15%">&nbsp;</td>
		<%	   }
		%>

		</tr>
	<%
	}
	%>
<input type="hidden" name="coastr" value="">
<input type="hidden" name="SampleId" value="<%=SampleId%>">
	</table>
  	</span>
  	

	<% } %>
</div>
	<br>
	<div align=center style="position:absolute;top:85%;width:100%;" >
	<table align="center">
	<tr>
	<td align="center" class=blankcell>
	<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" style="cursor:hand" border=none onClick="javascript:history.go(-1)">
	<!--<img src="../../Images/Buttons/<%=ButtonDir%>/createpo.gif" style="cursor:hand" border=none onClick='createPO()'>-->
	<%
	    if(sampmat.getFieldValueString(0,"ATTACHMENTS").equals("Y"))
	    {
	%>
		<img src="../../Images/Buttons/<%=ButtonDir%>/viewdocuments.gif" style="cursor:hand" border=none onClick="openFileWindow('ezViewSampleFiles.jsp')">
        <%  } %>

	</td>
	</tr>
	</Table>
	</div>
<input type="hidden" name="matNum">
<input type="hidden" name="plant">
<input type="hidden" name="purGrp">
</Form>
<Div id="MenuSol"></Div>
</Body></Html>
