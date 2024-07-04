package com.project.hot.community.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.hot.community.model.dto.Community;

@Repository
public class CommunityDaoImpl implements CommunityDao {

	@Override
	public List<Community> getCommunities(SqlSession session) {
        return session.selectList("community.getCommunities");
    }

	@Override
	public int createCommunity(SqlSession session, Community community) {
        return session.insert("community.createCommunity", community);
    }

}
