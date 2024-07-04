package com.project.hot.community.model.service;

import java.util.List;

import com.project.hot.community.model.dto.Community;

public interface CommunityService {

	List<Community> getCommunities();

	int createCommunity(Community community);

}
