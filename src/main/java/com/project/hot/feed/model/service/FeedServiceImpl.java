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
            System.out.println(feedNo + employeeNo); //feedNo가 null
            System.out.println(existingLike); //
            if (existingLike != null) {
                // 좋아요가 이미 존재하면 삭제
                int result = dao.deleteFeedLike(feedNo, employeeNo, session);
                return result > 0 ? false : true; // 삭제 성공 시 false 반환 (좋아요 취소됨)
            } else {
                // 좋아요가 없으면 추가
                int result = dao.insertFeedLike(feedNo, employeeNo, session);
                return result > 0 ? true : false; // 추가 성공 시 true 반환 (좋아요 추가됨)
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("좋아요 토글 중 오류 발생", e);
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

	@Override
	public int updateComment(FeedComment comment) {
		return dao.updateComment(comment, session);
	}

	@Override
	public int deleteComment(int feedCommentNo) {
		return dao.deleteComment(feedCommentNo, session);
	}
}