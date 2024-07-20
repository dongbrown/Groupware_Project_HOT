package com.project.hot.feed.model.dto;

import java.sql.Date;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Feed {
    private int feedNo;
    private String feedContent;
    private Date feedEnrollDate;
    private int communityNo;
    private int employeeNo;
    private String originalFileName;
    private String renamedFileName;
    private String employeeName;
    // 이미지 존재 여부를 나타내는 플래그 -> 프론트에서 이미지 표시 여부 결정에 유용
    private boolean hasImage;
    private int likeCount;
    private int commentCount;
    private boolean isLiked;

}