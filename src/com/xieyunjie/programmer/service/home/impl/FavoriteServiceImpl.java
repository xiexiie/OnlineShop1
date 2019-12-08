package com.xieyunjie.programmer.service.home.impl;
/**
 * 收藏接口实现类
 */
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xieyunjie.programmer.dao.home.FavoriteDao;
import com.xieyunjie.programmer.entity.home.Favorite;
import com.xieyunjie.programmer.service.home.FavoriteService;
@Service
public class FavoriteServiceImpl implements FavoriteService {

	@Autowired
	private FavoriteDao favoriteDao;
	
	@Override
	public int add(Favorite favorite) {
		// TODO Auto-generated method stub
		return favoriteDao.add(favorite);
	}

	@Override
	public int delete(Long id) {
		// TODO Auto-generated method stub
		return favoriteDao.delete(id);
	}

	@Override
	public List<Favorite> findList(Map<String, Object> queMap) {
		// TODO Auto-generated method stub
		return favoriteDao.findList(queMap);
	}

	@Override
	public Integer getTotal(Map<String, Object> queryMap) {
		// TODO Auto-generated method stub
		return favoriteDao.getTotal(queryMap);
	}

	@Override
	public Favorite findById(Long id) {
		// TODO Auto-generated method stub
		return favoriteDao.findById(id);
	}

	@Override
	public Favorite findByIds(Map<String, Long> queryMap) {
		// TODO Auto-generated method stub
		return favoriteDao.findByIds(queryMap);
	}

}
