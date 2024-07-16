package com.project.hot.community.model.service;

import java.util.List;
import java.util.Map;

import com.project.hot.community.model.dto.Community;
import com.project.hot.community.model.dto.CommunityUser;
import com.project.hot.employee.model.dto.Employee;

public interface CommunityService {

	List<Community> getCommunities(int employeeNo);

	void insertCommunity(Community community, CommunityUser communityUser);

	int toggleBookmark(int communityNo, int employeeNo);

	Community getCommunityByNo(int communityNo);

	int inviteParticipants(int communityNo, List<Map<String, Object>> participants);

	List<Community> getCommunityList();

	List<Employee> getNonParticipants(int communityNo);

	boolean joinCommunity(CommunityUser communityUser);


}
