<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Jsps/Misc/iblockcontrol.jsp" %>
<%@ page import="ezc.ezparam.*,ezc.ezpreprocurement.params.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="PreProManager" class="ezc.ezpreprocurement.client.EzPreProcurementManager" scope="session" />
<%@ include file="../../../Includes/Jsps/Misc/iGetVendorDesc.jsp"%>


<%
		
	
	int collRfqRetCount=0;
	int newVendCount=0;
	java.util.Set newVendSet=null;
	java.util.Date validDate = null;
	java.util.Date currDate = new java.util.Date();
	java.util.Hashtable vendHash = new java.util.Hashtable();
	java.util.Hashtable commVendHash= new java.util.Hashtable();
	boolean multiQCF=false;
	boolean commVendor=false;
	
	java.util.Hashtable vendorRFQHash=new java.util.Hashtable();


	String message="";
	String collRFQsIn=request.getParameter("colNumbers");
	if(collRFQsIn!=null && collRFQsIn.indexOf("','")!=-1)
	multiQCF=true;
  
  
	EzcParams ezContainer	= new EzcParams(false);
	EziRFQHeaderParams rfqHeaderParams = new EziRFQHeaderParams();
	rfqHeaderParams.setCollectiveRFQNo(collRFQsIn);
	rfqHeaderParams.setStatus("Y");
  	rfqHeaderParams.setReleaseIndicator("R");
	rfqHeaderParams.setExt1("QCFPO");	
	ezContainer.setObject(rfqHeaderParams);
	ezContainer.setLocalStore("Y");
	Session.prepareParams(ezContainer);
	ReturnObjFromRetrieve collRfqRet = (ReturnObjFromRetrieve)PreProManager.ezGetRFQList(ezContainer);
  
	if(collRfqRet!=null)
		collRfqRetCount=collRfqRet.getRowCount();
	if(collRfqRetCount>0)
	{
		java.util.TreeMap vendorMap=new java.util.TreeMap();
		String vendorCode=null;
		String vendorName=null;
		String priceValidto =null;
		String materialPlant=null;
		String rfqNo=null;
		String temp  = ""; 
		if(!multiQCF){
		message="Approved Vendors List";
		commVendor=true;
		}
		
		for(int i=0;i<collRfqRetCount;i++)
		{
			vendorCode=collRfqRet.getFieldValueString(i,"SOLD_TO");
			vendorName=collRfqRet.getFieldValueString(i,"SOLD_TO");
			materialPlant=collRfqRet.getFieldValueString(i,"PLANT");
			rfqNo=collRfqRet.getFieldValueString(i,"RFQ_NO");
			


			if(commVendHash.containsKey(vendorCode)){
				if(materialPlant.equals((String)commVendHash.get(vendorCode))){
					commVendor=true;
					message="Common Vendors List";
				}else{
					commVendor=false;
					message="No common Vendors exists with same plant in the selected QCFs";
				}

			}else{
				commVendHash.put(vendorCode,materialPlant);
			}
			 
			validDate = (java.util.Date)collRfqRet.getFieldValue(i,"ERH_PRICE_VALID");
						
			if(vendorCode!=null)vendorCode=vendorCode.trim();
						
			if(validDate.after(currDate))
			{
				if(!vendHash.containsKey(vendorCode)){
					vendHash.put(vendorCode,"V");
				}else{
					temp =(String)vendHash.get(vendorCode);
					if("I".equals(temp))
					{
						vendHash.remove(vendorCode);
						vendHash.put(vendorCode,"B");
					}
				}
			}else{
				if(!vendHash.containsKey(vendorCode)){
					vendHash.put(vendorCode,"I");
				}else{
					temp = (String)vendHash.get(vendorCode);
					if("V".equals(temp))
					{
						vendHash.remove(vendorCode);
						vendHash.put(vendorCode,"B");
					}
				}
			}
						
			vendorMap.put(vendorCode,vendorName);
			if(vendorRFQHash.containsKey(vendorCode)){
				rfqNo=(String)vendorRFQHash.get(vendorCode)+","+rfqNo;
				vendorRFQHash.put(vendorCode,rfqNo);
			}else{
				vendorRFQHash.put(vendorCode,rfqNo);
			}
		}
		newVendSet=vendorMap.entrySet();
		if(multiQCF && !commVendor &&"".equals(message))
		message="No common vendor exist in the select QCFs";
    
	}
	if(newVendSet!=null)
	newVendCount=newVendSet.size();
	String display_header = "Approved RFQ(s) List";
	
	
	
%>


<Html>
<Head>
<Title>Approved Vendors</Title>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<Script>
	var tabHeadWidth=80
	var tabHeight="60%"

