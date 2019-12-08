<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../common/header.jsp"%>
<!-- Body -wll-2013/03/24 -->
	<div class="shop_bd clearfix">
            <!-- 第一块区域  -->
            <div class="shop_bd_top clearfix">
                <div class="shop_bd_top_left"></div>
                <div class="shop_bd_top_center">
                    <!-- 图片切换  begin  -->
                    <div class="xifan_sub_box" style="width:780px;height:350px;">
                      <div id="p-select" class="sub_nav" style="width:780px;height:350px;">
                      	<div class="sub_no" id="xifan_bd1lfsj" style="margin-top: 330px;"> 
                      		<ul></ul>
                      	</div>
                      </div>
                      <div id="xifan_bd1lfimg" style="width:780px;height:350px;">
                        <div >
                          <dl class="" style="width:780px;height:350px;">
                            <dt><a href="" title="" target="_blank"><img width="780px" height="360px" src="../resources/home/images/1.jpg" alt="2011城市主题公园亲子游"></a></dt>
                            <dd><h2><a href="" target="_blank">国庆节大促销</a></h2></dd>
                          </dl>
                          <dl class="" style="width:780px;height:350px;">
                            <dt><a href="" title="" target="_blank"><img width="780px" height="360px" src="../resources/home/images/1.jpg" alt="2011城市主题公园亲子游"></a></dt>
                            <dd><h2><a href="" target="_blank">情人节促销活动</a></h2></dd>
                          </dl>
                          <dl class="" style="width:780px;height:350px;">
                            <dt><a href="" title="" target="_blank"><img width="780px" height="360px" src="../resources/home/images/2.jpg" alt="2011城市主题公园亲子游"></a></dt>
                            <dd><h2><a href="" target="_blank">秋季大促销</a></h2></dd>
                          </dl>
                          <dl class="" style="width:780px;height:350px;">
                            <dt><a href="" title="" target="_blank"><img width="780px" height="360px" src="../resources/home/images/3.jpg" alt="2011城市主题公园亲子游"></a></dt>
                            <dd><h2><a href="" target="_blank">春季促销打折季</a></h2></dd>
                          </dl>
                        </div>
                      </div>
                    </div>
                    <script type="text/javascript">movec();</script> 
                    <!-- 图片切换  end --> 
                    <div class="clear"></div>
                </div>
                
                
            </div>
            <div class="clear"></div>
            
            <div class="shop_bd_home_block clearfix">
               
                <!-- 中间 -->
                <div class="shop_bd_home_block_center" style="width:998px;">
                    <ul class="tabs-nav" style="width:998px;">
                        <li><a href="javascript:void(0);">最新上架</a></li>
                    </ul>
                    <div class="tabs-panel" style="width:998px;">
                        <ul>
                            <c:forEach items="${lastProductList }" var="product">
                            <li style="width:158px;height:190px;">
                                <dl>
                                    <dt><a href="../product/detail?id=${product.id }"><img src="${product.imageUrl }" style="width:158px;" /></a></dt>
                                    <dd><a href="../product/detail?id=${product.id }">${product.name }</a></dd>
                                    <dd>商城价：<em>${product.price }</em>元</dd>
                                </dl>
                            </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
                <!-- 中间 End -->
                <div class="shop_bd_home_block_center" style="width:998px;">
                    <ul class="tabs-nav" style="width:998px;">
                        <li><a href="javascript:void(0);">最近热卖</a></li>
                    </ul>
                    <div class="tabs-panel" style="width:998px;">
                        <ul>
                            <c:forEach items="${sellProductList }" var="product">
                            <li style="width:158px;height:190px;">
                                <dl>
                                    <dt><a href="../product/detail?id=${product.id }"><img style="width:158px;" src="${product.imageUrl }" /></a></dt>
                                    <dd><a href="../product/detail?id=${product.id }">${product.name }</a></dd>
                                    <dd>商城价：<em>${product.price }</em>元</dd>
                                </dl>
                            </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
                
                
                
                
            </div>
            <div clas="clear"></div>
            <!-- 第三块区域 End -->
            
           
	</div>
	<!-- Body End -->

	<!-- Footer - wll - 2013/3/24 -->
	<div class="clear"></div>
	<%@include file="../common/footer.jsp"%>
</body>
</html>