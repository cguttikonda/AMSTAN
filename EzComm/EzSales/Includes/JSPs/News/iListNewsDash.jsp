<jsp:useBean id="global" class="ezc.ezbasicutil.EzGlobal" scope="session" />
<%@ page import="ezc.ezparam.*"%>
<%

	
	int myNewsRetCnt=0;
	String userType 	= (String)session.getValue("UserType");
	String userIdS		= Session.getUserId();
	String userId 		= (String) session.getValue("AgentCode");
	String readFlag		= request.getParameter("readFlag");
	String diclaiStamp 	= (String)session.getValue("DISCLAIMER");;
	String newsType_F	= request.getParameter("newsFilter");
	if(newsType_F==null || "null".equals(newsType_F))newsType_F="";
	String filterQry 	= "";
	//String redirectPage	= "ezListNewsDash.jsp";
	ezc.record.util.EzOrderedDictionary userAuth_R = Session.getUserAuth();
	java.util.HashMap selSoldToHash	= null;	
	java.util.HashMap selShipToHash	= null;	
	ezc.ezparam.EzcParams mainParams_N=null;
	ezc.eznews.params.EziNewsParams newsParam = null;
	ezc.eznews.client.EzNewsManager newsManager = null;
	EziMiscParams timeParams = null;
	ezc.ezparam.ReturnObjFromRetrieve timeStampRet_N=null;
	
	/*mainParams_N=new ezc.ezparam.EzcParams(true);
	timeParams = new EziMiscParams();

	timeParams.setIdenKey("MISC_SELECT");
	String query_A="SELECT ENR_ID,ENR_SYSKEY,ENR_USER,ENR_VIEWED,ENR_VIEWED_DATE,ENR_CONFIRMATION,ENR_CONFIRMED_DATE FROM EZC_NEWS_READ_TIMESTAMP WHERE  ENR_USER='"+userId+"'";
	timeParams.setQuery(query_A);

	mainParams_N.setLocalStore("Y");
	mainParams_N.setObject(timeParams);
	Session.prepareParams(mainParams_N);
	String tempId="";

	try
	{
		timeStampRet_N = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams_N);
		for(int s=0;s<timeStampRet_N.getRowCount();s++)
		{
			String news_Id   = timeStampRet_N.getFieldValueString(s,"ENR_ID");
			
			if(s==0)
				tempId=	news_Id;
			else
				tempId = tempId+"','"+news_Id;
		}	
	}
	catch(Exception e)
	{
		out.println("Exception in Getting Data"+e);
	}*/
	String refQry_L="";
	/*if(tempId!="" && !"".equals(tempId))
	{
		if(("null".equals(readFlag) || readFlag==null) || "N".equals(readFlag) || "".equals(readFlag))
			refQry_L=" AND EZN_ID NOT IN ('"+tempId+"')";
		else if("Y".equals(readFlag))
			refQry_L=" AND EZN_ID IN ('"+tempId+"')";
	}		
	
	if(newsType_F!=null && !"".equals(newsType_F))
		filterQry = "AND EZN_CATEGORY='"+newsType_F+"' ";*/
	
	String refQry	= "";
	//String refQry1	= "";
	//String tempNewsId="";
	String authChk = "";
		/*ezc.ezparam.ReturnObjFromRetrieve assiNewsRet = null;
		mainParams_N=new ezc.ezparam.EzcParams(true);
		newsManager = new ezc.eznews.client.EzNewsManager();
		newsParam = new ezc.eznews.params.EziNewsParams();
		newsParam.setQType("SELUSERS");
		newsParam.setNewsRef1("ENA_SOLDTO IN ('"+userId+"','A') ");
		mainParams_N.setObject(newsParam);
		Session.prepareParams(mainParams_N);
		assiNewsRet=(ezc.ezparam.ReturnObjFromRetrieve)newsManager.ezGetNews(mainParams_N);
		if(assiNewsRet!=null && assiNewsRet.getRowCount()>0)
		{
			for(int s=0;s<assiNewsRet.getRowCount();s++)
			{
				String assNewsId	= assiNewsRet.getFieldValueString(s,"ENA_ID");
				if(s==0)
					tempNewsId = assNewsId;
				else
					tempNewsId= tempNewsId+"','"+assNewsId;
			}	
		}
		if(tempNewsId!=null && !"".equals(tempNewsId))refQry1="EZN_ID IN ('"+tempNewsId+"') AND";*/
		
		/********* Authorization Check Start **********/
		if("OM".equals(newsType_F))
			newsType_F ="";
		if("".equals(authChk)) authChk = "EZN_CATEGORY IN (";
		if(!"".equals(newsType_F))
			authChk	= authChk +"'"+newsType_F+"'";
		else if("".equals(newsType_F)||"null".equals(newsType_F))
		{
			if(userAuth_R.containsKey("VIEW_PL_NEWS")) authChk = authChk + " 'PL', "; 
			if(userAuth_R.containsKey("VIEW_PSPEC_NEWS")) authChk = authChk  +" 'PRODSPEC', "; 
			if(userAuth_R.containsKey("VIEW_NPROD_NEWS")) authChk = authChk  +" 'NP', "; 
			if(userAuth_R.containsKey("VIEW_DC_NEWS")) authChk = authChk  +" 'DP', "; 
			if(userAuth_R.containsKey("VIEW_PS_NEWS")) authChk = authChk  +" 'PS', "; 
			if(userAuth_R.containsKey("VIEW_PCHNG_NEWS")) authChk = authChk  +" 'PCA', "; 
			if(userAuth_R.containsKey("VIEW_PROMO_NEWS")) authChk = authChk  +" 'PA', "; 
			if(userAuth_R.containsKey("VIEW_GA_NEWS")) authChk = authChk  +" 'GA', "; 
			if(userAuth_R.containsKey("VIEW_SLOB_NEWS")) authChk = authChk  +" 'SLOB' "; 
			authChk = authChk.trim();
			if((authChk.trim()).endsWith(",")) 
			{
				authChk = authChk.substring(0,authChk.lastIndexOf(','));
			}
		}
		if(!"".equals(authChk) ) authChk =authChk + ")  AND  ";

		/********* Authorization Check End **********/
		//refQry="EZN_AUTH IN ('E','A') AND"+refQry1+" GETDATE() BETWEEN EZN_START_DATE AND EZN_END_DATE AND " +filterQry+" EZN_EXT1='"+readFlag+"'  ORDER BY CAST (EZN_ID AS INT) DESC";
		//refQry="EZN_AUTH IN ('E','A') AND GETDATE() BETWEEN EZN_START_DATE AND EZN_END_DATE AND " +filterQry+" EZN_EXT1='"+readFlag+"'  ORDER BY CAST (EZN_ID AS INT) DESC";	
		
	if("3".equals(userType))
	{
		/*if(readFlag!=null && !"A".equals(readFlag))
			refQry="EZN_AUTH IN ('E','A') AND "+authChk+" GETDATE() BETWEEN EZN_START_DATE AND EZN_END_DATE  AND EZN_ID IN (SELECT ENA_ID FROM EZC_NEWS_ASSIGNIES WHERE ENA_SOLDTO IN ('"+(String)Session.getUserId()+"','A')) ORDER BY CAST (EZN_ID AS INT) DESC";
		else*/
		if("Y".equals((String)session.getValue("REPAGENCY")))
			refQry="EZN_ID IN (SELECT ENA_ID FROM EZC_NEWS_ASSIGNIES WHERE ENA_SOLDTO IN ('"+userIdS+"','A')) AND EZN_AUTH IN ('A','RA') AND "+authChk+" GETDATE() BETWEEN EZN_START_DATE AND EZN_END_DATE   ORDER BY CAST (EZN_ID AS INT) DESC";
		else
			refQry="EZN_ID IN (SELECT ENA_ID FROM EZC_NEWS_ASSIGNIES WHERE ENA_SOLDTO IN ('"+userId+"','A')) AND EZN_AUTH IN ('E','A') AND "+authChk+" GETDATE() BETWEEN EZN_START_DATE AND EZN_END_DATE ORDER BY CAST (EZN_ID AS INT) DESC";
	}	
	else if ("2".equals(userType))
	{
		/*if(readFlag!=null && !"A".equals(readFlag))
			refQry="EZN_AUTH IN ('I','A') AND "+authChk+" GETDATE() BETWEEN EZN_START_DATE AND EZN_END_DATE "+refQry_L+" ORDER BY CAST (EZN_ID AS INT) DESC";
		else*/
			refQry="EZN_AUTH IN ('I','A') AND "+authChk+" GETDATE() BETWEEN EZN_START_DATE AND EZN_END_DATE ORDER BY CAST (EZN_ID AS INT) DESC";
	}		
		
	ezc.ezparam.ReturnObjFromRetrieve myNewsRet = null;
	global.setDateFormat("MM/dd/yyyy");
	ReturnObjFromRetrieve GlobObj = null;
	ezc.ezparam.ReturnObjFromRetrieve timeStampRet=null;
	
	HashMap readMap = new HashMap();
	HashMap ackMap = new HashMap();
	HashMap newsCatCnt = new HashMap();
	String catNewsId="";
	if(userType!=null && refQry!=null)
	{
		//if(diclaiStamp==null || !"N".equals(diclaiStamp) && !"Y".equals(readFlag))
		{
			mainParams_N=new ezc.ezparam.EzcParams(true);
			newsManager = new ezc.eznews.client.EzNewsManager();
			newsParam = new ezc.eznews.params.EziNewsParams();

			newsParam.setQType("U");
			newsParam.setNewsSyskey(refQry);

			mainParams_N.setLocalStore("Y");
			mainParams_N.setObject(newsParam);
			Session.prepareParams(mainParams_N);

			myNewsRet=(ezc.ezparam.ReturnObjFromRetrieve)newsManager.ezGetNews(mainParams_N);
			if(myNewsRet!=null )
				myNewsRetCnt = myNewsRet.getRowCount();
			for(int n=0;n<myNewsRetCnt;n++)
			{

				String newsId_A = myNewsRet.getFieldValueString(n,"EZN_ID");
				if(n==0)
					catNewsId = newsId_A;
				else
					catNewsId= catNewsId+"','"+newsId_A;

			}			
		}	
	}
	
	
	String news_Id   = ""; 
	String trackFlag = "";
	String user_A	 = "";
	String trackDate = "";
	String ackFlag   = "";	
	String ackDate   = "";
	ReturnObjFromRetrieve newsCountRet = null;
	
	if(myNewsRetCnt>0)
	{
		mainParams_N=new ezc.ezparam.EzcParams(true);
		timeParams = new EziMiscParams();
	
		timeParams.setIdenKey("MISC_SELECT");
		String query="SELECT ENR_ID,ENR_SYSKEY,ENR_USER,ENR_VIEWED,ENR_VIEWED_DATE,ENR_CONFIRMATION,ENR_CONFIRMED_DATE FROM EZC_NEWS_READ_TIMESTAMP WHERE ENR_ID IN ('"+catNewsId+"') AND ENR_USER='"+userIdS+"'";
		timeParams.setQuery(query);

		mainParams_N.setLocalStore("Y");
		mainParams_N.setObject(timeParams);
		Session.prepareParams(mainParams_N);	

		try
		{
			timeStampRet = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams_N);
			if(timeStampRet!=null && timeStampRet.getRowCount()>0)
			{
				Vector types2= new Vector();
				types2.addElement("date");
				types2.addElement("date");
				

				Vector cols2= new Vector();
				cols2.addElement("ENR_VIEWED_DATE");
				cols2.addElement("ENR_CONFIRMED_DATE");
				
				global.setColTypes(types2);
				global.setColNames(cols2);
				GlobObj = global.getGlobal(timeStampRet);			
			}
			for(int s=0;s<timeStampRet.getRowCount();s++)
			{
				news_Id   = timeStampRet.getFieldValueString(s,"ENR_ID");
				trackFlag = timeStampRet.getFieldValueString(s,"ENR_VIEWED");
				user_A	  = timeStampRet.getFieldValueString(s,"ENR_USER");
				trackDate = GlobObj.getFieldValueString(s,"ENR_VIEWED_DATE");
				ackFlag   = timeStampRet.getFieldValueString(s,"ENR_CONFIRMATION");
				ackDate   = GlobObj.getFieldValueString(s,"ENR_CONFIRMED_DATE");
							
				readMap.put(news_Id,trackDate);
				if("Y".equals(ackFlag))
					ackMap.put(news_Id,ackDate);
			}
			if(readMap!=null)
				session.putValue("TIME_STAMP",readMap);
			if(ackMap!=null)
				session.putValue("ACK_STAMP",ackMap);				
			//out.println(timeStampRet.toEzcString());
			//out.println("readMap::::::::::::::::::::::::::::::"+readMap);
		}
		catch(Exception e)
		{
			out.println("Exception in Getting Data"+e);
		}	
	
	
	}
	//if(myNewsRetCnt>0)
	{
		String authC = "ENA_SOLDTO IN('"+userIdS+"','A','I'))";
		if("3".equals(userType))
		{
			 if("Y".equals((String)session.getValue("REPAGENCY")))
			 	authC	= "ENA_SOLDTO IN('"+userIdS+"','A'))";
			 else
			 	authC	= "ENA_SOLDTO IN('"+userId+"','A'))";
		}
		mainParams_N=new ezc.ezparam.EzcParams(true);
		timeParams = new EziMiscParams();
		ezc.ezcommon.EzLog4j.log("Check:::::","I");
		timeParams.setIdenKey("MISC_SELECT");
		String query="SELECT EZN_CATEGORY, COUNT(*) NEWSCOUNT FROM EZC_NEWS WHERE EZN_CATEGORY IN ( 'PL',  'PRODSPEC',  'NP',  'DP', 'PCA', 'PS',  'PA', 'GA', 'SLOB' ) AND GETDATE() BETWEEN EZN_START_DATE AND EZN_END_DATE AND EZN_ID IN (SELECT ENA_ID FROM EZC_NEWS_ASSIGNIES WHERE "+authC+" AND EZN_ID NOT IN (SELECT ENR_ID FROM EZC_NEWS_READ_TIMESTAMP WHERE ENR_USER='"+userIdS+"') GROUP BY EZN_CATEGORY ";
		timeParams.setQuery(query);

		mainParams_N.setLocalStore("Y");
		mainParams_N.setObject(timeParams);
		Session.prepareParams(mainParams_N);
		try
		{
			newsCountRet = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams_N);
			for(int s=0;s<newsCountRet.getRowCount();s++)
			{
				newsCatCnt.put(newsCountRet.getFieldValueString(s,"EZN_CATEGORY"),newsCountRet.getFieldValueString(s,"NEWSCOUNT"));
			}
			if(newsCatCnt!=null)
				session.putValue("NEWS_CNT",newsCatCnt);
		}
		catch(Exception e){
			
		}
	}
	/*{
		mainParams_N=new ezc.ezparam.EzcParams(true);
		newsManager = new ezc.eznews.client.EzNewsManager();
		newsParam = new ezc.eznews.params.EziNewsParams();
		
		newsParam.setQType("TL");
		newsParam.setNewsId(catNewsId);
		newsParam.setTrackUser("SGEORGE");
		

		mainParams_N.setLocalStore("Y");
		mainParams_N.setObject(newsParam);
		Session.prepareParams(mainParams_N);
				
		timeStampRet=(ezc.ezparam.ReturnObjFromRetrieve)newsManager.ezGetNews(mainParams_N);
		if(timeStampRet!=null && timeStampRet.getRowCount()>0)
		{
			for(int s=0;s<timeStampRet.getRowCount();s++)
			{
				news_Id    = timeStampRet.getFieldValueString(s,"ENR_ID");
				trackFlag = timeStampRet.getFieldValueString(s,"ENR_VIEWED");
				user	 = timeStampRet.getFieldValueString(s,"ENR_USER");
				trackDate = timeStampRet.getFieldValueString(s,"ENR_VIEWED_DATE");
				ackFlag   = timeStampRet.getFieldValueString(s,"ENR_CONFIRMATION");
				ackDate   = timeStampRet.getFieldValueString(s,"ENR_CONFIRMED_DATE");
			
				readMap.put(news_Id,trackFlag);				
			}	
		
		}
		//out.println("timeStampRet:::::::::::::::::::::"+timeStampRet.toEzcString());
		//out.println("readMap:::::::::::::::::::::"+readMap);
	}*/	
		
	//out.println("myNewsRet:::::::::::::::::::"+myNewsRet.toEzcString());
	
	
	/*********VALUE_MAP********/
	
	
	ReturnObjFromRetrieve newsValMapRetObj = null;
	
	ezc.ezparam.EzcParams mainParams_NVM = new ezc.ezparam.EzcParams(false);
	EziMiscParams miscParams_NVM = new EziMiscParams();
	
	miscParams_NVM.setIdenKey("MISC_SELECT"); // Mandatory 
	miscParams_NVM.setQuery("SELECT * FROM EZC_VALUE_MAPPING WHERE MAP_TYPE='NEWSVALMAP'");
	
	//miscParams_NVM.setExt3("NEWSVALMAP"); // NEWSVALMAP is the map_type in the table and it is optional should pass the blank parameter
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
	
%>	