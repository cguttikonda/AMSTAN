<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Jsps/Misc/iblockcontrol.jsp" %>
<%@ include file="../../../Includes/Jsps/Rfq/iOfflineViewRFQDetails.jsp"%>
<%@ include file="../Rfq/ezGetMatUnits.jsp"%>
<%@ page import="ezc.ezutil.*,java.util.*"%>
<%@ include file="../../../Includes/Jsps/Misc/iShowCal.jsp"%>
<jsp:useBean id="ConfigManager" class="ezc.client.EzSystemConfigManager" scope="session"></jsp:useBean>
<%
	String reQtFlg  = "N";
	String vltnType = "";
	String txCode = "";
	String ordrUnit = "KG";
	String scrollInit = "";
	String loginType = (String)session.getValue("OFFLINE");
	if(loginType != null && "Y".equals(loginType))
		scrollInit="10";
	else
		scrollInit="100";	
	
	if (retHead!=null && retHead.getRowCount() > 0)
	{
		vltnType = rfqHeader.getFieldValueString(0,"VAL_TYPE");
		txCode   = rfqHeader.getFieldValueString(0,"TAX_CODE");
		ordrUnit = rfqHeader.getFieldValueString(0,"ORDER_UNIT");
	}
	
	if("null".equals(ordrUnit) || "".equals(ordrUnit) || ordrUnit==null)
		ordrUnit = "KG";
	
	String allconditions = "";
	
	if(retCond!=null && retCond.getRowCount()>0)
	{
		for(int i=0;i<retCond.getRowCount();i++)
		{
			String ctype	=retCond.getFieldValueString(i,"CONDITION_ID");
			String cvalue	=retCond.getFieldValueString(i,"CONDITION_VAL");
			String currency	=retCond.getFieldValueString(i,"CURRENCY");
			String perVal	=retCond.getFieldValueString(i,"PER");
			String unitofmsr=retCond.getFieldValueString(i,"UOM");
			allconditions	=allconditions+ctype+"*"+cvalue+"*"+currency+"*"+perVal+"*"+unitofmsr+"#";

		}
		allconditions = allconditions.substring(0,allconditions.length()-1);
	}	
	if(request.getParameter("conditionsString") != null)
		allconditions = request.getParameter("conditionsString");
		
	if(request.getParameter("orderUnit") != null)
		ordrUnit = request.getParameter("orderUnit");
%>
<html>
<head>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<Script>
	var tabHeadWidth=94
	var tabHeight="35%"
	
	/*var ordrUntLen = document.myForm.orderUnit.length;
	for(var i=0;i<soldToLen;i++)
	{
		if(document.myForm.orderUnit[i].value=='<%=ordrUnit%>')
		{
			document.myForm.orderUnit.selectedIndex=i;
			break;
		}
	}
	*/
	
	var matNum = "<%=dtlXML.getFieldValueString(0,"ITEM")%>";
	
</Script>

<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<Script src="../../Library/JavaScript/ezTrim.js"></Script>
<SCRIPT src="../../Library/JavaScript/Rfq/ezPostQuote.js"></Script>

</Head>

<body onLoad="scrollInit(<%=scrollInit%>)" onResize="scrollInit(<%=scrollInit%>)">
<form name="myForm" method="post">
<%
	String userType = (String)session.getValue("UserType");
	ezc.ezutil.FormatDate fd = new ezc.ezutil.FormatDate();
	Vector types = new Vector();
        types.addElement("date");
        EzGlobal.setColTypes(types);
		
        Vector names = new Vector();
	names.addElement("ORDERDATE");		
        EzGlobal.setColNames(names);        
        ezc.ezparam.ReturnObjFromRetrieve ret = EzGlobal.getGlobal((ezc.ezparam.ReturnObjFromRetrieve)dtlXML);

       String OrderDate = fd.getStringFromDate(ordDate,".",fd.DDMMYYYY);
        	
	//String OrderDate = ret.getFieldValueString(0,"ORDERDATE");
%>	

<input type="hidden" name="EndDate" value="<%=CDate%>">
<input type="hidden" name="OrderDate" value="<%=OrderDate%>">
<input type="hidden" value="<%=poNum%>" name="PurchaseOrder">
<input type="hidden" name="type" value="<%=request.getParameter("type")%>">

<%
	String display_header = "Quotation";
	String qtndate=FormatDate.getStringFromDate(new Date(),".",FormatDate.DDMMYYYY);
	
