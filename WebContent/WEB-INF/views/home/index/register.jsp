<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
	<title>用户注册</title>
	<link rel="stylesheet" href="../resources/home/css/base.css" />
	<link rel="stylesheet" href="../resources/home/css/global.css" />
	<link rel="stylesheet" href="../resources/home/css/login-register.css" />
	<script type="text/javascript" src="../resources/home/js/jquery.js" ></script>
</head>
<body>
	<div class="header wrap1000">
		<a href=""><img src="../resources/home/images/logo.png" alt="" /></a>
	</div>
	
	<div class="main">
		<div class="login-form fr">
			<div class="form-hd">
				<h3>用户注册</h3>
			</div>
			<div class="form-bd">
				<form>
					<dl>
						<dt>用户名</dt>
						<dd><input type="text" name="user" class="text" /></dd>
					</dl>
					<dl>
						<dt>密码</dt>
						<dd><input type="password" name="pwd" class="text"/></dd>
					</dl>
					<dl>
						<dt>确认密码</dt>
						<dd><input type="password" name="repwd" class="text"/></dd>
					</dl>
					<dl>
						<dt>邮箱</dt>
						<dd><input type="text" name="email" class="text"/></dd>
					</dl>
					<dl>
						<dt>验证码</dt>
						<dd>
							<input type="text" name="code" class="text" size="10" style="width:58px;"> 
							<img id="register-code" src="../system/get_cpacha?vl=4&w=100&h=30&type=userRegisterCpacha" alt="" align="absmiddle" style="position:relative;top:-2px;"/> <a href="javascript:changeCode()" style="color:#999;">看不清，换一张</a></dd>
					</dl>
					<dl>
						<dt>&nbsp;</dt>
						<dd><input type="button" id="submit-register" value="立即注册" class="submit"/> 
						</dd>
					</dl>
				</form>
				
			</div>
			<div class="form-ft">
			
			</div>		
		</div>
		
		<div class="login-form-left fl">
			<dl class="func clearfix">
				<dt>注册之后您可以</dt>
				<dd class="ico05"><i></i>购买商品支付订单</dd>
				<dd class="ico01"><i></i>查看各类销售商品</dd>
				<dd class="ico03"><i></i>空间好友推送分享</dd>
				<dd class="ico02"><i></i>收藏商品关注商品</dd>
				<dd class="ico06"><i></i>商品资讯服务评价</dd>
				<dd class="ico04"><i></i>安全交易诚信无忧</dd>
			</dl>
			
			<div class="if">
				<h2>如果您是本站用户</h2>
				<p>我已经注册过账号，立即 <a href="login" class="register">登录</a></p>
			</div>
		</div>
	</div>
	
	<div class="footer clear wrap1000">
		<p> <a href="/OnlineShop">首页</a> | <a href="">招聘英才</a> | <a href="">广告合作</a> | <a href="http://programmer.ischoolbar.com">关于猿来入此</a> | <a href="">联系我们</a></p>
		<p>Copyright 2019 梦翔社团 Inc.,All rights reserved.</p>
	</div>
</body>
<script>
	function changeCode(){
		$("#register-code").attr('src','../system/get_cpacha?vl=4&w=100&h=30&type=userRegisterCpacha&t='+new Date().getTime());	
	}
	$("#submit-register").click(function(){
		var name = $("input[name='user']").val();
		var password = $("input[name='pwd']").val();
		var repassword = $("input[name='repwd']").val();
		var email = $("input[name='email']").val();
		var code = $("input[name='code']").val();
		if(name == ''){
			alert('用户名不能为空');
			return;
		}
		if(password == ''){
			alert('密码不能为空');
			return;
		}
		if(password != repassword){
			alert('两次密码不一致');
			return;
		}
		if(email == ''){
			alert('邮箱不能为空');
			return;
		}
		if(code == ''){
			alert('验证码不能为空');
			return;
		}
		$.ajax({
			url:'register',
			type:'POST',
			data:{name:name,password:password,email:email,code:code},
			dataType:'json',
			success:function(data){
				if(data.type == 'success'){
					alert('注册成功!');
					window.location.href = 'login';
				}else{
					alert(data.msg);
				}
			}
		});
	});
</script>
</html>
