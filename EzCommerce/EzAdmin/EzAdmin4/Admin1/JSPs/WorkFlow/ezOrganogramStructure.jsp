<%@ include file="../../../Includes/JSPs/WorkFlow/iListOrganogramsLevels.jsp"%>
<script>
<%
	listRet.sort(new String[]{"ORGLEVEL"}, false);
%>
folderArr=new Array();
TopicArray=new Array();

<%
	int rowCount = listRet.getRowCount();
	int foldercount=0;
	int topiccount=0;
	String [] participant=new String[rowCount];
	String [] parent=new String[rowCount];
	int[] levels=new int[rowCount];
	String [] participantparent=new String[rowCount];
	for(int i=0;i<rowCount;i++)
	{
		participant[i]=listRet.getFieldValueString(i,"PARTICIPANT");
		parent[i]=listRet.getFieldValueString(i,"PARENT");
		levels[i]=Integer.parseInt(listRet.getFieldValueString(i,"ORGLEVEL"));
	}
	%>
	folderArr[0]=new ezFolder("",'<%=participant[0]%>');
	<%
	foldercount=1;
	participantparent[0]="root";
	for(int p=1;p<participant.length;p++)
	{
		String tempparent=parent[p];
		boolean set=false;
		for(int j=0;j<p;j++)
		{
			if(tempparent.equals(participant[j]))
			{
				 set=true;
				if(participantparent[j].equals("root"))
				 {
					participantparent[p]=parent[p];
					if(levels[p]>1)
					{%>
						folderArr[<%=foldercount%>]=new ezFolder('<%=participantparent[p]%>','<%=participant[p]%>');
					<%
					foldercount++;
					}else{%>
						TopicArray[<%=topiccount%>]=new ezTopic('<%=participantparent[p]%>',"",'<%=participant[p]%>');
					<%
					topiccount++;
					}
				 }
				else if((!participantparent[j].equals("root")) &&(!participantparent[j].equals("not")))
				 {
						//alert("in here 1"+participantparent[j]);
					participantparent[p]=participantparent[j]+"/"+parent[p];
					if(levels[p]>1)
					{%>
						folderArr[<%=foldercount%>]=new ezFolder('<%=participantparent[p]%>','<%=participant[p]%>');
					<%
					foldercount++;
					}else{%>
						TopicArray[<%=topiccount%>]=new ezTopic('<%=participantparent[p]%>',"",'<%=participant[p]%>');
					<%
					topiccount++;
					}
				}
			}
		}
		if(!set)
		{
			participantparent[p]="not";
		}
	}
%>	
function ezFolder(pFolder,cFolder)
{
	this.pFolder=pFolder;
	this.cFolder=cFolder;
}
function ezTopic(fFolder,fName,fContent)
{
	this.fContent=fContent;
	this.fName="javascript:void(0)";
	this.fFolder=fFolder;
}
</Script>

<html>
<head>
<script src="../../Library/JavaScript/EzTreeNew.js"></script>
<div style="position:absolute;visibility:hidden; top:0; left:0; "><table border=0><tr><td><a href=http://www.ezcommerceinc.com><font size=-2>EZC</font></a></td></tr></table></div>
<div id="id1" style="position:absolute; top:2%;height:95%; left:2%;">
<script>initializeDocument()</script>
</div>	
</head>
</html>
