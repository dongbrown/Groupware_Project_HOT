package com.project.hot.feed.model.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.project.hot.feed.model.dto.Feed;
import com.project.hot.feed.model.dto.FeedComment;

public interface FeedService {
    List<Feed> getFeeds(int communityNo);
    int insertFeed(Feed feed, MultipartFile file);
    int updateFeed(Feed feed);
    int deleteFeed(int feedNo);
    boolean toggleLike(int feedNo, int employeeNo);
    List<FeedComment> getComments(int feedNo);
    int addComment(FeedComment comment);
	int updateComment(FeedComment comment);
	int deleteComment(int feedCommentNo);
}