</Script>	

<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>

<Script>
	function checkAll(obj)
	{
		var chkstatus = false;
		if(obj.checked)  chkstatus =true;
		
		var chkObj = document.myForm.chk1
		var chkObjLen =  document.myForm.chk1.length
		if(chkObj != null)
		{
			if(!isNaN(chkObjLen))
			{
				for(i=0;i<chkObjLen;i++)
				{
					chkObj[i].checked = chkstatus		
				}
			}
			else
			{
				chkObj.checked = chkstatus
			}
		}
	}

	function returnUsers()
	{
		var vndObj = document.myForm.chk1
		var vndLen 
		var chooseUser = "";
		var chooseVnd = false;
		if(vndObj != null)
		{
			vndLen = document.myForm.chk1.length
			if(!isNaN(vndLen))
			{
				for(i=0;i<vndLen;i++)
				{
					if(document.myForm.chk1[i].checked)
					{
						if(chooseUser=="")
							chooseUser = document.myForm.chk1[i].value
						else
							chooseUser = chooseUser+"ее"+document.myForm.chk1[i].value
						
						chooseVnd = true
						
					}
					
				}
			}
			else
			{
				if(document.myForm.chk1.checked)
				{
					chooseUser = document.myForm.chk1.value
					chooseVnd = true
				}	
				
			}
			if(chooseVnd)
			{
				window.returnValue=chooseUser;
				window.close();
			}
			else
			{
				alert("Please Select Atleast One Approved RFQ");
			}
		}	
	}


</Script>


</Head>
<Body onLoad="scrollInit()" onResize="scrollInit()" scroll="no">
<Form name=myForm >

<%
	
	if(newVendCount>0 && commVendor){
%>	
		
    <br><br>	
	  <Table id="header" align=center width="60%" border=0 borderColorDark=#ffffff borderColorLight=#000000  cellspacing="0" cellpadding="2">
	  <Tr>
		  <Th><%=display_header%></Th>
	  </Tr>
	 </Table>
    <br>
    <Div id="theads">
		<Table  id="tabHead" width="80%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
		<Tr align="center" valign="middle">
			<Th width="10%"><input type="checkbox" name="chk" onclick='checkAll(this)'>&nbsp;</Th>
			<Th width="20%">RFQ</Th>
			<Th width="20%">Vendor</Th>
			<Th width="50%">Vendor Name</Th>
			
			
			
		</Tr>	
		</Table>
		</Div>
		<Div id="InnerBox1Div" style="overflow:auto;position:absolute;width:80%;height:60%;left:2%">
		<Table id="InnerBox1Tab" width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1>
<%
		Object []objArr=newVendSet.toArray();
		String vCode ="",vStatus="",className="";
		String vName="";
		for(int i=0;i<newVendCount;i++){
			java.util.Map.Entry entryObj = (java.util.Map.Entry)objArr[i];
			vCode =  (String)entryObj.getKey();
			vStatus = (String)vendHash.get(vCode) ;
			vName=(String)venodorsHT.get(vCode);
			if(vName==null||"null".equals(vName))vName="&nbsp;";
			
%>
			<Tr>
				<Td <%=className%> align="center" width="10%"><input type="checkbox" name="chk1" value="<%=vCode%>"></Td>
				<Td <%=className%> width="20%" align="center"><%=(String)vendorRFQHash.get(vCode)%></Td>
				<Td <%=className%> width="20%"><%=(String)entryObj.getValue()%></Td>
				<Td width="50%"><%=vName%>&nbsp;</Td>
			</Tr>
<%
		}
%>
		</Table>
		</Div>
		<Div align=center style="position:absolute;top:90%;visibility:visible;width:100%">
		
<%
          butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ok &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
          butNames.add("&nbsp;&nbsp;&nbsp; Close &nbsp;&nbsp;&nbsp;");   
    
          butActions.add("returnUsers()");
          butActions.add("window.close()");
          out.println(getButtons(butNames,butActions));

%>
		</Div>
<%
	}else{
%>
		
		
		<Div align=center style="position:absolute;top:30%;visibility:visible;width:100%">
			<Table align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1  width="50%">
			<Tr>
				<Th><%=message%></Th>
			</Tr>
			</Table>
		</Div>
<Div align=center style="position:absolute;top:90%;visibility:visible;width:100%">
<%
            butNames.add("&nbsp;&nbsp;&nbsp; Close &nbsp;&nbsp;&nbsp;");   
            butActions.add("window.close()");
            out.println(getButtons(butNames,butActions));
%>      
</Div>
<%
	}
%>	
</Form>
</Body>
