package org.unboxing.domain;

import lombok.Data;

@Data
public class CompletionAttachVO {
	private String uuid;
	private String uploadPath;
	private String fileName;
	private boolean fileType;

	private Long bno;
}
