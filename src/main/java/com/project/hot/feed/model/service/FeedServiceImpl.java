package com.project.hot.feed.model.service;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.project.hot.feed.model.dao.FeedDao;
import com.project.hot.feed.model.dto.Feed;

@Service
public class FeedServiceImpl implements FeedService {

    @Autowired
    private FeedDao dao;

    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<Feed> getFeeds(int communityNo) {
        return dao.getFeeds(sqlSession, communityNo);
    }

    @Override
    public int insertFeed(Feed feed) {
        return dao.insertFeed(feed, sqlSession);
    }

    @Override
    public int updateFeed(Feed feed) {
        return dao.updateFeed(feed, sqlSession);
    }

    @Override
    public int deleteFeed(int feedNo) {
        return dao.deleteFeed(feedNo, sqlSession);
    }
}