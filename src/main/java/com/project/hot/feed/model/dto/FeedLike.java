package com.project.hot.feed.model.dto;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class FeedLike {

	private int feedLikeNo;
	private int employeeNo;
	private int feedNo;

}