%>	

	<%@ include file="../Misc/ezDisplayHeader.jsp"%>

  	<br>
	<table align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1  width="94%">
		<tr>
			<th align="left" width="20%">RFQ Ref. No</th>
      			<td valign="middle" align="left" width="20%"><input type="hidden" name="RfqNo" value="<%=poNum%>"><%=poNum%></td>
			<th align="left" width="20%">RFQ Date</th>
        		<td valign="middle" align="left" width="20%"><%=OrderDate%></td>
			<th align="left" width="20%">Qtn. Date</th>
			<td valign="middle" align="left" width="20%"><%=FormatDate.getStringFromDate(new Date(),".",FormatDate.DDMMYYYY)%><input type="hidden" name="QtnDate" value="<%=qtndate%>"></td>
		</tr>
		<tr>
			<th align="left" width="20%">Qtn. Ref. No</th>
      			<td valign="middle" align="left" width="20%">
<%				String quotation="";
				if (retHead.getRowCount() > 0)
				{
					quotation = retHead.getFieldValueString(0,"QUOTATION");
					
					if(!"".equals(quotation))
						reQtFlg = "Y";
						
					if(request.getParameter("QtnRef") != null)
						quotation = request.getParameter("QtnRef");
																
				}
				
			if(request.getParameter("ExpireDt") != null)
				ExpireDt = request.getParameter("ExpireDt");
%>
       			<input type="text" class=InputBox  name="QtnRef" maxlength="10" size="15" value="<%=quotation%>">
			</td>
			<th align="left" width="20%" colspan="1">Quotation Exp. Date</th>
      			<td valign="middle" align="left" width="20%" colspan="3"><input type="text" name="priceValExpDate" class="InputBox" size=12 value="<%=ExpireDt%>" readonly> <img src="../../Images/calender.gif" style="cursor:hand" height="20" onClick=showCal("document.myForm.priceValExpDate",40,700,"<%=cDate%>","<%=cMonth%>","<%=cYear%>")></Td>
		</tr>
	</table>

	<DIV id="theads">
		<table id="tabHead" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1  width="94%">
			<tr align="center" valign="middle">
				<th width="12%">Material</th>
				<th width="25%">Description</th>
				<th width="8%">UOM</th>
				<th width="8%">Ord.Unit</th>
				<th width="8%">Qty</th>
				<th width="11%">Price</th>
				<th width="20%">Currency</th>
<%				if(!(userType.equals("3")))// && "".equals(quotation))
				{
%>					<th width="8%">Conditions</th>
<%				}
%>
			</tr>
		</table>
 	</DIV>

	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:96%;height:60%;left:2%">
	<TABLE id="InnerBox1Tab" width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
