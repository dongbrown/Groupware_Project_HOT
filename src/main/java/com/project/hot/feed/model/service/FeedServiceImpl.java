package com.project.hot.feed.model.service;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import com.project.hot.feed.model.dao.FeedDao;
import com.project.hot.feed.model.dto.Feed;
import com.project.hot.feed.model.dto.FeedComment;
import com.project.hot.feed.model.dto.FeedLike;

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
    @Transactional
    public int insertFeed(Feed feed, MultipartFile file) {
        return dao.insertFeed(feed, file, session);
    }

    @Override
    @Transactional
    public int updateFeed(Feed feed) {
        return dao.updateFeed(feed, session);
    }

    @Override
    @Transactional
    public int deleteFeed(int feedNo) {
        return dao.deleteFeed(feedNo, session);
    }

    @Override
    @Transactional
    public boolean toggleLike(int feedNo, int employeeNo) {
        FeedLike like = dao.getFeedLike(feedNo, employeeNo, session);
        if (like == null) {
            dao.insertFeedLike(feedNo, employeeNo, session);
            return true;
        } else {
            dao.deleteFeedLike(feedNo, employeeNo, session);
            return false;
        }
    }

    @Override
    public List<FeedComment> getComments(int feedNo) {
        return dao.getComments(feedNo, session);
    }

    @Override
    @Transactional
    public int addComment(FeedComment comment) {
        return dao.insertComment(comment, session);
    }
}