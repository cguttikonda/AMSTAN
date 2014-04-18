<%

	String htmlStyle="<style><!-- a:active {color: BLUE} a:hover {color: coral} a:link {color: indigo}";
	htmlStyle=htmlStyle + " .subclass{font-family: Verdana;	font-size: 10pt;font-style: normal;font-weight: normal;color: white;";
	htmlStyle=htmlStyle + "} a.subclass{ 	color: white; 	text-decoration:underline; }";
	htmlStyle=htmlStyle + " a.subclass:active {color: yellow} a.subclass:hover {color: yellow}";
	htmlStyle=htmlStyle + "a.subclass:link {color: yellow}a.subclass:visited{color: WHITE}";
	htmlStyle=htmlStyle + " td { font-family: 'Arial, Helvetica'; font-size: 10pt; 	font-style: bold;color: '#000000';background-color: '#E1EBF4'}";
	htmlStyle=htmlStyle + ".bodyclass{}body.bodyclass{background-color: #336699}";
	htmlStyle=htmlStyle + ".displayheader{}td.displayheader{ font-family: 'Arial'; font-size: 14pt; font-style: bold; color: #FFFFFF;	background-color: #1f5090 }";
	htmlStyle=htmlStyle + ".labelcell{}td.labelcell{ 	font-family: 'Verdana'; font-size: 14pt; font-style: bold; color: '#336699';background-color:'#72A0CF' }";
	htmlStyle=htmlStyle + ".blankcell{} td.blankcell { background-color: #FFFFFF }";
	htmlStyle=htmlStyle + "table {font-family: 'Verdna';font-size: 14pt; font-style: normal; color: '#330099'}";
	htmlStyle=htmlStyle + "th {font-family: Verdana;font-size: 10pt;font-style: normal;font-weight: bold;color:'#FFFFFF';bgColor:'#336699';backGround-color:'#336699'}";
	htmlStyle=htmlStyle + "body {color:'#6699FF';background-color:'#336699'}";
	htmlStyle=htmlStyle + "tr {  	font-family: 'Trebuchet MS'; font-size: 10pt; font-style: normal;line-height: normal;font-weight: normal;	color:'#000066'}";
	htmlStyle=htmlStyle + "--></style>";

	String tempPono=retMailHeader.getFieldValueString(0,"PONO");
	try
	{
		tempPono=String.valueOf(Long.parseLong(retMailHeader.getFieldValueString(0,"PONO")));
	}catch(Exception e){ }

	String htmlHeader="<html><head>" + htmlStyle + "</head><body bgColor='#152993'><Table align=center><Tr><Td class=labelcell>RanbaxyPartners  Shipment Info posted for " +  tempPono + "</Td></Tr></Table><BR><BR>";
	htmlHeader=htmlHeader + "<Table  border='1' cellspacing='0'   align='center' width='100%' >";

	htmlHeader=htmlHeader + "<Tr align='center' valign='middle'>";
	htmlHeader=htmlHeader + "<Th  align='left' width='25%' >Delivery Challan</Th><Td width='25%'>" + retMailHeader.getFieldValue(0,"DCNO") + "</Td>";
	htmlHeader=htmlHeader + "<Th align='left' width='25%'>DC Date</Th><Td width='25%'>" + retMailHeader.getFieldValue(0,"DCDATE") + "</Td></Tr>";

	htmlHeader=htmlHeader + "<Tr align='center' valign='middle'>";
	htmlHeader=htmlHeader + "<Th  align='left' width='25%'>Invoice Number</Th><Td  width='25%'>" + retMailHeader.getFieldValue(0,"INVNO") + "</Td>";
	htmlHeader=htmlHeader +" <Th  align='left' width='25%'>Invoice Date</Th><Td width='25%'>" + retMailHeader.getFieldValue(0,"INVDATE") + "</Td></Tr>";

	htmlHeader=htmlHeader + "<Tr align='center' valign='middle'>";
	htmlHeader=htmlHeader + "<Th  align='left' width='25%'>LR/RR/AIR BILL Nr.</Th><Td width='25%'>" + retMailHeader.getFieldValue(0,"LRNO") + "</Td>";
	htmlHeader=htmlHeader + "<Th  align='left' width='25%'>Ship Date</Th><Td width='25%' >" + retMailHeader.getFieldValue(0,"SHIPDATE") + "</Td></Tr>";

	htmlHeader=htmlHeader + "<Tr align='center' valign='middle'>";
 	htmlHeader=htmlHeader + "<Th  align='left' width='25%'>Carrier Name</Th><Td width='25%'>" + retMailHeader.getFieldValue(0,"CNAME") + "</Td>";
	htmlHeader=htmlHeader + "<Th  align='left' width='25%'>ExpectedArrivalDate</Th><Td width='25%'>" + retMailHeader.getFieldValue(0,"EXPDATE") + "</Td></Tr>";


	htmlHeader=htmlHeader + "<Tr align='center' valign='middle'>";
	htmlHeader=htmlHeader + "<Th align='left' width='25%'>General Text</Th><Td width='75%' colspan='3' align='left'>" + retMailHeader.getFieldValue(0,"TEXT") + "</Td></Tr></Table>";




	String htmlLines="<Table align='center'  border='1' cellspacing='0'  width='100%'>";
	htmlLines=htmlLines + "<Tr><Th  width='6%'>Line</Th><Th class='colhead' width='15%'>Material</Th>";
	htmlLines=htmlLines + "<Th  width='54%'>Description</Th><Th class='colhead' width='10%'>UOM</Th>";
	htmlLines=htmlLines + "<Th  width='15%'>Qty</Th></Tr>";

	for(int i=0;i<retMail.getRowCount();i++)
	{

		String tempMatNo=retMail.getFieldValueString(i,"MATNO");
		try{ tempMatNo=String.valueOf(Long.parseLong(retMail.getFieldValueString(i,"MATNO"))); }
		catch(Exception e){ }

		htmlLines=htmlLines + "<Tr><Td align='center' width='6%'>" + retMail.getFieldValue(i,"LINE") + " </Td>";
		htmlLines=htmlLines + "<Td align='left' width='15%'>" +  tempMatNo + "</Td>";
		htmlLines=htmlLines + "<Td width='54%'>" + retMail.getFieldValue(i,"MATDESC") + "</Td>";
		htmlLines=htmlLines + "<Td width='10%'>" + retMail.getFieldValue(i,"UOM") + "</Td>";
		htmlLines=htmlLines + "<Td width='14%' align='center'>" + retMail.getFieldValue(i,"QTY") + "</Td></Tr>";
	}

	String htmlFooter="<Table><Tr><Td>Click <A href='http://www.ranbaxypartners.com'>here</a> to view more details</Td></Table><br><br>";
	htmlFooter=htmlFooter + "<Table align=left><Tr><Td>Regds,</Td></Tr><Tr><Td>" + session.getValue("Vendor")+ "[" + Session.getUserId()  +"]" + "</Td></Tr></Table>";
	htmlLines=htmlLines + "<br><br>" + htmlFooter  + "</body></html>";

	System.out.println(htmlHeader);
	System.out.println(htmlLines);


	String htmlText="";
	String to="";
	htmlText = htmlHeader+htmlLines;
	int extCount=extMailIds.size();
	
	if(extCount!=0)
	{
		to= (String) (extMailIds.elementAt(0));

		for(int j=1;j<extMailIds.size();j++)
		{
			 to =  to  + "," +  (String) (extMailIds.elementAt(j));
		}
		//to=to + ", nagesh.pulavarthi@ezcindia.com";

//Added By Nagesh
		   ezc.ezmail.EzcMailParams mailParams=new ezc.ezmail.EzcMailParams();	
	   	   mailParams.setGroupId("Ezc");
	   	   mailParams.setTo(to);
	   	 //  mailParams.setCC("");
	   	 //  mailParams.setBCC("");
	   	   mailParams.setMsgText(htmlText);
	   	   mailParams.setSubject(msgSubject+"[" + Session.getUserId() +"]");
	   	   mailParams.setSendAttachments(false);
	   	   mailParams.setContentType("text/html");
	   	   ezc.ezmail.EzMail myMail=new ezc.ezmail.EzMail();
	   	   boolean value=myMail.ezSend(mailParams,Session);
	
}

		   
%>

