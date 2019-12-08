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
            <label>时间范围:</label>
            <input id="search-startTime" class="wu-text easyui-datebox" style="width:100px">
            ~
            <input id="search-endTime" class="wu-text easyui-datebox" style="width:100px">
            <a href="#" id="search-btn" class="easyui-linkbutton" iconCls="icon-search">生成图表</a>
        </div>
    </div>
    <div class="easyui-panel" title="订单统计图表" style="width:900px;height:600px;padding:10px;">
			<div id="main" style="width: 850px;height:550px;"></div>
	</div>
</div>
<%@include file="../common/footer.jsp"%>
<script type="text/javascript" src="../../resources/admin/echarts/echarts.min.js"></script>
<!-- End of easyui-dialog -->
<script type="text/javascript">
	
// 基于准备好的dom，初始化echarts实例
var myChart = echarts.init(document.getElementById('main'));

// 指定图表的配置项和数据



	
	
	//搜索按钮监听
	$("#search-btn").click(function(){
		var data = {};
		var startTime = $("#search-startTime").datebox("getValue");
		var endTime = $("#search-endTime").datebox("getValue");
		if(startTime != ''){
			data.startTime = startTime;
		}
		if(endTime != ''){
			data.endTime = endTime;
		}
		$.ajax({
			url:'get_data',
			dataType:'json',
			type:'post',
			data:data,
			success:function(data){
				if(data.type == 'success'){
					var statsData = data.dataList;
					var xList = [];
					var yList = [];
					for(var i=0;i<statsData.length;i++){
						xList.push(statsData[i].date);
						yList.push(statsData[i].money);
					}
					var option = {
						    title: {
						        text: '订单销售金额统计'
						    },
						    tooltip: {
						        trigger: 'axis',
						        axisPointer: {
						            type: 'cross',
						            crossStyle: {
						                color: '#999'
						            }
						        }
						    },
						    legend: {
						        data:['销售金额']
						    },
						    xAxis: {
						        data: xList
						    },
						    yAxis: {},
						    series: [{
						        name: '销售金额',
						        type: 'bar',
						        data: yList
						    }]
						};
					// 使用刚指定的配置项和数据显示图表。
					myChart.setOption(option);
				}else{
					$.messager.alert('信息提示',data.msg,'warning');
				}
			}
		});
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
	
	
</script>