<%
		String curr="INR";

		

      		for(int i=0;i<Count;i++)
      		{
      			String amt = dtlXML.getFieldValueString(i,"AMOUNT");

      			if(amt!=null)
      				amt = amt.substring(0,amt.length()-2);

			if(request.getParameter("priceString") != null)
				amt = request.getParameter("priceString");
      			

			if( amt!=null)
			{
		      		curr=  dtlXML.getFieldValueString(i,"CURRENCY");
				if(request.getParameter("currencyString") != null)
					curr = request.getParameter("currencyString");
		      	}      	
		      	if(curr == null || "null".equals(curr) || "".equals(curr.trim()))
		      		curr="INR";
%>
      		<tr>
      		<td width="12%"><input type=hidden name="ItemNo" value="<%=dtlXML.getFieldValueString(i,"POSITION")%>">
<%
			try
			{
				out.println(Long.parseLong(dtlXML.getFieldValueString(i,"ITEM")));
			}
			catch(Exception e)
			{
				out.println(dtlXML.getFieldValueString(i,"ITEM"));
			}
%>
		</td>
      		<td width="25%"><%=dtlXML.getFieldValueString(i,"ITEMDESCRIPTION")%></td>
      		<td width="8%"><%=dtlXML.getFieldValueString(i,"UOMPURCHASE")%></td>
      		<td width="8%">
      		<Select name="orderUnit" style="width:100%" id="CalendarDiv">
      			<Option value="-">Select</Option>
<%		
		for(int k=0;k<retMatUnitsCnt;k++)
		{
%>	
			<Option value="<%=retMatUnits.getFieldValueString(k,"UOM")%>"><%=retMatUnits.getFieldValueString(k,"DESCRIPTION")%></Option>
<%
		}
%>
      		</Select>
      		</td>
<%
	String quantityString = dtlXML.getFieldValueString(i,"ORDEREDQUANTITY");
	if(request.getParameter("quantityString") != null)
		quantityString = request.getParameter("quantityString");
	if((userType.equals("3")))
	{
%>
      		<td width="8%" align="right"><%=quantityString%></td>
      		<Input type="hidden" name="updtdQty" value="<%=quantityString%>">
<%
	}
	else
	{
%>
		<td width="8%" align="right"><Input type="text" size="10" name="updtdQty" value="<%=quantityString%>" class= "InputBox" maxlength="7"> </td>
<%
	}
%>
      		<td width="11%"><input type=text name="Price" size=16 maxlength=14 class=InputBox value="<%=amt%>"></td>
      		<td width="20%">
			<select name="Curr" class=InputBox style="width:100%" id="CalendarDiv">
				<option value="INR">INR --> Indian Rupee</option>
				<option value="USD">USD --> American Dollars</option>
				<option value="JPY">JPY --> Japanese Yen</option>
				<option value="ACU">ACU-->ASIAN CLEARING UNION CURRENCY</option>
				<option value="ADP">ADP-->Andoran peseta</option>
				<option value="AED">AED-->United Arab Emirates Dirham</option>
				<option value="AFA">AFA-->Afghani</option>
				<option value="ALL">ALL-->Albanian Lek</option>
				<option value="AMD">AMD-->Armenian Dram</option>
				<option value="ANG">ANG-->West Indian Guilder</option>
				<option value="AOK">AOK-->Angolan Kwanza</option>
				<option value="ARA">ARA-->Argentinian Austral</option>
				<option value="ATS">ATS-->Austrian Schilling</option>
				<option value="AUD">AUD-->Australian Dollar</option>
				<option value="AUDN">AUDN-->Australian dollar extra decimals</option>
				<option value="AWG">AWG-->Aruban Guilder</option>
				<option value="AZM">AZM-->Azerbaijan Manat</option>
				<option value="BAD">BAD-->Bosnia-Herzogovinian Dinar</option>
				<option value="BBD">BBD-->Barbados Dollar</option>
				<option value="BDT">BDT-->Bangladesh Taka</option>
				<option value="BEF">BEF-->Belgian Franc</option>
				<option value="BGL">BGL-->Bulgarian Lev</option>
				<option value="BHD">BHD-->Bahrain Dinar</option>
				<option value="BIF">BIF-->Burundi Franc</option>
				<option value="BMD">BMD-->Bermudan Dollar</option>
				<option value="BND">BND-->Brunei Dollar</option>
				<option value="BOB">BOB-->Bolivian peso</option>
				<option value="BRC">BRC-->Brazilian Real</option>
				<option value="BRL">BRL-->Brazilian Real (new)</option>
				<option value="BSD">BSD-->Bahaman Dollar</option>
				<option value="BWP">BWP-->Botswana Pula</option>
				<option value="BYR">BYR-->Belorussian Ruble</option>
				<option value="BZD">BZD-->Belize Dollar</option>
				<option value="CAD">CAD-->Canadian Dollar</option>
				<option value="CFR">CFR-->CAMEROON FRANC</option>
				<option value="CHF">CHF-->Swiss Franc</option>
				<option value="CLP">CLP-->Chilean Peso</option>
				<option value="CNY">CNY-->Chinese yuan</option>
				<option value="COP">COP-->Columbian Peso</option>
				<option value="CRC">CRC-->Costa Rica Colon</option>
				<option value="CUP">CUP-->Cuban Peso</option>
				<option value="CVE">CVE-->Cape Verde Escudo</option>
				<option value="CYP">CYP-->Cyprus Pound</option>
				<option value="CZK">CZK-->Czech Krona</option>
				<option value="DEM">DEM-->German Mark</option>
				<option value="DJF">DJF-->Djibouti Franc</option>
				<option value="DKK">DKK-->Danish Krone</option>
				<option value="DOP">DOP-->Dominican Peso</option>
				<option value="DZD">DZD-->Algerian Dinar</option>
				<option value="ECS">ECS-->Ecuador Sucre</option>
				<option value="EEK">EEK-->Estonian Krone</option>
				<option value="EGP">EGP-->Egyptian Pound</option>
				<option value="ESP">ESP-->Spanish Peseta</option>
				<option value="ETB">ETB-->Ethiopian Birr</option>
				<option value="EU$">EU$-->Pricing Euro for Decimals > 2</option>
				<option value="EUR">EUR-->EURO</option>
				<option value="FIM">FIM-->Finnish Mark</option>
				<option value="FJD">FJD-->Fiji Dollar</option>
				<option value="FKP">FKP-->Falkland Pound</option>
				<option value="FRF">FRF-->French Franc</option>
				<option value="GBP">GBP-->British Pound</option>
				<option value="GEK">GEK-->Georgian Kupon</option>
				<option value="GHC">GHC-->Ghanian Cedi</option>
				<option value="GIP">GIP-->Gibraltar Pound</option>
				<option value="GMD">GMD-->Gambian Dalasi</option>
				<option value="GNF">GNF-->Guinea Franc</option>
				<option value="GRD">GRD-->Greek Drachma</option>
				<option value="GTQ">GTQ-->Guatemalan Quetzal</option>
				<option value="GWP">GWP-->Guinea Peso</option>
				<option value="GYD">GYD-->Guyanese Dollar</option>
				<option value="HKD">HKD-->Hong Kong Dollar</option>
				<option value="HNL">HNL-->Honduran Lempira</option>
				<option value="HRD">HRD-->Croatian Dinar</option>
				<option value="HTG">HTG-->Haitian Gourde</option>
				<option value="HUF">HUF-->Hungarian Forint</option>
				<option value="IDR">IDR-->Indonesian Rupiah</option>
				<option value="IEP">IEP-->Irish Pound</option>
				<option value="ILS">ILS-->Israeli Scheckel</option>
				<option value="IQD">IQD-->Iraqui Dinar</option>
				<option value="IRR">IRR-->Iranian Rial</option>
				<option value="ISK">ISK-->Iceland Krona</option>
				<option value="ITL">ITL-->Italian Lira</option>
				<option value="JMD">JMD-->Jamaican Dollar</option>
				<option value="JOD">JOD-->Jordanian Dinar</option>
				<option value="KES">KES-->Kenyan Shilling</option>
				<option value="KHR">KHR-->Cambodian Riel</option>
				<option value="KIS">KIS-->Kirghizstan Som</option>
				<option value="KMF">KMF-->Comoros Franc</option>
				<option value="KPW">KPW-->North Korean Won</option>
				<option value="KRW">KRW-->South Korean Won</option>
				<option value="KWD">KWD-->Kuwaiti Dinar</option>
				<option value="KYD">KYD-->Cayman Dollar</option>
				<option value="KZT">KZT-->Kazakhstani Tenge</option>
				<option value="LAK">LAK-->Laotian Kip</option>
				<option value="LBP">LBP-->Lebanese Pound</option>
				<option value="LKR">LKR-->Sri Lankan Rupee</option>
				<option value="LRD">LRD-->Liberian Dollar</option>
				<option value="LSL">LSL-->Lesotho Loti</option>
				<option value="LTL">LTL-->Lithuanian Lita</option>
				<option value="LUF">LUF-->Luxembourgian Franc</option>
				<option value="LVL">LVL-->Latvian Lat</option>
				<option value="LYD">LYD-->Libyan Dinar</option>
				<option value="MAD">MAD-->Moroccan Dirham</option>
				<option value="MDL">MDL-->Moldavian Lei</option>
				<option value="MGF">MGF-->Madagascan Franc</option>
				<option value="MMK">MMK-->Myanmar currency</option>
				<option value="MNT">MNT-->Mongolian Tugrik</option>
				<option value="MOP">MOP-->Macao Pataca</option>
				<option value="MRO">MRO-->Mauritanian Ouguiya</option>
				<option value="MTL">MTL-->Maltese Lira</option>
				<option value="MUR">MUR-->Mauritian Rupee</option>
				<option value="MVR">MVR-->Maldive Rufiyaa</option>
				<option value="MWK">MWK-->Malawi Kwacha</option>
				<option value="MXN">MXN-->Mexican Peso (new)</option>
				<option value="MXP">MXP-->Mexican Peso (old)</option>
				<option value="MYR">MYR-->Malaysian Ringgit</option>
				<option value="MZM">MZM-->Mozambique Metical</option>
				<option value="NGN">NGN-->Nigerian Naira</option>
				<option value="NIC">NIC-->Nicaraguan Cordoba</option>
				<option value="NLG">NLG-->Dutch Guilder</option>
				<option value="NOK">NOK-->Norwegian Krone</option>
				<option value="NPR">NPR-->Nepalese Rupee</option>
				<option value="NZD">NZD-->New Zealand Dollars</option>
				<option value="OMR">OMR-->Omani Rial</option>
				<option value="PAB">PAB-->Panamanian Balboa</option>
				<option value="PEI">PEI-->Peruvian Inti</option>
				<option value="PGK">PGK-->Papua New Guinea Kina</option>
				<option value="PHP">PHP-->Philippino Peso</option>
				<option value="PKR">PKR-->Pakistani Rupee</option>
				<option value="PLZ">PLZ-->Polish Zloty</option>
				<option value="PTE">PTE-->Portuguese Escudo</option>
				<option value="PYG">PYG-->Paraguayan Guarani</option>
				<option value="QAR">QAR-->Qatar Riyal</option>
				<option value="RMB">RMB-->Chinese Renminbi Yuan</option>
				<option value="ROL">ROL-->Roumanian Lei</option>
				<option value="RUB">RUB-->Russian Rouble</option>
				<option value="RUE">RUE-->		</option>
				<option value="RUR">RUR-->Russian Rubel</option>
				<option value="RWF">RWF-->Rwanda Franc</option>
				<option value="SAR">SAR-->Saudi Riyal</option>
				<option value="SBD">SBD-->Solomon Islands Dollar</option>
				<option value="SCR">SCR-->Seychelles Rupee</option>
				<option value="SDP">SDP-->Sudanese Pound</option>
				<option value="SEK">SEK-->Swedish Krona</option>
				<option value="SGD">SGD-->Singapore Dollar</option>
				<option value="SHP">SHP-->St.Helena Pound</option>
				<option value="SIT">SIT-->Slovenian Tolar</option>
				<option value="SKK">SKK-->Slovakian Krona</option>
				<option value="SLL">SLL-->Leone</option>
				<option value="SOS">SOS-->Somalian Shilling</option>
				<option value="SRG">SRG-->Surinam Guilder</option>
				<option value="STD">STD-->Sao Tome / Principe Dobra</option>
				<option value="SUR">SUR-->Russian Ruble (old)</option>
				<option value="SVC">SVC-->El Salvador Colon</option>
				<option value="SYP">SYP-->Syrian Pound</option>
				<option value="SZL">SZL-->Swaziland Lilangeni</option>
				<option value="THB">THB-->Thailand Bhat</option>
				<option value="TJR">TJR-->Tadzhikistani Ruble</option>
				<option value="TMM">TMM-->Turkmenistani Manat</option>
				<option value="TND">TND-->Tunisian Dinar</option>
				<option value="TOP">TOP-->Tongan Pa'anga</option>
				<option value="TPE">TPE-->Timor Escudo</option>
				<option value="TRL">TRL-->Turkish Lira</option>
				<option value="TTD">TTD-->Trinidad and Tobago Dollar</option>
				<option value="TWD">TWD-->New Taiwan Dollar</option>
				<option value="TZS">TZS-->Tanzanian Shilling</option>
				<option value="UAH">UAH-->Ukrainian Hryvnia</option>
				<option value="UAK">UAK-->Ukrainian Karbowanez</option>
				<option value="UGS">UGS-->Ugandan Shilling</option>
				<option value="USDN">USDN-->HR: US dollars with 5 decimal places</option>
				<option value="UYP">UYP-->Uruguayan New Peso</option>
				<option value="VEB">VEB-->Venezuelan Bolivar</option>
				<option value="VND">VND-->Vietnamese Dong</option>
				<option value="VUV">VUV-->Vanuatu Vatu</option>
				<option value="WST">WST-->Samoan Tala</option>
				<option value="XAF">XAF-->Gabon C.f.A Franc</option>
				<option value="XCD">XCD-->East Carribean Dollar</option>
				<option value="XEU">XEU-->European Currency Unit (E.C.U.)</option>
				<option value="XOF">XOF-->Benin C.f.A. Franc</option>
				<option value="YER">YER-->Yemeni Ryal</option>
				<option value="ZAR">ZAR-->South African Rand</option>
				<option value="ZMK">ZMK-->Zambian Kwacha</option>
				<option value="ZRZ">ZRZ-->Zaire</option>
				<option value="ZWD">ZWD-->Zimbabwean Dollar</option>
			</select>
     		</td>
<%		if(!(userType.equals("3")))// && "".equals(quotation))
		{
%>     			<td width="8%"><a href="javascript:funOpen(<%=i%>,'<%=i%>')"> Click</a></td>
<%		}
%> 		</tr>
<%		}
%>
	<input type="hidden" name="allconditions" value="<%=allconditions%>">
	<input type="hidden" name="allconditionsinrequote" value="">
	</table>
	</div>

	<div id="bottompart" style="position:absolute;top:54%;width:100%;visibility:visible" align="center">
	<table align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1  width="94%">
