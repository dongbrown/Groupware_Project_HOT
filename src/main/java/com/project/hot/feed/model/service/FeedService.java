package com.project.hot.feed.model.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.project.hot.feed.model.dto.Feed;

public interface FeedService {
    List<Feed> getFeeds(int communityNo);
    int insertFeed(Feed feed, MultipartFile file);
    int updateFeed(Feed feed);
    int deleteFeed(int feedNo);
}