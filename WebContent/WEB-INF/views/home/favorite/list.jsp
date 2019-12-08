<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../common/header.jsp"%>
 <link rel="stylesheet" href="../resources/home/css/shop_manager.css" type="text/css" />
 <link rel="stylesheet" href="../resources/home/css/shop_list.css" type="text/css" />
<!-- 我的个人中心 -->
	<div class="shop_member_bd clearfix">
		<%@include file="../common/user_menu.jsp"%>
		
		<!-- 右边购物列表 -->
		<div class="shop_member_bd_right clearfix">
			
			<div class="shop_meber_bd_good_lists clearfix" >
				<div class="title"><h3>我的收藏列表</h3></div>
				<div class="clear"></div>
				<div class="shop_bd_list_content clearfix">
				<ul>
					<c:forEach items="${favoriteList }" var="product">
					<li>
						<dl>
							<dt><a href="../product/detail?id=${product.productId }"><img src="${product.imageUrl }" /></a></dt>
							<dd class="title"><a href="../product/detail?id=${product.productId }">${product.name }</a></dd>
							<dd class="content">
								<span class="goods_jiage">￥<strong>${product.price }</strong></span>
								<span class="goods_chengjiao"><a href="javascript:void(0)" data-id="${product.id }" class="del-btn">删除</a></span>
							</dd>
						</dl>
					</li>
					</c:forEach>
				</ul>
			</div>
			<div class="pagination"> 
				<ul>
					<li><span><a href="list?page=${page -1}">上一页</a></span></li>
					<li><span class="currentpage">${page}</span></li>
					<li><span><a href="list?page=${page +1}">下一页</a></span></li>
				</ul> 
			</div>
			</div>
		</div>
		
		</div>
		<!-- 右边购物列表 End -->

	</div>
	<!-- Footer - wll - 2013/3/24 -->
	<div class="clear"></div>
	<%@include file="../common/footer.jsp"%>
</body>
<script>
	$(document).ready(function(){
		$(".del-btn").click(function(){
			var $this = $(this);
			if(confirm("确定删除?")){
				$.ajax({
					url:'delete',
					type:'POST',
					data:{favoriteId:$this.attr('data-id')},
					dataType:'json',
					async:false,
					success:function(data){
						if(data.type == 'success'){
							window.location.reload();
						}else{
							alert(data.msg);
						}
					}
				});
			}
		});
	});
	
</script>
</html>