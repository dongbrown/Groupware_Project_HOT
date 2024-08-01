package com.project.hot.common.exception;

import java.io.Serializable;

import lombok.Getter;

@Getter
public class ChattingException extends RuntimeException implements Serializable{

	private static final long serialVersionUID = -8747136460700387775L;

	public ChattingException(String errorMsg) {
		super(errorMsg);
	}

}
                 