<%
	String payterm="";
	if(!(userType.equals("3")))
	{	
%>	
	<tr>
		<th align="left" width="20%">Valuation Type</th>
		<td width="30%">
		<div id="listBoxDiv1">
		<select id="CalendarDiv" name="valType" style="width:100%">
			<option value="">Select Valuation Type</option>
<%
	if(request.getParameter("valType") != null)
		vltnType = request.getParameter("valType");
		
	for(int k=0;k<valuationTypes.length;k++)
	{
		if(valuationTypes[k].equals(vltnType))
		{
%>
			<Option value="<%=valuationTypes[k]%>" selected><%=valuationTypes[k]%></Option> 
<%			
		}
		else
		{
%>		
			<Option value="<%=valuationTypes[k]%>"><%=valuationTypes[k]%></Option>
<%
		}
	}
%>
			
		</select>
		</Div>
		</td>
		<th align="left" width="20%">Tax Code</th>
		<td width="30%">
		<div id="listBoxDiv1">
		<select name="taxCode"  style="width:100%" id="CalendarDiv">
		<option value="">Select Tax Code</option>

<%			
		
		
		if(request.getParameter("taxCode") != null)
			txCode = request.getParameter("taxCode");
		
		while(taxIterator.hasNext())
		{
			taxObj = taxIterator.next();
			String taxStr = taxObj.toString();
			if(txCode==null || "null".equals(txCode) || "".equals(txCode))
				txCode = "AA";	
		
			if(taxStr.equals(txCode.trim()))
			{
%>	
				<Option value="<%=taxStr%>" selected><%=taxStr%>--><%=taxTM.get(taxStr)%></Option>
<%
			}
			else
			{
%>				<Option value="<%=taxStr%>" ><%=taxStr%>--><%=taxTM.get(taxStr)%></Option>
<%			}
		}
%>		
		</select>
		</div>
		</td>		

	</tr>
<%
	}
