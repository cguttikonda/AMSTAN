<%@ page import="ezc.ezparam.*" %>
<%@ page import="java.util.*" %>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="AppManager" class="ezc.ezvendorapp.client.EzVendorAppManager" scope="session"></jsp:useBean>
<jsp:useBean id="UploadManager" class="ezc.ezupload.client.EzUploadManager" scope="session"></jsp:useBean>

<%

	String sysKey= (String)session.getValue("SYSKEY");
	String soldTo = (String)session.getValue("SOLDTO");


	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
   	ezc.ezvendorapp.params.EzMaterialRequestStructure reqStruct =  new ezc.ezvendorapp.params.EzMaterialRequestStructure();

   	ezc.ezvendorapp.params.EzMaterialResponseStructure resStruct =  new ezc.ezvendorapp.params.EzMaterialResponseStructure();

	String userType = (String)session.getValue("UserType");
	String type = request.getParameter("Type");

	String requestId="";
	String refNum="";

	StringTokenizer st = new StringTokenizer(request.getParameter("chk1"),"#");
	requestId = st.nextToken();

	if(userType.equals("3"))
        {
	   refNum = st.nextToken();
        }

	reqStruct.setRequestId(requestId);

	resStruct.setRequestId(requestId+refNum);

	ezc.client.EzcPurchaseUtilManager PurManager = new ezc.client.EzcPurchaseUtilManager(Session);
	ReturnObjFromRetrieve retcatarea = (ReturnObjFromRetrieve)PurManager.getUserPurAreas();
	int catareaRows = retcatarea.getRowCount();

	String sKey = "";
	for(int i=0;i<catareaRows;i++)
	{
		sKey = sKey+retcatarea.getFieldValueString(i,"ESKD_SYS_KEY")+"','";
	}
	sKey = sKey.substring(0,sKey.length()-3);
	resStruct.setSysKey(sKey);
	resStruct.setSoldTo(soldTo);

	mainParams.setObject(reqStruct);
	mainParams.setObject(resStruct);

	mainParams.setLocalStore("Y");
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve ret= (ezc.ezparam.ReturnObjFromRetrieve)AppManager.ezGetMaterialResponse(mainParams);

        ezc.ezparam.ReturnObjFromRetrieve reqHeader =  (ezc.ezparam.ReturnObjFromRetrieve)ret.getFieldValue(0,"REQHEADER");
        ezc.ezparam.ReturnObjFromRetrieve resHeader =  (ezc.ezparam.ReturnObjFromRetrieve)ret.getFieldValue(0,"RESPONSES");

	int resCount = resHeader.getRowCount();
	ReturnObjFromRetrieve retFiles = null;
	int filesCount=0;
	String serverCoa="";
	String serverStp="";
	String fileName="";
	String fileType="";
	String tempServerFile="";
	String tempFileName="";
	String newTempServerFile="";

	if(resCount>0)
	{

	    if(type.equals("N"))
	    {
		ezc.ezparam.EzcParams listMainParams = null;
		ezc.ezupload.params.EziUploadDocsParams listParams= null;

		listMainParams = new ezc.ezparam.EzcParams(false);
		listParams= new ezc.ezupload.params.EziUploadDocsParams();
		listParams.setObjectNo("'"+sysKey+"MATRESP"+requestId+soldTo+refNum+"'");
		listMainParams.setObject(listParams);
		Session.prepareParams(listMainParams);
		ReturnObjFromRetrieve retUpload = (ReturnObjFromRetrieve)UploadManager.getUploadedDocs(listMainParams);

		if (retUpload.getRowCount()>0){

			retFiles = (ReturnObjFromRetrieve)retUpload.getFieldValue(0,"FILES");
			filesCount = retFiles.getRowCount();
			Vector v = new Vector();
			v.addElement("COA");
			v.addElement("STP");

			boolean flag=false;
			for(int j=0;j<v.size();j++)
			{


				for(int i=0;i<filesCount;i++)
				{
					flag=false;
					fileType=retFiles.getFieldValueString(i,"TYPE");
					if(fileType.equals((String)v.elementAt(j)))
					{
					    flag=true;
					    tempFileName = retFiles.getFieldValueString(i,"CLIENTFILENAME");
					    newTempServerFile = retFiles.getFieldValueString(i,"SERVERFILENAME");
					    break;
					}

				 }

				if(flag)
				{
	                                  tempServerFile = tempServerFile+newTempServerFile+"#"+(String)v.elementAt(j)+"^";
				          fileName=fileName+tempFileName+"#"+(String)v.elementAt(j)+"^";
				 }
				 else
				 {
				          tempServerFile = tempServerFile+"-#"+(String)v.elementAt(j)+"^";
				          fileName=fileName+"-#"+(String)v.elementAt(j)+"^";
				}


			 }
			 fileName = fileName.substring(0,fileName.length()-1);
			 tempServerFile = tempServerFile.substring(0,tempServerFile.length()-1);

			 StringTokenizer str = new  StringTokenizer(tempServerFile,"^");
			while(str.hasMoreTokens())
			{
			 	String temp = str.nextToken();
				if(temp.indexOf("#COA")>0)
				{
				    serverCoa = temp.substring(0,temp.indexOf("#COA"));
				    serverCoa = serverCoa.equals("-")?	"¥":serverCoa;
				}
				else if(temp.indexOf("#STP")>0)
				{
				    serverStp = temp.substring(0,temp.indexOf("#STP"));
				    serverStp = serverStp.equals("-")?"¥":serverStp;
				}

			}
		}
           	}
      }

%>
