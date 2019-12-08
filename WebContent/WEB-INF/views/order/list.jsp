<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../common/header.jsp"%>
<div class="easyui-layout" data-options="fit:true">
    <!-- Begin of toolbar -->
    <!-- 换行关键词nowrap:false, -->
    <div id="wu-toolbar">
        <div class="wu-toolbar-button">
            <%@include file="../common/menus.jsp"%>
        </div>
        <div class="wu-toolbar-search">
            <label>订单编号:</label><input id="search-sn" class="wu-text" style="width:100px">
            <label>用户名:</label><input id="search-username" class="wu-text" style="width:100px">
            <label>订单状态:</label>
            <select id="search-status" class="easyui-combobox" style="width:100px">
            	<option value="-1">全部</option>
            	<option value="0">待发货</option>
            	<option value="1">已发货</option>
            	<option value="2">已完成</option>
            </select>
            <label>订单金额:</label>
			<input id="search-moneyMin" class="wu-text" style="width:50px">
			~
			<input id="search-moneyMax" class="wu-text" style="width:50px">
            <a href="#" id="search-btn" class="easyui-linkbutton" iconCls="icon-search">搜索</a>
        </div>
    </div>
    <!-- End of toolbar -->
    <table id="data-datagrid" class="easyui-datagrid" toolbar="#wu-toolbar"></table>
</div>
<!-- Begin of easyui-dialog -->
<div id="view-dialog" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:600px;padding:10px;">
     <table id="order-item-datagrid" class="easyui-datagrid" style="width:570px;height:450px;">
     	<thead>
     		<tr>
     			<th field="id">ID</th>
     			<th field="imageUrl" data-options="width:120">商品图片</th>
     			<th field="name" data-options="width:150">商品名称</th>
     			<th field="num" data-options="width:100">商品数量</th>
     			<th field="price" data-options="width:100">商品价格</th>
     			<th field="money" data-options="width:100">金额</th>
     		</tr>
     	</thead>
     </table>
</div>
<!-- 修改窗口 -->
<div id="edit-dialog" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:450px; padding:10px;">
	<form id="edit-form" method="post">
        <input type="hidden" name="id" id="edit-id">
        <table>
            <tr>
                <td width="60" align="right">收货地址:</td>
                <td><input type="text" id="edit-address" name="address" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写收货地址'" /></td>
            </tr>
            <tr>
                <td width="60" align="right">订单金额:</td>
                <td><input type="text" id="edit-money" name="money" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写订单金额'" /></td>
            </tr>
            <tr>
                <td width="60" align="right">订单状态:</td>
                <td>
                	<select id="edit-status" name="status" class="easyui-combobox" style="width:268px">
		            	<option value="0">待发货</option>
		            	<option value="1">已发货</option>
		            	<option value="2">已完成</option>
		            </select>	
                </td>
            </tr>
            <tr>
                <td align="right">备注:</td>
                <td><textarea id="edit-remark" name="remark" rows="6" class="wu-textarea" style="width:260px"></textarea></td>
            </tr>
        </table>
    </form>
</div>
<%@include file="../common/footer.jsp"%>

