package com.project.hot.feed.model.dao;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.web.multipart.MultipartFile;

import com.project.hot.feed.model.dto.Feed;

public interface FeedDao {
    List<Feed> getFeeds(SqlSession session, int communityNo);
    int insertFeed(Feed feed, MultipartFile file, SqlSession session);
    int updateFeed(Feed feed, SqlSession session);
    int deleteFeed(int feedNo, SqlSession session);

}