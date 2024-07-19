package com.project.hot.feed.model.dao;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;
import com.project.hot.feed.model.dto.Feed;
import com.project.hot.feed.model.dto.FeedComment;
import com.project.hot.feed.model.dto.FeedLike;

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

    @Override
    public FeedLike getFeedLike(int feedNo, int employeeNo, SqlSession session) {
        return session.selectOne("feed.getFeedLike", new FeedLike(0, employeeNo, feedNo));
    }

    @Override
    public void insertFeedLike(int feedNo, int employeeNo, SqlSession session) {
        session.insert("feed.insertFeedLike", new FeedLike(0, employeeNo, feedNo));
    }

    @Override
    public void deleteFeedLike(int feedNo, int employeeNo, SqlSession session) {
        session.delete("feed.deleteFeedLike", new FeedLike(0, employeeNo, feedNo));
    }

    @Override
    public List<FeedComment> getComments(int feedNo, SqlSession session) {
        return session.selectList("feed.getComments", feedNo);
    }

    @Override
    public int insertComment(FeedComment comment, SqlSession session) {
        return session.insert("feed.insertComment", comment);
    }
}