package com.project.hot.community.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.hot.community.model.dto.Community;
import com.project.hot.community.model.dto.CommunityUser;

@Repository
public class CommunityDaoImpl implements CommunityDao {

	@Override
	public List<Community> getCommunities(SqlSession session, int employeeNo) {
		return session.selectList("community.getCommunities", employeeNo);
	}

	@Override
	public int insertCommunity(SqlSession session, Community community, CommunityUser cu) {
		return session.insert("community.insertCommunity", community);
	}

	@Override
	public int toggleBookmark(SqlSession session, int communityNo, int employeeNo) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("communityNo", communityNo);
		paramMap.put("employeeNo", employeeNo);
		return session.update("community.toggleBookmark", paramMap);
	}

}
