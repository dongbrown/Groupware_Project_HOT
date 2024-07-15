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
	public void insertCommunity(SqlSession session, Community community) {
		session.insert("community.insertCommunity", community);
	}

	@Override
	public void insertCommunityUser(SqlSession session, CommunityUser communityUser) {
		session.insert("community.insertCommunityUser", communityUser);
	}

	@Override
	public int toggleBookmark(SqlSession session, int communityNo, int employeeNo) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("communityNo", communityNo);
		paramMap.put("employeeNo", employeeNo);
		return session.update("community.toggleBookmark", paramMap);
	}

	@Override
	public Community getCommunityByNo(SqlSession session, int communityNo) {
		return session.selectOne("community.getCommunityByNo", communityNo);
	}

    @Override
    public int inviteParticipants(SqlSession session, List<Map<String, Object>> participants, int communityNo) {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("list", participants);  // "participants" 대신 "list"를 사용
        paramMap.put("communityNo", communityNo);
        return session.insert("community.inviteParticipants", paramMap);
    }



}
