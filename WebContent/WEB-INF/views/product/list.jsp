<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../common/header.jsp"%>
<div class="easyui-layout" data-options="fit:true">
    <!-- Begin of toolbar -->
    <div id="wu-toolbar">
        <div class="wu-toolbar-button">
            <%@include file="../common/menus.jsp"%>
        </div>
        <div class="wu-toolbar-search">
            <label>商品标题:</label><input id="search-name" class="wu-text" style="width:100px">
            <label>所属分类:</label>
            <select id="search-productCategoryId" idField="id" treeField="name" class="easyui-combotree" url="tree_list" panelHeight="256px" style="width:180px">
			</select>
			<label>价格区间:</label>
			<input id="search-priceMin" class="wu-text" style="width:50px">
			~
			<input id="search-priceMax" class="wu-text" style="width:50px">
            <a href="#" id="search-btn" class="easyui-linkbutton" iconCls="icon-search">搜索</a>
        </div>
    </div>
    <!-- End of toolbar -->
    <table id="data-datagrid" class="easyui-datagrid" toolbar="#wu-toolbar"></table>
</div>
<!-- Begin of easyui-dialog -->
<%@include file="../common/footer.jsp"%>

<!-- End of easyui-dialog -->
<script type="text/javascript">
	
	
	/**
	* 删除记录
	*/
	function remove(){
		$.messager.confirm('信息提示','确定要删除该记录？', function(result){
			if(result){
				var item = $('#data-datagrid').datagrid('getSelected');
				if(item == null || item.length == 0){
					$.messager.alert('信息提示','请选择要删除的数据！','info');
					return;
				}
				$.ajax({
					url:'delete',
					dataType:'json',
					type:'post',
					data:{id:item.id},
					success:function(data){
						if(data.type == 'success'){
							$.messager.alert('信息提示','删除成功！','info');
							$('#data-datagrid').datagrid('reload');
						}else{
							$.messager.alert('信息提示',data.msg,'warning');
						}
					}
				});
			}	
		});
	}
	
	
	/**
	* Name 打开添加窗口
	*/
	function openAdd(){
		//$('#add-form').form('clear');
		window.location.href = 'add';
	}
	function openEdit(){
		//$('#add-form').form('clear');
		var item = $('#data-datagrid').datagrid('getSelected');
		if(item == null || item.length == 0){
			$.messager.alert('信息提示','请选择要编辑的数据！','info');
			return;
		}
		window.location.href = 'edit?id=' + item.id;
	}
	
	//搜索按钮监听
	$("#search-btn").click(function(){
		var option = {name:$("#search-name").val()};
		var productCategoryId = $("#search-productCategoryId").combotree('getValue');
		if(productCategoryId != null && productCategoryId != ''){
			option.productCategoryId = productCategoryId;
		}
		var priceMin = $("#search-priceMin").val();
		if(priceMin != ''){
			option.priceMin = priceMin;
		}
		var priceMax = $("#search-priceMax").val();
		if(priceMax != ''){
			option.priceMax = priceMax;
		}
		$('#data-datagrid').datagrid('reload',option);
	});
	
	function add0(m){return m<10?'0'+m:m }
	function format(shijianchuo){
	//shijianchuo是整数，否则要parseInt转换
		var time = new Date(shijianchuo);
		var y = time.getFullYear();
		var m = time.getMonth()+1;
		var d = time.getDate();
		var h = time.getHours();
		var mm = time.getMinutes();
		var s = time.getSeconds();
		return y+'-'+add0(m)+'-'+add0(d)+' '+add0(h)+':'+add0(mm)+':'+add0(s);
	}
	
	var productCategoryList = ${productCategoryList};
	/** 
	* 载入数据
	*/
	$('#data-datagrid').datagrid({
		url:'list',
		rownumbers:true,
		singleSelect:true,
		pageSize:20,           
		pagination:true,
		multiSort:true,
		fitColumns:true,
		idField:'id',
	    treeField:'name',
	    nowrap:false,
		fit:true,
		columns:[[
			{ field:'chk',checkbox:true},
			{ field:'imageUrl',title:'商品主图',width:80,formatter:function(value,index,row){
				return '<img src = '+value+' width="80px">';
			}},
			{ field:'name',title:'商品标题',width:180,sortable:true},
			{ field:'productCategoryId',title:'所属分类',width:100,formatter:function(value,index,row){
				for(var i=0;i<productCategoryList.length;i++){
					if(value == productCategoryList[i].id)return productCategoryList[i].name;
				}
				return value;
			}},
			{ field:'price',title:'商品价格',width:80},
			{ field:'stock',title:'商品库存',width:100},
			{ field:'sellNum',title:'商品销量',width:100},
			{ field:'viewNum',title:'商品浏览量',width:100},
			{ field:'commentNum',title:'商品评论数',width:100},
			{ field:'createTime',title:'商品添加时间',width:150,formatter:function(value,index,row){
				return format(value);
			}}
		]]
	});
</script>