<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../common/header.jsp"%>
 <link rel="stylesheet" href="../resources/home/css/shop_goods.css" type="text/css" />
 <link rel="stylesheet" href="../resources/home/css/shop_list.css" type="text/css" />
 <script type="text/javascript" src="../resources/home/js/shop_goods.js" ></script>
<style>
	span.pingjia_type {
	    width: 24px;
	    height: 24px;
	    display: block;
	    margin: 0 auto;
	    background: url(../resources/home/images/credit_smile.png) no-repeat scroll 0 0 transparent;
	    float:left;
	}
	span.pingjia_type_2 {
    	background-position: 0 -30px;
	}
	span.pingjia_type_3 {
	    background-position: 0 -60px;
	}
</style>
<div class="shop_goods_bd clear">

		<!-- 商品展示 -->
		<div class="shop_goods_show">
			<div class="shop_goods_show_left">
				<!-- 京东商品展示 -->
				<link rel="stylesheet" href="../resources/home/css/shop_goodPic.css" type="text/css" />
				<script type="text/javascript" src="../resources/home/js/shop_goodPic_base.js"></script>
				<script type="text/javascript" src="../resources/home/js/lib.js"></script>
				<script type="text/javascript" src="../resources/home/js/163css.js"></script>
				<div id="preview">
					<div class=jqzoom id="spec-n1" onClick="window.open('/')"><IMG height="350" src="${product.imageUrl }" jqimg="${product.imageUrl }" width="350">
						</div>
						<div id="spec-n5">
							<div class=control id="spec-left">
								<img src="../resources/home/images/left.gif" />
							</div>
							<div id="spec-list">
								<ul class="list-h">
									<li><img src="${product.imageUrl }"> </li>
								</ul>
							</div>
							<div class=control id="spec-right">
								<img src="../resources/home/images/right.gif" />
							</div>
							
					    </div>
					</div>

					<SCRIPT type=text/javascript>
						$(function(){			
						   $(".jqzoom").jqueryzoom({
								xzoom:400,
								yzoom:400,
								offset:10,
								position:"right",
								preload:1,
								lens:1
							});
							$("#spec-list").jdMarquee({
								deriction:"left",
								width:350,
								height:56,
								step:2,
								speed:4,
								delay:10,
								control:true,
								_front:"#spec-right",
								_back:"#spec-left"
							});
							$("#spec-list img").bind("mouseover",function(){
								var src=$(this).attr("src");
								$("#spec-n1 img").eq(0).attr({
									src:src.replace("\/n5\/","\/n1\/"),
									jqimg:src.replace("\/n5\/","\/n0\/")
								});
								$(this).css({
									"border":"2px solid #ff6600",
									"padding":"1px"
								});
							}).bind("mouseout",function(){
								$(this).css({
									"border":"1px solid #ccc",
									"padding":"2px"
								});
							});				
						})
						</SCRIPT>
					<!-- 京东商品展示 End -->

			</div>
			<div class="shop_goods_show_right">
				<ul>
					<li>
						<strong style="font-size:14px; font-weight:bold;">${product.name }</strong>
					</li>
					<li>
						<label>价格：</label>
						<span><strong>${product.price }</strong>元</span>
					</li>
					<li>
						<label>运费：</label>
						<span>卖家承担运费</span>
					</li>
					<li>
						<label>累计售出：</label>
						<span>${product.sellNum }件</span>
					</li>
					<li>
						<label>评价：</label>
						<span>${product.commentNum }条评论</span>
					</li>
					<li>
						<label>浏览量：</label>
						<span>${product.viewNum }次</span>
					</li>
					<li class="goods_num">
						<label>购买数量：</label>
						<span><a class="good_num_jian" id="good_num_jian" href="javascript:void(0);"></a><input type="text" value="1" id="good_nums" style="text-align:center;width:40px;" class="good_nums" /><a href="javascript:void(0);" id="good_num_jia" stock="${product.stock }" class="good_num_jia"></a>(当前库存${product.stock }件)</span>
					</li>
					<li style="padding:20px 0;">
						<label>&nbsp;</label>
						<span><a href="javascript:void(0)" id="add-cart-btn" class="goods_sub goods_sub_gou" >加入购物车</a></span>
						<span><a href="javascript:void(0)" id="add-favorite-btn" pid="${product.id }" class="goods_sub_gou" >收藏该商品</a></span>
					</li>
				</ul>
			</div>
		</div>
		<!-- 商品展示 End -->

		<div class="clear mt15"></div>
		<!-- Goods Left -->
		<div class="shop_bd_list_left clearfix">
			

			<!-- 热卖推荐商品 -->
			<div class="shop_bd_list_bk clearfix">
				<div class="title">热卖推荐商品</div>
				<div class="contents clearfix">
					<ul class="clearfix">
						
						<c:forEach items="${sellProductList }" var="sellProduct">
						<li class="clearfix">
							<div class="goods_name"><a href="../product/detail?id=${sellProduct.id }">${sellProduct.name }</a></div>
							<div class="goods_pic"><span class="goods_price">¥ ${sellProduct.price } </span><a href=""><img src="${sellProduct.imageUrl }" /></a></div>
							<div class="goods_xiaoliang">
								<span class="goods_xiaoliang_link"><a href="../product/detail?id=${sellProduct.id }">去看看</a></span>
								<span class="goods_xiaoliang_nums">已销售<strong>${sellProduct.sellNum }</strong>笔</span>
							</div>
						</li>
						</c:forEach>
					</ul>
				</div>
			</div>
			<!-- 热卖推荐商品 -->
			<div class="clear"></div>

		</div>
		<!-- Goods Left End -->

		<!-- 商品详情 -->
		<script type="text/javascript" src="../resources/home/js/shop_goods_tab.js"></script>
		<div class="shop_goods_bd_xiangqing clearfix">
			<div class="shop_goods_bd_xiangqing_tab">
				<ul>
					<li id="xiangqing_tab_1" onmouseover="shop_goods_easytabs('1', '1');" onfocus="shop_goods_easytabs('1', '1');" onclick="return false;"><a href=""><span>商品详情</span></a></li>
					<li id="xiangqing_tab_2" onmouseover="shop_goods_easytabs('1', '2');" onfocus="shop_goods_easytabs('1', '2');" onclick="return false;"><a href=""><span>商品评论</span></a></li>
				</ul>
			</div>
			<div class="shop_goods_bd_xiangqing_content clearfix">
				<div id="xiangqing_content_1" class="xiangqing_contents clearfix">
					<p>${product.content }</p>
				</div>
				<div id="xiangqing_content_2" class="xiangqing_contents clearfix">
					<c:forEach items="${commentList }" var="comment">
						<p style="height:35px;">
							<c:if test="${comment.type == 1 }">
								<span class="pingjia_type pingjia_type_1"></span>
							</c:if>
							<c:if test="${comment.type == 2 }">
								<span class="pingjia_type pingjia_type_2"></span>
							</c:if>
							<c:if test="${comment.type == 0 }">
								<span class="pingjia_type pingjia_type_3"></span>
							</c:if>
							<span style="display:inline-block;margin-top: 8px;">
								${comment.content }
								[<fmt:formatDate value="${comment.createTime}" pattern="yyyy-MM-dd HH:mm:ss" />]
							</span>
						</p>
					</c:forEach>
					<c:if test="${empty commentList }">
					<p>还没有人评价过哦！</p>
					</c:if>
				</div>
			</div>
		</div>
		<!-- 商品详情 End -->

	</div>

	<div class="clear"></div>
	<%@include file="../common/footer.jsp"%>
</body>
<script>
	$(document).ready(function(){
		$("#add-cart-btn").click(function(){
			var num = $("#good_nums").val();
			if(num == '' || parseInt(num) < 1){
				alert('请选择正确数量!');
				return;
			}
			$.ajax({
				url:'../cart/add',
				type:'POST',
				data:{num:num,productId:'${product.id}'},
				dataType:'json',
				success:function(data){
					if(data.type == 'success'){
						alert('添加成功!');
						//window.location.href = 'index';
					}else{
						alert(data.msg);
					}
				}
			});
		});
		//收藏商品
		$("#add-favorite-btn").click(function(){
			var pid = $(this).attr('pid');
			var $this = $(this);
			$.ajax({
				url:'../favorite/add',
				type:'POST',
				data:{productId:pid},
				dataType:'json',
				success:function(data){
					if(data.type == 'success'){
						alert('收藏成功!');
						//window.location.href = 'index';
					}else{
						alert(data.msg);
					}
				}
			});
		});
	});
</script>
</html>