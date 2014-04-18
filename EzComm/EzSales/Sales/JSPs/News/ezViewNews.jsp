<%@ include file="../../../Includes/JSPs/News/iViewNews.jsp"%>
<%

	String newsText		= request.getParameter("hiddenText");
	String newsSub 		= request.getParameter("hiddenSub");
	String readDate 	= request.getParameter("readDates");
	String readStat 	= request.getParameter("readStats");
	String ackStat 		= request.getParameter("ackStats");
	String createdOn	= request.getParameter("createdOns");
	String newsCat		= request.getParameter("newsCats");
	
	if("DP".equals(newsCat))
		newsCat = "Discontinued Products";
	if("GA".equals(newsCat))
		newsCat = "General Announcements";
	if("NP".equals(newsCat))
		newsCat = "New Products";
	if("PA".equals(newsCat))
		newsCat = "Promotion Announcements";
	if("PL".equals(newsCat))
		newsCat = "Products List Price";
	if("PRODSPEC".equals(newsCat))
		newsCat = "Market Area Net Price";
	if("PS".equals(newsCat))
		newsCat = "Account Statement";
	if("SLOB".equals(newsCat))
		newsCat = "Products on Clearance";

	
	String redirectPage	= "ezListNewsDash.jsp";
	String newsFilter	= request.getParameter("newsFilter");;
	if(newsFilter==null || "null".equals(newsFilter))newsFilter=""; 
	if("Y".equals(readFlag))
		redirectPage = "ezListNewsDash.jsp";
	HashMap ackMap = (HashMap)session.getValue("ACK_STAMP");	
	HashMap newsCnt = (HashMap)session.getValue("NEWS_CNT");	

	if(newsText!=null)
	{
		newsText = newsText.replaceAll("``","\"");
		newsText = newsText.replaceAll("`","\'");
	}

	//out.println("newsFilter::::::::::::::::"+newsFilter);
	//out.println("newsText::::::::::::::::"+newsText);
	//out.println("newsCnt::::::::::::::::"+newsCnt);
%>

<script type="text/javascript" src="../../Library/Script/jquery-ui-1.8.21.all.min.js"></script>
<script type="text/javascript">
function viewDocs(path)
{
	var dbClickOnFlNm = path
	if(dbClickOnFlNm!= null && dbClickOnFlNm!= "")
	{
		var winHandle = window.open("../News/ezViewNewsFile.jsp?CLOSEWIN=N&filePath="+dbClickOnFlNm);
	}	

}
function funAck(newsId)
{
	document.myForm.action="ezAckNews.jsp?newsId="+newsId
	document.myForm.submit()

}
function funBack()
{
	
<%
	if(!ackMap.containsKey(newsId) && "TA".equals(newsType))
	{
%>
		//$("#dialog-Alert").dialog('open');
<%
	}
%>	
	document.myForm.action="<%=redirectPage%>";
	document.myForm.submit();

}
function ezGetSelected(type)
{
	document.myForm.newsFilter.value = type
	document.myForm.action="ezListNewsDash.jsp"
	document.myForm.submit()	

}
$(function() {
	$( "#dialog-Alert" ).dialog({
		autoOpen: false,
		resizable: false,
		height:150,
		width:300,
		modal: true,
		buttons: {
			"Ok": function() {
				$( this ).dialog( "close" );
			}
		}
	});
		
}); // end of function()


</Script>
<style>
ul, ol {
	margin-left: 20px !important;
}
#newsList ol {list-style:decimal;}
#newsList ul {list-style:disc;}
</style>

<div class="main-container col2-left-layout middle account-pages">
<div class="hly-perftop"></div>
<div class="main">
<div class="col-main roundedCorners" style="width:920px;">
<div class="my-account">
<div class="dashboard">
<form name="myForm" method="post">
<div id="dialog-Alert" title="Acknowledge" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Please Acknowledge to go back.</p>
</div>

<div class="col1-set">
<div class="info-box">

<input type="hidden" name="newsFilter" value ='<%=newsFilter%>' >
	<table class="data-table" id="quickatp">
	<thead>
		<tr style="background:#ffc20e; color:#666; text-transform:uppercase;">
		<th align="a-justify"><h2 style="color:#666; margin-bottom: 0px;"><%=newsSub%></h2>
		<p><small style="font-size: 13px !important;color: #666;text-transform: capitalize;">News Type: <%=newsCat%></small></p>
		<p><small style="font-size: 10px !important;font-style: italic;color: #666;text-transform: capitalize;">published on <%=createdOn%></small></p>
		<p><small style="font-size: 10px !important;font-style: italic;color: #666;text-transform: capitalize;"><%=readStat%><%=readDate%><%=ackStat%></small></p>
		</th>
		</tr>
	</thead>
	<tbody>
	<tr>
		<td id="newsList"><h3></h3>
			<%=newsText%>
		</td>
	</tr>
	
<%
	if(uploadDocs!=null && uploadDocs.getRowCount()>0)
	{
%>
	<tr>
	<td>
<%	
		for(int i=0;i<uploadDocs.getRowCount();i++)
		{
			fileName=uploadDocs.getFieldValueString(i,"CLIENTFILENAME");
			tempPath=uploadDocs.getFieldValueString(i,"SERVERFILENAME");
%>			
			
			<a href="javascript:viewDocs('<%=tempPath%>')"><%=fileName%></a>
				
<%				
		}
	}
%>
		
	</td>
	</tr>
	
	</tbody>
	</table>
	<div class="buttons-set form-buttons">
<%
	if(!ackMap.containsKey(newsId) && "TA".equals(newsType))
	{
%>	
		<button type="submit" class="button" onClick="funAck('<%=newsId%>')"><span><span>Acknowledge</span></span></button>
<%
	}
	else
	{
%>	
		 <button type="button" class="button" onClick="funBack()"><span><span>Back</span></span></button>
<%
	}
%>
	 </div>	 
</div>
</div>

</div>
</div>
</div>
</div>
</div>
</form>