<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../common/header.jsp"%>
 <link rel="stylesheet" href="../resources/home/css/shop_list.css" type="text/css" />
 <script type="text/javascript" src="../resources/home/js/shop_list.js" ></script>
<div class="shop_bd clearfix">
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

		<div class="shop_bd_list_right clearfix">
			<!-- 显示菜单 -->
			<div class="sort-bar">
				<div class="bar-l"> 
		            <!-- 查看方式S -->
		            <!-- 查看方式E --> 
		            <!-- 排序方式S -->
		            <ul class="array">
		              <li class="selected"><a title="默认排序" class="nobg" href="../product/product_category_list?cid=${cid }&priceMin=${priceMin}&priceMax=${priceMax}&page=${page}">默认</a></li>
		              <li><a title="点击按销量从高到低排序"  href="../product/product_category_list?cid=${cid }&orderby=sellNum&priceMin=${priceMin}&priceMax=${priceMax}&page=${page}">销量</a></li>
		              <li><a title="点击按人气从高到低排序"  href="../product/product_category_list?cid=${cid }&orderby=viewNum&priceMin=${priceMin}&priceMax=${priceMax}&page=${page}">人气</a></li>
		              <li><a title="点击按价格从高到低排序"  href="../product/product_category_list?cid=${cid }&orderby=price&priceMin=${priceMin}&priceMax=${priceMax}&page=${page}">价格</a></li>
		            </ul>
		            <!-- 排序方式E --> 
		            <!-- 价格段S -->
		            <div class="prices"> <em>¥</em>
		              <input type="text" id="priceMin" value="${priceMin}" class="w30">
		              <em>-</em>
		              <input type="text" id="priceMax" value="${priceMax}" class="w30">
		              <input type="submit" value="确认" id="search_by_price">
		            </div>
		            <!-- 价格段E --> 
		          </div>
			</div>
			<div class="clear"></div>
			<!-- 显示菜单 End -->

			<!-- 商品列表 -->
			<div class="shop_bd_list_content clearfix">
				<ul>
					<c:forEach items="${productList }" var="product">
					<li>
						<dl>
							<dt><a href="../product/detail?id=${product.id }"><img src="${product.imageUrl }" /></a></dt>
							<dd class="title"><a href="../product/detail?id=${product.id }">${product.name }</a></dd>
							<dd class="content">
								<span class="goods_jiage">￥<strong>${product.price }</strong></span>
								<span class="goods_chengjiao">最近成交${product.sellNum }笔</span>
							</dd>
						</dl>
					</li>
					</c:forEach>
				</ul>
			</div>
			<div class="clear"></div>
			<div class="pagination"> 
				<ul>
					<li><span><a href="../product/product_category_list?cid=${cid }&orderby=${orderby}&priceMin=${priceMin}&priceMax=${priceMax}&page=${page -1}">上一页</a></span></li>
					<li><span class="currentpage">${page}</span></li>
					<li><span><a href="../product/product_category_list?cid=${cid }&orderby=${orderby}&priceMin=${priceMin}&priceMax=${priceMax}&page=${page +1}">下一页</a></span></li>
				</ul> 
			</div>
			<!-- 商品列表 End -->


		</div>
	</div>
	<!-- Footer - wll - 2013/3/24 -->
	<div class="clear"></div>
	<%@include file="../common/footer.jsp"%>
</body>
<script>
	$(document).ready(function(){
		$("#search_by_price").click(function(){
			window.location.href = 'product_category_list?cid=${cid }&orderby=${orderby}&priceMin='+$("#priceMin").val()+'&priceMax='+$("#priceMax").val()+'&page=${page}';
		});
	});
</script>
</html>