%>	
	<tr>
		<th align="left" width="20%">Payment terms</th>
		<td width="30%">
		<div id="listBoxDiv1">
		<select id="CalendarDiv" name=PaymentTerms style="width:100%">
		<option value="">Select Payment Terms</option>
<%
		
		String incoterm="";
		String incoterm2="";
	
		if (retHead.getRowCount() > 0)
		{
			payterm=retHead.getFieldValueString(0,"PMNTTERM");
			incoterm=retHead.getFieldValueString(0,"INCOTERM1");
			incoterm2=retHead.getFieldValueString(0,"INCOTERM2");
		}
		
		if(request.getParameter("IncoTerms") != null)
			incoterm=request.getParameter("IncoTerms");
			
		if(request.getParameter("PaymentTerms") != null)
			payterm=request.getParameter("PaymentTerms");
			
	
	      	while(payIterator.hasNext())
		{
			payObj = payIterator.next();
			String payStr = payObj.toString();
			if(payStr.equals(payterm))
			{
%>				<Option value=<%=payStr%> selected><%=payStr%>--><%=payTM.get(payStr)%></Option>
<%
			}
			else
			{
%>				<Option value=<%=payStr%> ><%=payStr%>--><%=payTM.get(payStr)%></Option>
<%			}
		}
%>
		</select>
		</Div>
		</td>
		<th align="left" width="20%">Inco Terms</th>
		<td width="30%">
		<div id="listBoxDiv1">
		<select name=IncoTerms style="width:100%" id="CalendarDiv">
		<option value="">Select Inco Terms</option>
