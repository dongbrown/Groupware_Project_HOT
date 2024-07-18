package com.project.hot.community.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.project.hot.community.model.dto.Community;
import com.project.hot.community.model.dto.CommunityUser;
import com.project.hot.employee.model.dto.Employee;

public interface CommunityDao {

	List<Community> getCommunities(SqlSession session, int employeeNo);

	void insertCommunity(SqlSession session, Community community);

	void insertCommunityUser(SqlSession session, CommunityUser communityUser);

	int toggleBookmark(SqlSession session, int communityNo, int employeeNo);

	Community getCommunityByNo(SqlSession session, int communityNo);

	int inviteParticipants(SqlSession session, List<Map<String, Object>> participants, int communityNo);

	List<Community> getCommunityList(SqlSession session);

	List<Employee> getNonParticipants(SqlSession session, int communityNo);

	int joinCommunity(SqlSession session, CommunityUser communityUser);

	int deleteCommunityUser(SqlSession session, int communityNo, int employeeNo);

    List<Community> getCommunitiesWithEmployeePhotos(SqlSession session);



}
