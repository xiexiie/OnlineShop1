<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../common/header.jsp"%>
<div class="easyui-panel" title="编辑商品" style="width:1200px;height:800px;">
	<div style="padding:0px">
		<form id="edit-form" method="post">
	        <input type="hidden" name="id" value="${product.id }">
	        <table cellspacing="15">
	            <tr>
	                <td width="60" align="right">商品分类:</td>
	                <td >
	                	<select id="edit-categoryId" name="productCategoryId" idField="id" treeField="name" class="easyui-combotree easyui-validatebox" data-options="required:true, missingMessage:'请选择所属分类'" url="tree_list" panelHeight="256px" style="width:268px">
			            </select>	
	                </td>
	            </tr>
	            <tr>
	                <td width="60" align="right">商品标题:</td>
	                <td ><input type="text" name="name" value="${product.name }" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写商品标题'" /></td>
	            </tr>
	            <tr>
	                <td width="60" align="right">商品主图:</td>
	                <td>
	                	<input readonly="readonly" value="${product.imageUrl }" type="text" id="add-imageUrl" name="imageUrl" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请上传图片'" />
	                	<a href="javascript:uploadPhoto()" id="upload-btn" class="easyui-linkbutton" iconCls="icon-upload">上传图片</a>
	                	<a href="javascript:previewPhoto()" id="view-btn" class="easyui-linkbutton" iconCls="icon-eye">预览图片</a>
	                </td>
	            </tr>
	            <tr>
	                <td width="60" align="right">商品价格:</td>
	                <td><input type="text" name="price" value="${product.price }" class="wu-text easyui-numberbox easyui-validatebox" data-options="required:true,min:0,precision:2, missingMessage:'请填写商品价格'" /></td>
	            </tr>
	            <tr>
	                <td width="60" align="right">商品库存:</td>
	                <td ><input type="text" name="stock" value="${product.stock }" class="wu-text easyui-numberbox easyui-validatebox" data-options="required:true,min:0,precision:0, missingMessage:'请填写商品库存'" /></td>
	            </tr>
	            <tr>
	                <td align="right">详情描述:</td>
	                <td style="border:0px;"><textarea id="edit-content" name="content" style="width:600px;height:320px;">${product.content }</textarea></td>
	            </tr>
	            <tr>
	                <td align="right"></td>
	                <td style="border:0px;">
	                	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="submitForm()">提交</a>
	                	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" onclick="back()">返回</a>
	                </td>
	            </tr>
	        </table>
	    </form>
    </div>
</div>
<div id="preview-dialog" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:420px;">
        <table>
            <tr>
                <td>
                	<img src="${product.imageUrl }" id="preview-photo" width="400px">
                </td>
            </tr>
        </table>
</div>
<div id="process-dialog" class="easyui-dialog" data-options="closed:true,iconCls:'icon-upload',title:'正在上传图片'" style="width:450px; padding:10px;">
<div id="p" class="easyui-progressbar" style="width:400px;" data-options="text:'正在上传中...'"></div>
</div>
<input type="file" id="photo-file" style="display:none;" onchange="upload()">
<%@include file="../common/footer.jsp"%>
<!-- 配置文件 -->
    <script type="text/javascript" src="../../resources/admin/ueditor/ueditor.config.js"></script>
    <!-- 编辑器源码文件 -->
    <script type="text/javascript" src="../../resources/admin/ueditor/ueditor.all.js"></script>
<!-- End of easyui-dialog -->
<script type="text/javascript">
var ue = UE.getEditor('edit-content');

//上传图片
function start(){
		var value = $('#p').progressbar('getValue');
		if (value < 100){
			value += Math.floor(Math.random() * 10);
			$('#p').progressbar('setValue', value);
		}else{
			$('#p').progressbar('setValue',0)
		}
};
function upload(){
	if($("#photo-file").val() == '')return;
	var formData = new FormData();
	formData.append('photo',document.getElementById('photo-file').files[0]);
	$("#process-dialog").dialog('open');
	var interval = setInterval(start,200);
	$.ajax({
		url:'../user/upload_photo',
		type:'post',
		data:formData,
		contentType:false,
		processData:false,
		success:function(data){
			clearInterval(interval);
			$("#process-dialog").dialog('close');
			if(data.type == 'success'){
				$("#preview-photo").attr('src',data.filepath);
				$("#add-imageUrl").val(data.filepath);
			}else{
				$.messager.alert("消息提醒",data.msg,"warning");
			}
		},
		error:function(data){
			clearInterval(interval);
			$("#process-dialog").dialog('close');
			$.messager.alert("消息提醒","上传失败!","warning");
		}
	});
}

function uploadPhoto(){
	$("#photo-file").click();
	
}
function previewPhoto(){
	$('#preview-dialog').dialog({
		closed: false,
		modal:true,
        title: "预览商品主图",
        buttons: [{
            text: '确定',
            iconCls: 'icon-ok',
            handler: function(){
            	$('#preview-dialog').dialog('close'); 
            }
        }, {
            text: '取消',
            iconCls: 'icon-cancel',
            handler: function () {
                $('#preview-dialog').dialog('close');                    
            }
        }]
    });
	
}
	
function submitForm(){
	edit();
}
function back(){
	window.history.go(-1);
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
					$.messager.alert('信息提示','添加成功！','info');
					window.history.go(-1);
				}else{
					$.messager.alert('信息提示',data.msg,'warning');
				}
			}
		});
	}
setTimeout(function(){
	$("#edit-categoryId").combotree('setValue','${product.productCategoryId}');
},500);	
	
</script>