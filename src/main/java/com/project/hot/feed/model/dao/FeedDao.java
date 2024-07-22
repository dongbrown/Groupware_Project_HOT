package com.project.hot.feed.model.dao;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.web.multipart.MultipartFile;
import com.project.hot.feed.model.dto.Feed;
import com.project.hot.feed.model.dto.FeedComment;
import com.project.hot.feed.model.dto.FeedLike;

public interface FeedDao {
    List<Feed> getFeeds(SqlSession session, int communityNo);
    int insertFeed(Feed feed, MultipartFile file, SqlSession session);
    int updateFeed(Feed feed, SqlSession session);
    int deleteFeed(int feedNo, SqlSession session);
    FeedLike getFeedLike(int feedNo, int employeeNo, SqlSession session);
    int insertFeedLike(int feedNo, int employeeNo, SqlSession session);
    int deleteFeedLike(int feedNo, int employeeNo, SqlSession session);
    List<FeedComment> getComments(int feedNo, SqlSession session);
    int insertComment(FeedComment comment, SqlSession session);
	int updateComment(FeedComment comment, SqlSession session);
	int deleteComment(int feedCommentNo, SqlSession session);
}