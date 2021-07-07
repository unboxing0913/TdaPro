package org.unboxing.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class Notice_ReplyPageDTO {

	private int replyCnt;
	private List<Notice_ReplyVO> list;
}
