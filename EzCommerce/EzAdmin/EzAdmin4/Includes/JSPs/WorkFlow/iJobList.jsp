<%@ include file="../../Lib/EzWorkFlowBean.jsp"%>
<%
	String[] jobGroups;
	String[] jobsInGroup;
	String jobGroupName = "";
	String jobName = "";
	java.util.Date triggerDate = null;
	String triggerDateString = "";
	ezc.ezparam.ReturnObjFromRetrieve jobListRet = null;
	int jobCount = 0;
	if(Session != null)
	{
		try
		{
			StdSchedulerFactory stdschedulerfactory = new StdSchedulerFactory();
			Scheduler scheduler = stdschedulerfactory.getScheduler();	
			if(request.getParameter("JOBCHK") != null)
			{
				String deleteJob = request.getParameter("JOBCHK");
				scheduler.deleteJob(deleteJob,"DEFAULT");
				response.sendRedirect("ezJobList.jsp");
			}		
			jobGroups = scheduler.getJobGroupNames();
			if(jobGroups.length > 0)
			{
				jobListRet = new ezc.ezparam.ReturnObjFromRetrieve(new String[]{"JOB_GROUP","JOB_NAME","JOB_TRIGGER_AT","TRIGGER_AT"});
				for (int i = 0; i < jobGroups.length; i++) 
				{
					jobGroupName = jobGroups[i];
					jobsInGroup = scheduler.getJobNames(jobGroups[i]);
					Trigger[] jobTriggers;
					for (int j = 0; j < jobsInGroup.length; j++) 
					{
						jobTriggers = scheduler.getTriggersOfJob(jobsInGroup[j], jobGroups[i]);
						triggerDate = jobTriggers[0].getFinalFireTime();
						triggerDateString = triggerDate.getDate()+"/"+(triggerDate.getMonth()+1)+"/"+(triggerDate.getYear()+1900)+" "+triggerDate.getHours()+":"+triggerDate.getMinutes()+":"+triggerDate.getSeconds();
						jobListRet.setFieldValue("JOB_GROUP",jobGroupName);
						jobListRet.setFieldValue("JOB_NAME",jobsInGroup[j]);
						jobListRet.setFieldValue("TRIGGER_AT",triggerDateString);
						jobListRet.setFieldValue("JOB_TRIGGER_AT",triggerDate);
						jobListRet.addRow();
					}
				}
				if(jobListRet != null)
					jobCount = jobListRet.getRowCount();
			}
			jobListRet.sort(new String[]{"JOB_TRIGGER_AT"},true);
		}catch(Exception ex){}	
	}	
%>
