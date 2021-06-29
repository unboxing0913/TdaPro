package org.unboxing.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class Review_ReplyPageDTO {

	private int replyCnt;
	private List<Review_ReplyVO> list;
}
