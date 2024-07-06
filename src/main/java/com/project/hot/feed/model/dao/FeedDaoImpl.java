package com.project.hot.feed.model.dao;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.project.hot.feed.model.dto.Feed;

@Repository
public class FeedDaoImpl implements FeedDao {
    @Override
    public List<Feed> getFeeds(SqlSession session, int communityNo) {
        return session.selectList("feed.getFeeds", communityNo);
    }

    @Override
    public int insertFeed(Feed feed, MultipartFile file, SqlSession session) {
        return session.insert("feed.insertFeed", feed);
    }

    @Override
    public int updateFeed(Feed feed, SqlSession session) {
        return session.update("feed.updateFeed", feed);
    }

    @Override
    public int deleteFeed(int feedNo, SqlSession session) {
        return session.delete("feed.deleteFeed", feedNo);
    }

}