<%
		String incoStr="",inco2 ="";
	      	while(incoIterator.hasNext())
		{
			incoObj = incoIterator.next();
			incoStr = incoObj.toString();
			inco2   = (String)incoTM.get(incoStr);
			if(incoStr.equals(incoterm))
			{
%>
				<Option value="<%=incoStr%>¥<%=inco2%>" selected><%=incoStr%>--><%=inco2 %></Option>
<%
			}
			else
			{
%>
				<Option value="<%=incoStr%>¥<%=inco2%>" ><%=incoStr%>--><%=inco2 %></Option>
<%
			}
		}
%>
		</select>
		</div>
		</td>
	</Tr>

<%
	if(request.getParameter("IncoTermsDesc") != null)
		incoterm2 = request.getParameter("IncoTermsDesc");
%>
	
	<Tr>
	<Th align="left" width="20%">Inco Terms Details</Th>
	<Td width="80%" colspan=3><font size=4><input type=text name="IncoTermsDesc" size=54 maxlength=28 class=InputBox value='<%=incoterm2%>'></font></Td>
	<Tr>
	<Th align="left" width="20%">Remarks</Th>
<%
	String remks = "";
	try
	{
		if (htexts.get(poNum)!=null)
			remks =(String)htexts.get(poNum.trim());
	}
	catch(Exception ex)
	{
	}
	if(request.getParameter("Remarks") != null)
		remks = request.getParameter("Remarks");
