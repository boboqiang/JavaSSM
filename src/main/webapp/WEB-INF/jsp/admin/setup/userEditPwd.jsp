<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  + request.getServerName() + ":" + request.getServerPort()  + path;  
    pageContext.setAttribute("basePath",basePath);
%>
<jsp:include page="../../common/header.jsp"  flush="true" />
<section class="panel panel-default">
			<div class="panel-body">
				<div class="line line-dashed line-lg pull-in"></div>
				<div class="form-group">
					<label class="col-sm-3 control-label">用户名</label>
					<div class="col-sm-9">
						<input type="text" class="form-control"  disabled placeholder="请输入用户名" name="username" id="username" value="${adminUserInfo.username}">
					</div>
				</div>
				<div class="line line-dashed line-lg pull-in"></div>
				<div class="form-group">
					<label class="col-sm-3 control-label">真实姓名</label>
					<div class="col-sm-9">
						<input type="text" class="form-control" disabled placeholder="请输入真实新姓名" name="realname" id="realname" value="${adminUserInfo.realname}">
					</div>
				</div>
				<div class="line line-dashed line-lg pull-in"></div>
				<div class="form-group">
					<label class="col-sm-3 control-label">密码</label>
					<div class="col-sm-6">
						<input type="password" class="form-control" placeholder="请输入密码" name="password" id="password">
					</div>
				</div>
				<div class="line line-dashed line-lg pull-in"></div>
				<div class="form-group">
					<label class="col-sm-3 control-label">确认密码</label>
					<div class="col-sm-9">
						<input type="password" class="form-control" placeholder="请输入确认密码" name="cpassword" id="cpassword">
					</div>
				</div>
			</div>
			<footer class="panel-footer text-right bg-light lter">
				<button type="button" class="btn btn-success btn-s-xs" id="submit">提交</button>
				<button type="button" class="btn btn-danger btn-s-xs" id="closeWin">关闭</button>
			</footer> 
		</section>
		<script>
			//关闭操作
			$('#closeWin').click(function(){
	        		//获取窗口索引
					var index = parent.layer.getFrameIndex(window.name); 
	        	
					//关闭当前窗口
				    parent.layer.close(index);
			});
		
			$('#submit').click(function(){
				//设置按钮状态
				Common.changeBtnDisable("#submit");
				
				//获取提交参数
				var password = $.trim($("#password").val());
				var cpassword	= $.trim($("#cpassword").val());
				
				
				//检查密码
				if(password == ''){
					//提示密码有问题
					layer.msg("请填写用户密码！");
					$("#password").select();
					
					//设置按钮状态
					Common.changeBtnAble("#submit");
					
					return false;	
				}
				
				//检查密码和确认密码是否相同
				if(password != cpassword){
					//提示密码有问题
					layer.msg("两次密码不一致！");
					$("#password").select();
					
					//设置按钮状态
					Common.changeBtnAble("#submit");
					
					return false;
				}
				
				//提交用户修改
				$.ajax({
	              type: 'post',
	              url: '${basePath}/admin/setup/user/post/edit/pwd',
	              contentType:'application/json;charset=UTF-8',
	              dataType: 'json',
	              cache:false,
	              timeout: 60000, 
	              data:JSON.stringify({
	            	  password: password
	              }),
	              success: function (json) {
	            	  if(json.errno == 0 && json.data.ret){
			            	//获取窗口索引
			  				var index = parent.layer.getFrameIndex(window.name); 

			  				//关闭当前窗口
			  				layer.msg("修改成功!");
			  				setTimeout(function(){parent.layer.close(index);}, 2000);
	            	  }else{
	            		  layer.msg(json.errmsg);
	            		  
	  					//设置按钮状态
	  					Common.changeBtnAble("#submit");
	            	  }
	              }
	          });
			});
		</script>
<jsp:include page="../../common/footer.jsp"  flush="true" />