package com.xieyunjie.programmer.controller.admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.xieyunjie.programmer.service.common.OrderService;

/**
 * 统计管理控制器
 * @author llq
 *
 */
@RequestMapping("/admin/stats")
@Controller
public class StatsController {
	@Autowired
	private OrderService orderService;
	
	/**
	 * 统计列表页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/stats",method=RequestMethod.GET)
	public ModelAndView list(ModelAndView model){
		model.setViewName("stats/stats");
		return model;
	}
	
	/**
	 * 获取统计列表
	 * @param page
	 * @param content
	 * @param roleId
	 * @param sex
	 * @return
	 */
	@RequestMapping(value="/get_data",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getList(
			@RequestParam(name="startTime",required=false) String startTime,
			@RequestParam(name="endTime",required=false) String endTime
			){
		Map<String, Object> ret = new HashMap<String, Object>();
		Map<String, Object> queryMap = new HashMap<String, Object>();
		queryMap.put("startTime", startTime);
		queryMap.put("endTime", endTime);
		List<Map<String, String>> stats = orderService.getStats(queryMap);
		ret.put("dataList", stats);
		ret.put("type", "success");
		return ret;
	}
	
	
	
	
}
