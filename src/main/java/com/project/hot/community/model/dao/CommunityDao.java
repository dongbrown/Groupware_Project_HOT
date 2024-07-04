package com.project.hot.community.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.project.hot.community.model.dto.Community;

public interface CommunityDao {

	List<Community> getCommunities(SqlSession session);

	int createCommunity(SqlSession session, Community community);

}
