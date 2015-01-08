<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>公司信息</title>
<script type="text/javascript" src="${base}/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${base}/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/js/common.js"></script>
<script type="text/javascript" src="${base}/js/message.js"></script>

<script type="text/javascript">
$(function() {
	var $inputForm = $("#inputForm");
	
	$inputForm.validate({
	debug:true,
		rules: {
		    name : {
		       required: true,
		       maxlength: 8,//只能填写8个字符，太多登录界面就不能显示
		       pattern: /^[0-9a-z_A-Z\s\u4e00-\u9fa5]+$/
		    },
		    start: {
		       required: true,
		       pattern: /^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$/
		    },
		    end: {
		       required: true,
		       pattern: /^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$/
		    },
		    servicephone: {
		       pattern: /^((\d{3,4}-)?\d{7,8}|1[358][0-9]{9})(,((\d{3,4}-)?\d{7,8}|1[358][0-9]{9}))*$/
		    },
		    pijinphone: {
		       pattern: /^((\d{3,4}-)?\d{7,8}|1[358][0-9]{9})(,((\d{3,4}-)?\d{7,8}|1[358][0-9]{9}))*$/
		    },
		    //传真
		    fax: {
		       pattern: /^([+]{0,1}(\d){1,4}[ ]{0,1}([-]{0,1}((\d)|[ ]){1,12}))(,([+]{0,1}(\d){1,4}[ ]{0,1}([-]{0,1}((\d)|[ ]){1,12})))*$/
		    },
		    //办公电话
		    phone: {
		       pattern: /^([+]{0,1}(\d){1,4}[ ]{0,1}([-]{0,1}((\d)|[ ]){1,12}))(,([+]{0,1}(\d){1,4}[ ]{0,1}([-]{0,1}((\d)|[ ]){1,12})))*$/
		    },
		    //邮箱地址
		    email: {
		    	//required: true,
		       	pattern: /^[\w-]+(\.[\w-]+)*(@[\w-]+(\.[\w-]+)+)*$/
		    },
		    //SMTP服务器
		    smtp: {
		       //required: true,
		       pattern: /^smtp\.[\w-]+(\.[\w-]+)+$/
		    }		    		    
		},
		
		messages: {
			name: {
				pattern: "公司名称只能填写字母、数字、中文和空格"
			},
			start: {
				pattern: "请填写正确上班时间，如09:00"
			},	
			end: {
				pattern: "请填写正确的下班时间,如17:30"
			},
			servicename: {
			   pattern: "姓名只能填写字母、数字、中文和空格"
			},
			servicephone: {
			   pattern: "请填写正确的电话，多个电话用逗号分隔"
			},
			pijinphone: {
			   pattern: "请填写正确的电话，多个电话用逗号分隔"
			},
		    //传真
		    fax: {
		       pattern: "请填写正确的传真号码"
		    },
		    //办公电话
		    phone: {
		       pattern: "请填写正确的办公电话号码"
		    },
		    //邮箱地址
		    email: {
		       pattern: "请填写正确的邮箱地址"
		    },
		    //SMTP服务器
		    smtp: {
		       pattern: "请填写正确的smtp服务器地址"
		    }			
		}
	});
	
	$('#addAddressBtn').on('click', function() {
	     var address = '';
	     $('.address-list').each(function() {
	        address += $(this).text() + '|';
	     });	
	     var positionName = $('#positionName').val();	     
	     if (!positionName || /^\s*$/.test(positionName))
	     {
	          alert('请输入办公地点');
	          return;
	     } else {
	         if (/^[<>~\|]+$/.test(positionName)) {
	            alert('办公地点不能包含特殊字符,如<>~|');
	         	return;
	         }
	         address += positionName;
	     }	
	     $('#address').val(address);
	     $('#addressTable').append('<tr> <td class="address-list">'+positionName+'</td><td><a href="javascript:void(0);"  class="delBtn"><img src="${base}/images/menu/cross.png"width="16" height="16" /></a></td></tr>');
	     $('#positionName').val('');	
	});
	
	
	function setAddress() {
	     var address = '';
	     $('.address-list').each(function() {
	        address += $(this).text() + '|';
	     });
	     $('#address').val(address);	
	}
	
	$(document).on('click', '.delBtn', function() {
	    $(this).closest('tr').remove();
	    setAddress();
	});
	
	

	$('#saveBtn').on('click', function() {
	   
	    if (!$inputForm.valid())
	    {
	        return;
	    }
	    $.ajax({
			url: '${base}/admin/setting/update.jhtml',
			type: "POST",
			cache: false,
			data: $inputForm.serialize(),
			success: function(message) {
			    if (message.content)
				   alert(message.content);	
				location.href = 'edit.jhtml';
			}
		});	  
		var start = $inputForm.find("input[name='start']").val();
		var end = $inputForm.find("input[name='end']").val();
		var startArray = start.split(':');
		var endArray = end.split(':');
		if (parseInt(startArray[0]) > parseInt(endArray[0]) || parseInt(startArray[1]) > parseInt(endArray[1])) {
		     alert('上班时间不能晚于下班时间');
		     return;
		}
	
		$inputForm[0].submit();
	});
	
	$('#cancelBtn').on('click', function() {
	    $inputForm[0].reset();
	});	
	$('input[type=file]').on('change',function(e){
		var tar=$(e.target),
			files = tar[0].files,
			fext = 'png|jpg|gif|jpeg|';
		if(files.length>0){
			var filename =files[0].name,
				fileext = filename.substr(filename.lastIndexOf('.')+1).toLowerCase();
			if(fext.indexOf(fileext+'|')==-1){//没有在指定的文件类型之内
				alert('请选择'+fext+'等图片格式文件!');
				tar.val('');
				e.stopPropagation();
				e.preventDefault();
				return false;
			}
		}
		return true;
	});
	[#if flag?? && flag==1]
	alert('操作成功');
	[/#if]
});
</script>
<link href="${base}/images/css/main.css" rel="stylesheet" type="text/css" />
<style>
/**必填项的提示红色***/
.tooltipRequest{
	color:rgba(255,0,0,1);
}
.inputformstyle ~ label{
	color:rgba(255,0,0,1);
}
</style>
</head>

<body>
[#include "/admin/include/top.ftl"]

<div class="blue_line"></div>
<div class="content">
[#include "/admin/include/left.ftl"]
     <div class="rightarea">
     <form id="inputForm" action="${base}/admin/setting/update.jhtml" method="post" enctype="multipart/form-data"> 
     [#if setting??]
     <input type="hidden" name="id" value="${setting.id}">
     [/#if]
     <input type="hidden" id="address" name="address"[#if setting??] value="${setting.address}"[/#if]>
           <div class="con">
                <div class="tooltitle">公司信息</div>
                <!--table start-->
                <div class="inputarea">
                     <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tablelinestyle">                       
                        <tr>
                          <td width="8%" class="titleinput">公司名称:</td>
                          <td width="23%" class="listinput">
                          	<input name="name" id="name" [#if setting??] value="${setting.name!''}"[/#if] type="text" maxLength=100 class="inputformstyle"/>
                          	<span class="tooltipRequest">*</span>
                          </td>
                        </tr>
                         <tr>
                          <td width="8%" class="titleinput">logo:</td>
                          <td width="23%" class="listinput">
                             <input name="file" type="file" class="inputformstyle"/>
                          </td>
                        </tr>
                        <tr>
                          <td width="8%" class="titleinput">公司电话:</td>
                          <td width="23%" class="listinput"><input name="phone" id="phone" [#if setting??] value="${setting.phone!''}"[/#if] type="text" maxLength=100 class="inputformstyle"/></td>
                        </tr>
                        <tr>
                          <td width="8%" class="titleinput">公司传真:</td>
                          <td width="23%" class="listinput"><input name="fax" id="fax" [#if setting??] value="${setting.fax!''}"[/#if] type="text" class="inputformstyle"/></td>
                        </tr>
                        <tr>
                          <td class="titleinput">办公地点:</td>
                          <td class="listinput">
                              <table width="40%" border="0" cellspacing="0" cellpadding="0" id="addressTable">
                                  <!--<tr>
                                    <td>&nbsp;</td>
                                  </tr>-->
                                  [#if setting??]
                                  [#list setting.addressList as address]
                                  <tr class="address-row">
                                  <td class="address-list">${address}</td>
                                  <td>
                                      <a href="javascript:void(0);"  class="delBtn"><img src="${base}/images/menu/cross.png" width="16" height="16" /></a>
                                   </td>
                                  [/#list]
                                  </tr>
                                  [/#if]
                              </table>
                          </td>
                        </tr>
                        <tr>
                          <td class="titleinput">新增办公地点:</td>
                          <td class="listinput">
                          	<input name="positionName" id="positionName" type="text" class="inputformstyle"/>
                          	<input name="addPositionBtn" id="addAddressBtn" type="button" value="新增" id="新增" class="btn_normal2"/>                    
                          </td>
                        </tr>          
                        <tr>
                          <td width="8%" class="titleinput">上班时间:</td>
                          <td width="23%" class="listinput"><input name="start" [#if setting??] value="${setting.start!''}"[/#if] type="text" maxLength=5 class="inputformstyle"/></td>
                        </tr> 
                        <tr>
                          <td width="8%" class="titleinput">下班时间:</td>
                          <td width="23%" class="listinput"><input name="end" [#if setting??] value="${setting.end!''}"[/#if] type="text" maxLength=5 class="inputformstyle"/></td>
                        </tr>
                        <!--<tr>
                          <td width="8%" class="titleinput">员工状态:</td>
                          <td width="23%" class="listinput"><input name="end" [#if setting??] value="${setting.end!''}"[/#if] type="text" maxLength=5 class="inputformstyle"/></td>
                        </tr>-->
                        <tr>
                          <td width="8%" class="titleinput">公司管理员姓名:</td>
                          <td width="23%" class="listinput"><input name="servicename" [#if setting??] value="${setting.servicename!''}"[/#if] type="text" maxLength=50 class="inputformstyle"/></td>
                        </tr>                        
                        <tr>
                          <td width="8%" class="titleinput">公司管理员电话:</td>
                          <td width="23%" class="listinput"><input name="servicephone" [#if setting??] value="${setting.servicephone!''}"[/#if] type="text" maxLength=50 class="inputformstyle"/></td>
                        </tr>
                         <tr>
                          <td width="8%" class="titleinput">浦今管理员电话:</td>
                          <td width="23%" class="listinput"><input name="pijinphone" [#if setting??] value="${setting.pijinphone!''}"[/#if] type="text" maxLength=50 class="inputformstyle"/></td>
                        </tr>     
                         <tr style="display:none;">
                          <td width="8%" class="titleinput">smtp服务器:</td>
                          <td width="23%" class="listinput">
                          	<input name="smtp" [#if setting??] value="${setting.smtp!''}"[/#if] type="text" class="inputformstyle"/>
                          	<span class="tooltipRequest">*</span>
                          </td>
                        </tr>                        
                        <tr style="display:none;">
                          <td width="8%" class="titleinput">邮箱帐号:</td>
                          <td width="23%" class="listinput">
                          	<input name=" username" [#if setting??] value="${setting. username!''}"[/#if] type="text" class="inputformstyle"/>
                          	<span class="tooltipRequest">*</span>
                          </td>
                        </tr>
                         <tr style="display:none;">
                          <td width="8%" class="titleinput">邮箱密码:</td>
                          <td width="23%" class="listinput">
                          	<input name="password" [#if setting??] value="${setting.password!''}"[/#if] type="password" class="inputformstyle"/>
                          	<span class="tooltipRequest">*</span>
                          </td>
                        </tr>     
                      </table>
                </div>
                <!--table end-->
                <div class="btnarea">
                     <div class="btn_normal"><a href="javascript:void(0);" id="saveBtn">保存</a></div>
                     <div class="btn_normal"><a href="javascript:void(0);" id="cancelBtn">取消</a></div>
                </div>
           </div>
      </form>
     </div>
</div>
</body>
</html>
