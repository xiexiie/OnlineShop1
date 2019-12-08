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
            <label>客户名称:</label><input id="search-name" class="wu-text" style="width:100px">
            <label>客户性别:</label>
            <select id="search-sex" class="easyui-combobox" style="width:100px">
            	<option value="-1">全部</option>
            	<option value="0">未知</option>
            	<option value="1">男</option>
            	<option value="2">女</option>
            </select>
            <label>客户状态:</label>
            <select id="search-status" class="easyui-combobox" style="width:100px">
            	<option value="-1">全部</option>
            	<option value="1">正常</option>
            	<option value="0">冻结</option>
            </select>	
            <a href="#" id="search-btn" class="easyui-linkbutton" iconCls="icon-search">搜索</a>
        </div>
    </div>
    <!-- End of toolbar -->
    <table id="data-datagrid" class="easyui-datagrid" toolbar="#wu-toolbar"></table>
</div>
<!-- Begin of easyui-dialog -->
<div id="add-dialog" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:420px; padding:10px;">
	<form id="add-form" method="post">
        <table>
            <tr>
                <td width="60" align="right">客户名:</td>
                <td><input type="text" name="name" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写客户名称'" /></td>
            </tr>
            <tr>
                <td width="60" align="right">密码:</td>
                <td><input type="password" name="password" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写客户密码'" /></td>
            </tr>
            <tr>
                <td width="60" align="right">邮箱:</td>
                <td><input type="text" name="email" class="wu-text" /></td>
            </tr>
            <tr>
                <td width="60" align="right">真实姓名:</td>
                <td><input type="text" name="trueName" class="wu-text" /></td>
            </tr>
            <tr>
                <td width="60" align="right">性别:</td>
                <td>
                	<select name="sex" class="easyui-combobox" style="width:268px">
		            	<option value="0">未知</option>
		            	<option value="1">男</option>
		            	<option value="2">女</option>
		            </select>	
                </td>
            </tr>
           <tr>
                <td width="60" align="right">状态:</td>
                <td>
                	<select name="status" class="easyui-combobox" style="width:268px">
		            	<option value="1">正常</option>
		            	<option value="0">冻结</option>
		            </select>	
                </td>
            </tr>
        </table>
    </form>
</div>
<!-- 修改窗口 -->
<div id="edit-dialog" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:450px; padding:10px;">
	<form id="edit-form" method="post">
        <input type="hidden" name="id" id="edit-id">
        <table>
           <tr>
                <td width="60" align="right">客户名:</td>
                <td><input type="text" id="edit-name" name="name" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写客户名称'" /></td>
            </tr>
            <tr>
                <td width="60" align="right">密码:</td>
                <td><input type="password" id="edit-password" name="password" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写客户密码'" /></td>
            </tr>
            <tr>
                <td width="60" align="right">邮箱:</td>
                <td><input type="text" id="edit-email" name="email" class="wu-text" /></td>
            </tr>
            <tr>
                <td width="60" align="right">真实姓名:</td>
                <td><input type="text" id="edit-trueName" name="trueName" class="wu-text" /></td>
            </tr>
            <tr>
                <td width="60" align="right">性别:</td>
                <td>
                	<select id="edit-sex" name="sex" class="easyui-combobox" style="width:268px">
		            	<option value="0">未知</option>
		            	<option value="1">男</option>
		            	<option value="2">女</option>
		            </select>	
                </td>
            </tr>
           <tr>
                <td width="60" align="right">状态:</td>
                <td>
                	<select id="edit-status" name="status" class="easyui-combobox" style="width:268px">
		            	<option value="1">正常</option>
		            	<option value="0">冻结</option>
		            </select>	
                </td>
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
	function add(){
		var validate = $("#add-form").form("validate");
		if(!validate){
			$.messager.alert("消息提醒","请检查你输入的数据!","warning");
			return;
		}
		var data = $("#add-form").serialize();
		$.ajax({
			url:'add',
			dataType:'json',
			type:'post',
			data:data,
			success:function(data){
				if(data.type == 'success'){
					$.messager.alert('信息提示','添加成功！','info');
					$('#add-dialog').dialog('close');
					$('#data-datagrid').datagrid('reload');
				}else{
					$.messager.alert('信息提示',data.msg,'warning');
				}
			}
		});
	}
	
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
            title: "编辑客户信息",
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
            	$("#edit-sex").combobox('setValue',item.sex);
            	$("#edit-status").combobox('setValue',item.status);
            	$("#edit-name").val(item.name);
            	$("#edit-password").val(item.password);
            	$("#edit-email").val(item.email);
            	$("#edit-trueName").val(item.trueName);
            }
        });
	}
	
	/**
	* Name 打开添加窗口
	*/
	function openAdd(){
		//$('#add-form').form('clear');
		$('#add-dialog').dialog({
			closed: false,
			modal:true,
            title: "添加客户信息",
            buttons: [{
                text: '确定',
                iconCls: 'icon-ok',
                handler: add
            }, {
                text: '取消',
                iconCls: 'icon-cancel',
                handler: function () {
                    $('#add-dialog').dialog('close');                    
                }
            }],
            onBeforeOpen:function(){
            	//$("#add-form input").val('');
            }
        });
	}
	
	//搜索按钮监听
	$("#search-btn").click(function(){
		var option = {name:$("#search-name").val()};
		var sex = $("#search-sex").combobox('getValue');
		if(sex != -1){
			option.sex = sex;
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
		fit:true,
		columns:[[
			{ field:'chk',checkbox:true},
			{ field:'name',title:'客户名称',width:180,sortable:true},
			{ field:'password',title:'登录密码',width:200},
			{ field:'email',title:'邮箱',width:200},
			{ field:'trueName',title:'真实姓名',width:200},
			{ field:'sex',title:'性别',width:200,formatter:function(value,index,row){
				if(value == 0)return '未知';
				if(value == 1)return '男';
				if(value == 2)return '女';
				return (value);
			}},
			{ field:'status',title:'状态',width:200,formatter:function(value,index,row){
				if(value == 0)return '冻结';
				if(value == 1)return '正常';
				return (value);
			}},
			{ field:'createTime',title:'注册时间',width:200,formatter:function(value,index,row){
				return format(value);
			}},
		]]
	});
</script>