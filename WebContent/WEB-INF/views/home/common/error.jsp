<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../common/header.jsp"%>
<style type="text/css">
		.shop_bd_error{width:1000px; height:50px; padding:100px 0; margin:10px auto 0; border:1px solid #ccc;}
		.shop_bd_error p{height:45px; line-height:45px; width:980px; text-align: center; font-size:14px; font-weight: bold; color:#55556F;}
		.shop_bd_error p span{display:inline-block;width:45px; height:45px; line-height:45px; overflow:hidden; text-indent: 99em; vertical-align:top; padding-right:10px; background:url('../resources/home/images/error.jpg') no-repeat left top;}
</style>
<div class="shop_bd_error">
		<p><span>出错啦！</span>${msg}！</p>
</div>
<%@include file="../common/footer.jsp"%>