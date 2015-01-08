<script type="text/javascript" src="${base}/js/jquery.cookie.js"></script>
<script type="text/javascript">
$(function() {
	$navMenu = $('.menu_${menuType}');
	$navMenu.addClass('active_menu');
	var isNormalAdmin = $.cookie("pjwsw_isnormaladmin");
	if(isNormalAdmin=='1'){
		$('#navibtnNormal').hide();
		$('#navibtnAdmin').show();
		$('#aSetManage').html('返回');
	}
});
</script> 
	<!-- 管理下拉菜单开始-->
	<!-- 在top.ftl文件中根据当前登录用户的ID判断是否是管理员
		<div id="settingMenu" class="settingDropdownMenu">
		<ul>  -->
		<!-- 该方式用于判断当前用户是否是一般用户,用于控制"管理"按钮的显示 -->
			<!--<@shiro.hasAnyPermission name="menu:task,menu:colleague,admin:searchTask,menu:track,menu:news">
				<li><a href="${base}/admin/task/add.jhtml?flag=assign" class="nav_menu menu_task">新建任务</a></li>
			</@shiro.hasAnyPermission> 
		</ul>
	</div>-->
	<!-- 管理下拉菜单结束-->  
	<!-- 一般员工默认菜单	开始 -->
	<@shiro.hasAnyPermission name="menu:task,menu:colleague,admin:searchTask,menu:track,menu:news"></@shiro.hasAnyPermission> 		
		<div id="navibtnNormal" class="navibtn">
           <div class="navigroup">   
           		<@shiro.hasAnyPermission name="menu:task">       
                   <div class="navi_history"><span class="title-no-click">任务管理</span></div>
				   <div class="navi_sort">
				      <ul>				         
				          <li><a href="${base}/admin/task/add.jhtml?flag=assign" class="nav_menu menu_task">新建任务</a></li>
				          <li><a href="${base}/admin/task/todo.jhtml" class="nav_menu menu_task">待处理任务</a></li>
				          <li><a href="${base}/admin/task/receiveList.jhtml" class="nav_menu menu_task">受派的任务</a></li>
				          <li><a href="${base}/admin/task/assignTreeList.jhtml" class="nav_menu menu_task">指派的任务</a></li>
				          <li><a href="${base}/admin/task/follow.jhtml" class="nav_menu menu_task">关注的任务</a></li>
				          <li><a href="${base}/admin/task/attendTreeList.jhtml" class="nav_menu menu_task">参与的任务</a></li>
				          <li><a href="${base}/admin/task/archive.jhtml" class="nav_menu menu_task">结束的任务</a></li>
				          <li><a href="${base}/admin/task/all.jhtml" class="nav_menu menu_task">全部的任务</a></li>				                   
				      </ul>
				   </div> 	
				  </@shiro.hasAnyPermission>
				   <@shiro.hasAnyPermission name="menu:colleague,admin:searchTask">
				   <div class="navi_history"><span>同事任务查看</span></div>
				   <div class="navi_sort">
				      <ul>
				          <@shiro.hasPermission name="admin:searchTask">
				          <li><a href="${base}/admin/task/searchTreeList.jhtml" class="nav_menu menu_task">同事任务查看</a></li>
				          </@shiro.hasPermission>	
				          <li><a href="${base}/admin/task/export.jhtml" class="nav_menu menu_task">任务导出</a></li>
				      </ul>
				   </div> 
				    </@shiro.hasAnyPermission>
					 <div class="navi_bumen"><span>企业通讯录</span></div>
                   <div class="navi_sort">
                        <ul>
                        	<li><a href="${base}/admin/department/list.jhtml?p=1" class="nav_menu menu_department">组织架构</a></li>
                        	<li><a href="${base}/admin/admin/list.jhtml?p=1" class="nav_menu menu_user">企业通讯录</a></li>  
                            <li><a href="${base}/admin/contact/list.jhtml" class="nav_menu menu_track">常用联系人</a></li>                                                  
                            <li><a href="${base}/admin/channel/listnormal.jhtml" class="nav_menu menu_user">群组</a></li>                                
                        </ul>
                   </div> 			
                   <@shiro.hasPermission name="menu:track">
                   <div class="navi_bumen"><span>员工轨迹</span></div>
				   <div class="navi_sort">
				      <ul>
				          <li><a href="${base}/admin/userTrack/search.jhtml" class="nav_menu menu_task">人员轨迹</a></li>
				          <li><a href="${base}/admin/userTrack/export.jhtml" class="nav_menu menu_task">员工轨迹导出</a></li>
				      </ul>
				   </div> 
				   </@shiro.hasPermission>
                   <@shiro.hasPermission name="menu:news">
                   <@shiro.hasAnyPermission name="admin:new,admin:new:publish">
                   <div class="navi_news"><a href="${base}/admin/new/list.jhtml">资讯编辑</a></div>
                   </@shiro.hasAnyPermission>
                   </@shiro.hasPermission>
                   <div class="navi_help"><a href="#" target="_blank" class="nav_menu menu_track">帮助文档</a></div>
  				   <div class="navi_quanxian"><a href="${base}/admin/user/change.jhtml" class="nav_menu menu_track">修改密码</a></div>                       
           </div>
     </div>
	
	<!-- 一般员工默认菜单	结束 -->
	<!-- 管理员默认菜单	开始 --> 
	<@shiro.hasAnyPermission name="menu:organization,admin:privilege,admin:auth,menu:setting,admin:trackstatus,admin:superadmin">                 	
     <div class="navibtn"  id="navibtnAdmin">
           <div class="navigroup">        
			       <@shiro.hasPermission name="menu:organization">
				   <div class="navi_bumen"><span>组织管理</span></div>
                   <div class="navi_sort">
                        <ul>
                        	<li>
	                            <a href="${base}/admin/department/list.jhtml" class="nav_menu menu_department">
	                            	<@shiro.hasPermission name="admin:department">组织架构</@shiro.hasPermission>   
                                	<@shiro.lacksPermission name="admin:department">组织架构</@shiro.lacksPermission>                                                                                                                   
	                           </a>
                           </li>
                        	 <li>
                                 <a href="${base}/admin/admin/list.jhtml" class="nav_menu menu_user">
	                                 <@shiro.hasPermission name="admin:user">企业通讯录</@shiro.hasPermission>   
	                                 <@shiro.lacksPermission name="admin:user">企业通讯录</@shiro.lacksPermission>
                                 </a>
                            </li>     
                            <@shiro.lacksPermission name="admin:contact">                                                   
                            <li><a href="${base}/admin/channel/list.jhtml" class="nav_menu menu_user">系统群组</a></li>       
                            </@shiro.lacksPermission>                                                
                            <@shiro.hasPermission name="admin:privilege">
                            <li><a href="${base}/admin/privilege/tracks.jhtml" class="nav_menu menu_user">授权设置</a></li>
                            </@shiro.hasPermission>
                            <@shiro.hasPermission name="admin:auth">
                            <li><a href="${base}/admin/role/list.jhtml" class="nav_menu menu_role">权限设置 </a></li>
                            </@shiro.hasPermission>                            
                        </ul>
                   </div> 
                   </@shiro.hasPermission>
                   
                   <@shiro.lacksPermission name="menu:organization">
			       <@shiro.lacksPermission name="admin:superadmin">
				   <div class="navi_bumen">企业通讯录</div>
                   <div class="navi_sort">
                        <ul>
                        	<li>
	                            <a href="${base}/admin/department/list.jhtml" class="nav_menu menu_department">
	                               		组织架构                                                                                                           
	                           </a>
                           </li>
                        	 <li>
                                 <a href="${base}/admin/admin/list.jhtml" class="nav_menu menu_user">
	                                	 企业通讯录 
                                 </a>
                            </li>  
                            <@shiro.hasPermission name="admin:contact">     
                            <li><a href="${base}/admin/contact/list.jhtml" class="nav_menu menu_track">常用联系人</a></li>   
                            </@shiro.hasPermission> 
                            <li><a href="${base}/admin/channel/list.jhtml" class="nav_menu menu_user">系统群组</a></li>   
                        </ul>
                   </div> 
                   </@shiro.lacksPermission>
                   </@shiro.lacksPermission>
                   
			       <@shiro.hasAnyPermission name="admin:import_export,admin:setting,admin:trackstatus,admin:privilege">
                   <div class="navi_chat"><span>公司设置</span></div>    
                   <div class="navi_sort">
                        <ul>
                        	<@shiro.hasPermission name="admin:setting">
                            <li><a href="${base}/admin/setting/edit.jhtml"><span>公司信息</span></a></li>
                            </@shiro.hasPermission> 
                            <!-- <@shiro.hasPermission name="admin:import_export">
                            <li><a href="${base}/admin/import_export/goimport.jhtml"><span>数据导入导出</span></a></li>
                            </@shiro.hasPermission>
                            <@shiro.hasPermission name="admin:setting">
                            <li><a href="${base}/admin/setting/edit.jhtml"><span>公司设置</span></a></li>
                            </@shiro.hasPermission>   
                            <@shiro.hasPermission name="admin:privilege">
                            <li><a href="${base}/admin/privilege/tracks.jhtml"><span>授权设置</span></a></li>
                            </@shiro.hasPermission>                                                      
                             -->      
                            <@shiro.hasPermission name="admin:trackstatus">
                            <li><a href="${base}/admin/trackstatus/list.jhtml"><span>签到状态管理</span></a></li>
                            </@shiro.hasPermission>                
                        </ul>
                   </div>                   
                   </@shiro.hasAnyPermission>
                   
                   <@shiro.hasPermission name="menu:news">
                   <@shiro.hasAnyPermission name="admin:new,admin:new:publish">
                   <div class="navi_news"><a href="${base}/admin/new/list.jhtml">资讯发布</a></div>
                   </@shiro.hasAnyPermission>
                   </@shiro.hasPermission>                   
                   
                   <@shiro.hasPermission name="admin:favorite">
                   <div class="navi_favorite" style="display:none;"><a href="${base}/admin/favorite/attach.jhtml">收藏</a></div>
                    </@shiro.hasPermission>	
                            
                   <@shiro.hasPermission name="admin:remind">
                   <div class="navi_news" style="display:none;"><a href="${base}/admin/remind/list.jhtml">提醒管理</a></div>
                   </@shiro.hasPermission>
                   
 				   <!--<div class="navi_kaoqing"><a href="${base}/admin/userTrack/search.jhtml" class="nav_menu menu_track">人员轨迹</a></div>--> 

				  <!-- <@shiro.hasAnyPermission name="admin:import_export,admin:setting,admin:trackstatus,admin:privilege">
                   <div class="navi_settings"><a href="#">系统管理</a></div>    
                   <div class="navi_sort">
                        <ul>
                        	<@shiro.hasPermission name="admin:setting">
                            <li><a href="${base}/admin/setting/edit.jhtml"><span>管理日志</span></a></li>
                            </@shiro.hasPermission> 
                            <@shiro.hasPermission name="admin:setting">
                            <li><a href="${base}/admin/import_export/goimport.jhtml"><span>云存储空间</span></a></li>
                            </@shiro.hasPermission>
                            <@shiro.hasPermission name="admin:setting">
                            <li><a href="${base}/admin/setting/edit.jhtml"><span>云到期时间</span></a></li>
                            </@shiro.hasPermission>   
                            <@shiro.hasPermission name="admin:setting">
                            <li><a href="${base}/admin/privilege/tracks.jhtml"><span>云相关信息</span></a></li>
                            </@shiro.hasPermission>                                                      
                            <@shiro.hasPermission name="admin:setting">
                            <li><a href="${base}/admin/trackstatus/list.jhtml"><span>帐号使用数</span></a></li>
                            </@shiro.hasPermission>
                            <@shiro.hasPermission name="admin:setting">
                            <li><a href="${base}/admin/privilege/tracks.jhtml"><span>信息删除</span></a></li>
                            </@shiro.hasPermission>                     
                        </ul>
                   </div>                   
                   </@shiro.hasAnyPermission>-->
                   <@shiro.hasPermission name="admin:superadmin">
                   	<div class="navi_quanxian"><a href="${base}/admin/superadmin/change.jhtml" class="nav_menu menu_track">重置管理员密码</a></div>  
                   </@shiro.hasPermission> 
                   <@shiro.hasAnyPermission name="superadmin:xx,admin:setting">
                   <div class="navi_quanxian"><a href="${base}/admin/user/change.jhtml" class="nav_menu menu_track">修改密码</a></div>
                   </@shiro.hasAnyPermission> 
                   <div class="navi_help"><a href="#" target="_blank" class="nav_menu menu_track">帮助文档</a></div>                  
                  <!--<div class="navi_exit"><a href="${base}/admin/logout.jsp">退出系统</a></div>--> 				   
           </div>
     </div>
    </@shiro.hasAnyPermission>
   <!-- 管理员默认菜单	结束 --> 