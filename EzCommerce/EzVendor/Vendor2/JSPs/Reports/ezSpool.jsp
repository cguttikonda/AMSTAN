<%@page  import="ezc.ezparam.*,ezc.ezcommon.*"%>
<%@ page import="java.util.*" %>
<%@ page import="ezc.ezupload.params.*" %>
<jsp:useBean id="Manager" class="ezc.client.EzReportManager" />
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="EzUploadManager" class="ezc.ezupload.client.EzUploadManager" scope="session" />
<%String spool =request.getParameter("spool");
if(spool==null){String str=request.getParameter("repCounter");String execNo = "000000000000"+str;
response.setContentType("application/x-download");
response.setHeader ("Content-Disposition", "attachment;filename="+execNo+".pdf");
String system =request.getParameter("system");
String type = "PDF";
execNo=execNo.substring(execNo.length()-12,execNo.length());
        	EzExecReportParams mainParams = new EzExecReportParams();
        	EziPrintParams params= new EziPrintParams();
	        params.setObjectType("SP");
        	params.setObjectNo(execNo);
	        params.setDocType(type);
	        //params.setVendor((String)session.getValue("SOLDTO"));
	        mainParams.setSysNum("999");
	        mainParams.setObject(params);
	        Session.prepareParams(mainParams);
	        ezc.ezsap.V46B.generated.ZrawtabTable myTable=(ezc.ezsap.V46B.generated.ZrawtabTable)Manager.requestForStatus(mainParams);

        	int rowCount=myTable.getRowCount();
	        javax.servlet.ServletOutputStream sos=response.getOutputStream();
	        ezc.ezsap.V46B.generated.ZrawtabTableRow myTableRow=null;

	        for(int i=0;i<rowCount;i++)
	        {
        	        myTableRow=myTable.getRow(i);
	        	//out.println(String.valueOf(myTableRow.getZline()));
		        sos.write(myTableRow.getZline());
	        }
                sos.close();
        }else
        {
                String filename =request.getParameter("filename");
 	        EzcParams mainParams = new EzcParams(false);
                ezc.ezupload.params.EziUploadDocFilesParams myTable= new ezc.ezupload.params.EziUploadDocFilesParams();
	        String clientFName="";
	        try{
		        clientFName=filename.substring(filename.lastIndexOf("_")+1,filename.length());
	        }catch(Exception e){}
	        myTable.setClientFileName(clientFName);
                myTable.setServerFileName(filename);
        	mainParams.setObject(myTable);
	        Session.prepareParams(mainParams);
        	EzUploadManager.getFile(mainParams,response);
        }
%>
