<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../common/header.jsp"%>
 <link rel="stylesheet" href="../resources/home/css/shop_manager.css" type="text/css" />
 <link rel="stylesheet" href="../resources/home/css/shop_form.css" type="text/css" />
<style>
	.pagination{width:100%; margin:10px auto;}
	.pagination ul{float:right}
	.pagination ul li{float:left; margin:0 3px;}
	.pagination ul li span{display: inline-block; padding:5px 5px; border:1px solid #CCCCCC; color:#999999;}
	.pagination ul li span.currentpage{background-color:#FEA900; color:#FFF; font-weight: bold; border-color:#FEA900;}
</style>
<!-- 我的个人中心 -->
	<div class="shop_member_bd clearfix">
		<%@include file="../common/user_menu.jsp"%>
		
		<!-- 右边购物列表 -->
		<div class="shop_member_bd_right clearfix">
			
			<div class="shop_meber_bd_good_lists clearfix" >
				<div class="title"><h3>订单列表</h3></div>
				<table style="font-size:12px;">
					<thead class="tab_title">
						<th style="width:410px;"><span>商品信息</span></th>
						<th style="width:100px;"><span>单价</span></th>
						<th style="width:80px;"><span>数量</span></th>
						<th style="width:100px;"><span>订单总价</span></th>
						<th style="width:115px;"><span>状态与操作</span></th>
					</thead>
					<tbody>
						<c:forEach items="${orderList }" var="order">
						<tr>
							<td colspan="5">
								<table class="good" style="font-size:12px;">
									<thead >
										<tr>
											<th colspan="4">
												<span><strong>订单编号：</strong>${order.sn }</span>
											</th>
											<th style="text-align: center;color:red;"><b>${order.money }</b></th>
											<th style="text-align: center;color:red;">
												<c:if test="${order.status == 0 }">待发货</c:if>
												<c:if test="${order.status == 1 }">
													已发货
													<a href="javascript:void(0)" data-id="${order.id }" class="finish-order-btn">[确认收货]</a>
												</c:if>
												<c:if test="${order.status == 2 }">已完成</c:if>
											</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${order.orderItems }" var="orderItem">
										<tr>
											<td class="dingdan_pic"><img src="${orderItem.imageUrl }" /></td>
											<td class="dingdan_title"><span><a href="../product/detail?id=${orderItem.productId }">${orderItem.name }</a></span></td>
											<td class="dingdan_danjia">￥<strong>${orderItem.price }</strong></td>
											<td class="dingdan_shuliang">${orderItem.num }</td>
											<td class="dingdan_zongjia">￥<strong>${orderItem.money }</strong><br />(免运费)</td>
											<td class="digndan_caozuo">
												<c:if test="${order.status == 2 }"><a href="comment?pid=${orderItem.productId }">评价</a></c:if>
											</td>
										</tr>
										</c:forEach>
										<tr><td colspan="6" class="dingdan_title">订单备注：${order.remark }&nbsp;&nbsp;收货信息：${order.address }</td></tr>
									</tbody>
								</table>
							</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="clear"></div>
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
		$(".finish-order-btn").click(function(){
			var $this = $(this);
			if(confirm("确定收货?")){
				$.ajax({
					url:'finish_order',
					type:'POST',
					data:{id:$this.attr('data-id')},
					dataType:'json',
					async:false,
					success:function(data){
						if(data.type == 'success'){
							alert('收货成功!');
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