%>
	<td width="80%" colspan=3><textarea name="Remarks" rows=3 style="width:100%;overflow:auto"><%=remks%></textarea></td>
	</table>
	</div>

<%
	for(int i=0;i<rfqDetails.getRowCount();i++)
	{
	 	Date dDate = (java.util.Date)rfqDetails.getFieldValue(i,"DELIVERY_DATE");
	 	String delivDate = FormatDate.getStringFromDate(dDate,".",FormatDate.DDMMYYYY);
%>	

      		<input type=hidden name="counter" value="<%=rfqDetails.getFieldValueString(i,"COUNTER")%>">
      		<input type=hidden name="material" value="<%=rfqDetails.getFieldValueString(i,"MATERIAL")%>">
      		<input type=hidden name="materialDesc" value="<%=rfqDetails.getFieldValueString(i,"MATERIAL_DESC")%>">
      		<input type=hidden name="uom" value="<%=rfqDetails.getFieldValueString(i,"UOM")%>">
      		<input type=hidden name="quantity" value="<%=rfqDetails.getFieldValueString(i,"QUANTITY")%>">
      		<input type=hidden name="delivDate" value="<%=delivDate%>">
		<input type=hidden name="plant" value="<%=rfqDetails.getFieldValueString(i,"PLANT")%>">      		
<%	}
%>
	<br>
	<div id="buttons" style="position:absolute;top:90%;width:100%;visibility:visible" align="center">
	<Table>
	<Tr>
		<Td class=blankcell>
			<span id="EzButtonsSpan" >	
				<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif"  style="cursor:hand" border=0 onClick="javascript:goBack()">
				<img src="../../Images/Buttons/<%=ButtonDir%>/submit.gif" style="cursor:hand" border=none onClick="JavaScript:SubmitQuote()">
				<img src="../../Images/Buttons/<%=ButtonDir%>/clear.gif" style="cursor:hand" border=none onClick="document.myForm.reset()">
			</span>
			<span id="EzButtonsMsgSpan" style="display:none">
				<Table align=center>
				<Tr>
					<Td class="labelcell">Your request is being processed... Please wait</Td>
				</Tr>
				</Table>
			</span>
		</Td>
	</Tr>
</Table>
		
	</div>
<Input type="hidden" name="reQtFlg" value="<%=reQtFlg%>">
<Input type="hidden" name="OldCur" value="<%=curr%>">
</form>
<Div id="MenuSol"></Div>
</body>
<Script>
	function setDefaultFields(curr,ordUnit)
	{
		var optLen = document.myForm.Curr.options.length
		for(i=0;i<optLen;i++)	
		{
			if(document.myForm.Curr.options[i].value == curr)
			{	
				document.myForm.Curr.selectedIndex = i
				break; 
			}
		}
		
		var ordrUntLen = document.myForm.orderUnit.length;
		for(var i=0;i<ordrUntLen;i++)
		{
			if(document.myForm.orderUnit[i].value==ordUnit)
			{
				document.myForm.orderUnit.selectedIndex=i;
				break;
			}
		}
		
	}
	setDefaultFields('<%=curr%>','<%=ordrUnit%>')
</Script>
</html>
