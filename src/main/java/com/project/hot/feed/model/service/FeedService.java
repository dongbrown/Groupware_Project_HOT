package com.project.hot.feed.model.service;

import java.util.List;
import com.project.hot.feed.model.dto.Feed;

public interface FeedService {
    List<Feed> getFeeds(int communityNo);
    int insertFeed(Feed feed);
    int updateFeed(Feed feed);
    int deleteFeed(int feedNo);
}