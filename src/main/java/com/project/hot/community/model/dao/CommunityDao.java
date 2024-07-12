package com.project.hot.community.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.project.hot.community.model.dto.Community;
import com.project.hot.community.model.dto.CommunityUser;

public interface CommunityDao {

	List<Community> getCommunities(SqlSession session, int employeeNo);

	void insertCommunity(SqlSession session, Community community);

	void insertCommunityUser(SqlSession session, CommunityUser communityUser);

	int toggleBookmark(SqlSession session, int communityNo, int employeeNo);

	Community getCommunityByNo(SqlSession session, int communityNo);



}
