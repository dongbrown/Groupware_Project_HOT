package com.project.hot.community.model.service;

import java.util.List;

import com.project.hot.community.model.dto.Community;
import com.project.hot.community.model.dto.CommunityUser;

public interface CommunityService {

	List<Community> getCommunities(int employeeNo);

	void insertCommunity(Community community, CommunityUser communityUser);

	int toggleBookmark(int communityNo, int employeeNo);

	Community getCommunityByNo(int communityNo);

}
