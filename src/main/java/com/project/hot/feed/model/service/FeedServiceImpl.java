package com.project.hot.feed.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.project.hot.feed.model.dao.FeedDao;
import com.project.hot.feed.model.dto.Feed;

@Service
public class FeedServiceImpl implements FeedService {

    @Autowired
    private FeedDao dao;

    @Autowired
    private SqlSession session;

    @Override
    public List<Feed> getFeeds(int communityNo) {
        return dao.getFeeds(session, communityNo);
    }

    @Override
    public int insertFeed(Feed feed, MultipartFile file) {
        return dao.insertFeed(feed, file, session);
    }

    @Override
    public int updateFeed(Feed feed) {
        return dao.updateFeed(feed, session);
    }

    @Override
    public int deleteFeed(int feedNo) {
        return dao.deleteFeed(feedNo, session);
    }


}