<!-- End of easyui-dialog -->
<script type="text/javascript">
	
	
	
	
	
	/**
	*  添加记录
	*/
	function edit(){
		var validate = $("#edit-form").form("validate");
		if(!validate){
			$.messager.alert("消息提醒","请检查你输入的数据!","warning");
			return;
		}
		var data = $("#edit-form").serialize();
		$.ajax({
			url:'edit',
			dataType:'json',
			type:'post',
			data:data,
			success:function(data){
				if(data.type == 'success'){
					$.messager.alert('信息提示','编辑成功！','info');
					$('#edit-dialog').dialog('close');
					$('#data-datagrid').datagrid('reload');
				}else{
					$.messager.alert('信息提示',data.msg,'warning');
				}
			}
		});
	}
	
	
	
	/**
	* Name 打开编辑窗口
	*/
	function openEdit(){
		//$('#add-form').form('clear');
		var item = $('#data-datagrid').datagrid('getSelected');
		if(item == null || item.length == 0){
			$.messager.alert('信息提示','请选择要编辑的数据！','info');
			return;
		}
		$('#edit-dialog').dialog({
			closed: false,
			modal:true,
            title: "编辑订单信息",
            buttons: [{
                text: '确定',
                iconCls: 'icon-ok',
                handler: edit
            }, {
                text: '取消',
                iconCls: 'icon-cancel',
                handler: function () {
                    $('#edit-dialog').dialog('close');                    
                }
            }],
            onBeforeOpen:function(){
            	//$("#add-form input").val('');
            	$("#edit-id").val(item.id);
            	$("#edit-status").combobox('setValue',item.status);
            	$("#edit-address").val(item.address);
            	$("#edit-money").val(item.money);
            	$("#edit-remark").val(item.remark);
            }
        });
	}
	
	/**
	* Name 打开查看窗口
	*/
	function openView(){
		//$('#add-form').form('clear');
		var item = $('#data-datagrid').datagrid('getSelected');
		if(item == null || item.length == 0){
			$.messager.alert('信息提示','请选择要编辑的数据！','info');
			return;
		}
		$('#view-dialog').dialog({
			closed: false,
			modal:true,
            title: "查看订单信息",
            buttons: [{
                text: '确定',
                iconCls: 'icon-ok',
                handler: function () {
                    $('#view-dialog').dialog('close');                    
                }
            }, {
                text: '取消',
                iconCls: 'icon-cancel',
                handler: function () {
                    $('#view-dialog').dialog('close');                    
                }
            }],
            onBeforeOpen:function(){
            	//$("#add-form input").val('');
            	$('#order-item-datagrid').datagrid({
            		url:'get_item_list?orderId='+item.id,
            		nowrap:false,
            		columns:[[
								{ field:'id',title:'ID'},
								{ field:'imageUrl',title:'商品主图',width:120,formatter:function(value,index,row){
									return '<img src = '+value+' width="120px">';
								}},
								{ field:'name',title:'商品名称',width:150},
								{ field:'price',title:'商品价格',width:100,sortable:true},
								{ field:'num',title:'商品数量',width:100,sortable:true},
								{ field:'money',title:'金额',width:100,sortable:true}
            				]]
            	});
            }
        });
	}
	
	//搜索按钮监听
	$("#search-btn").click(function(){
		var option = {sn:$("#search-sn").val()};
		var username = $("#search-username").val();
		if(username != ''){
			option.username = username;
		}
		var moneyMin = $("#search-moneyMin").val();
		if(moneyMin != ''){
			option.moneyMin = moneyMin;
		}
		var moneyMax = $("#search-moneyMax").val();
		if(moneyMax != ''){
			option.moneyMax = moneyMax;
		}
		var status = $("#search-status").combobox('getValue');
		if(status != -1){
			option.status = status;
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
	var accountList = ${accountList};
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
		fit:true,
		nowrap:false,
		columns:[[
			{ field:'chk',checkbox:true},
			{ field:'sn',title:'订单编号',width:180,sortable:true},
			{ field:'userId',title:'所属用户',width:100,formatter:function(value,index,row){
				for(var i=0;i<accountList.length;i++){
					if(value == accountList[i].id)return accountList[i].name;
				}
				return value;
			}},
			{ field:'address',title:'收货信息',width:180},
			{ field:'money',title:'订单金额',width:100,sortable:true},
			{ field:'productNum',title:'订单商品数',width:100,sortable:true},
			{ field:'status',title:'订单状态',width:100,formatter:function(value,row,index){
				if(value == 0)return '待发货';
				if(value == 1)return '已发货';
				if(value == 2)return '已完成';
				return (value);
			}},
			{ field:'remark',title:'备注',width:200},
			{ field:'createTime',title:'创建时间',width:150,formatter:function(value,index,row){
				return format(value);
			}}
		]]
	});
</script>