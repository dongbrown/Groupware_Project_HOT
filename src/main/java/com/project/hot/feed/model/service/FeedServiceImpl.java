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
        try {
            FeedLike existingLike = dao.getFeedLike(feedNo, employeeNo, session);
            System.out.println(existingLike);
            if (existingLike == null) {
                // 좋아요가 없는 경우 추가
                dao.insertFeedLike(feedNo, employeeNo, session);
                return true; // 좋아요 추가됨
            } else {
                // 좋아요가 이미 있는 경우 삭제
                dao.deleteFeedLike(feedNo, employeeNo, session);
                return false; // 좋아요 삭제됨
            }
        } catch (Exception e) {
            throw new RuntimeException("좋아요 처리 중 오류가 발생했습니다.", e);
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