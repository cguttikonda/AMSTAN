<%@page import="java.util.*"%>
<%

	String newsId	= request.getParameter("newsId");
	String sysKey	= request.getParameter("sysKey");
	String readFlag	= request.getParameter("readFlag_N");
	String newsType	= request.getParameter("newsType");
	String soldRead	= (String) session.getValue("AgentCode");
	String objectType	= "News";
	
	//out.println("newsId::::::"+newsId+":::::sysKey:::"+sysKey);
	String setVal=sysKey+objectType+newsId;
	int uploadDocRetCnt=0;
	ezc.ezparam.ReturnObjFromRetrieve uploadDocRet=null;
	ezc.ezparam.EzcParams myParams = new ezc.ezparam.EzcParams(true);
	ezc.ezupload.client.EzUploadManager uploadManager= new ezc.ezupload.client.EzUploadManager();
	ezc.ezupload.params.EziUploadDocsParams uDocsParams = new ezc.ezupload.params.EziUploadDocsParams();
	ezc.ezparam.ReturnObjFromRetrieve uploadDocs =null;
	
	uDocsParams.setObjectNo("'"+setVal+"'");
	myParams.setObject(uDocsParams);
	myParams.setLocalStore("Y");
	Session.prepareParams(myParams);
	try
	{
		System.out.println("before uploadDoc:");					
		uploadDocRet= (ezc.ezparam.ReturnObjFromRetrieve)uploadManager.getUploadedDocs(myParams);
		uploadDocs = (ezc.ezparam.ReturnObjFromRetrieve)uploadDocRet.getFieldValue(0,"FILES");
		if(uploadDocRet!=null)
			uploadDocRetCnt=uploadDocRet.getRowCount();		
	}
	catch(Exception e)
	{
		System.out.println("Exception Occured while Uploading docs:"+e);
	}
	
	ezc.eznews.client.EzNewsManager newsManager = null;
	ezc.eznews.params.EziNewsParams newsParam = null;
	ezc.ezparam.EzcParams mainParams_N=null;
	HashMap timeStamp = (HashMap)session.getValue("TIME_STAMP");
	//out.println("timeStamp::::::::::::::::::::"+timeStamp);
	
	/*if(newsId!=null && sysKey!=null && !(timeStamp.containsKey(newsId)))
	{
		Date today = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");

		mainParams_N=new ezc.ezparam.EzcParams(true);
		newsManager = new ezc.eznews.client.EzNewsManager();
		newsParam = new ezc.eznews.params.EziNewsParams();

		newsParam.setQType("T");
		newsParam.setNewsId(newsId);
		newsParam.setNewsSyskey(sysKey);
		newsParam.setTrackUser(Session.getUserId());
		newsParam.setTrackViewFlag("Y");
		newsParam.setTrackViewDate(formatter.format(today));
		newsParam.setTrackAckFlag("");
		newsParam.setNewsExt1("Y");

		mainParams_N.setLocalStore("Y");
		mainParams_N.setObject(newsParam);
		Session.prepareParams(mainParams_N);

		newsManager.ezGetNews(mainParams_N);
		
	}*/
	/*********VALUE_MAP********/
	
	
	ReturnObjFromRetrieve newsValMapRetObj = null;
	
	ezc.ezparam.EzcParams mainParams_NVM = new ezc.ezparam.EzcParams(false);
	EziMiscParams miscParams_NVM = new EziMiscParams();
	
	miscParams_NVM.setIdenKey("VALUE_MAP"); // Mandatory 
	
	miscParams_NVM.setExt3("NEWSVALMAP"); // NEWSVALMAP is the map_type in the table and it is optional should pass the blank parameter
	//miscParams_NVM.setExt3("");
	
	mainParams_NVM.setLocalStore("Y");
	mainParams_NVM.setObject(miscParams_NVM);
	Session.prepareParams(mainParams_NVM);	
	try{		
		newsValMapRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams_NVM);
		//out.println(newsValMapRetObj.toEzcString());
	}
	catch(Exception e){out.println("Exception in Getting Data"+e);}
	
	
	/*********VALUE_MAP********/	

	//String fileName="";
	String tempPath="";
	String serverPath="";
		
		
%>