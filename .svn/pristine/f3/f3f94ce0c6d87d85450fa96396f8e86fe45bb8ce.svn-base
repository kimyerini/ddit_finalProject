package kr.or.ddit.util;

import java.util.List;

// 페이지 관련 정보 + 게시글 데이터
public class ArticlePage<T> {

	private int total; // 전체 글 수
	private int currentPage; // 현재 페이지 번호
	private int totalPages; // 전체 페이지 수
	private int startPage; // 시작 페이지 번호
	private int size; // 한 화면에 보여질 행의 수(기본은 10행)
	private int endPage; // 종료 페이지 번호
	private List<T> content; // 데이터
	private String searchType; // 검색타입 (제목, 작성자 등)
	
	// 생성자(Constructor): 페이징 정보를 생성
	public ArticlePage(int total, int currentPage, int size, List<T> content) {
		// size: 한 화면에 보여질 목록의 행 수
		this.total = total;
		this.currentPage = currentPage;
		this.content = content;
		this.size = size;
		
		// 전체 글 수가 0인 경우
		if(total == 0) {
			totalPages = 0; // [1][2][3]..[14]
			startPage = 0;
			endPage = 0;
		} else { // 글이 존재하는 경우
			// 전체 페이지 수(totalPages) = 전체 글 수(total) / 한 화면에 보여질 목록의 행 수(size)
			totalPages = this.total / size;

			// 전체글 수(total) % 한 화면에 보여질 목록의 행 수(size) != 0이면 페이지를 1 증가
			if(total % size > 0) {
				totalPages++;
			}

			// 시작페이지를 구하는 공식: 시작페이지 = 현재페이지 / 페이지크기 * 페이지크기 + 1 (int값이므로 나머지는 버림)
			/* 페이지크기: 한 화면에서 선택 가능한 페이지 넘버의 개수(ex. << 1 2 3 4 5 >> 에서 페이지크기는 5),
						currentPage를 클릭할 때마다 출력되는 페이지 넘버가 변경되는 공식 */
			startPage = this.currentPage / 5 * 5 + 1;
			
			// 현재페이지 % 페이지크기 == 0일 때 보정
			if(currentPage % 5 == 0) {
				// 페이지크기를 빼줌
				startPage -= 5;
			}
			
			// 종료페이지를 구하는 공식: 시작페이지 번호 + (페이지 크기 - 1)
			endPage = startPage + (5-1);
			
			// (종료페이지 번호 > 전체페이지 번호)인 경우
			if(endPage > totalPages) {
				endPage = totalPages;
			}
			
		} // end if
	} // end constructor
		
		// getter, setter
		public int getTotal() {
			return total;
		}
		
		public void setTotal(int total) {
			this.total = total;
		}
		
		public int getCurrentPage() {
			return currentPage;
		}
		
		public void setCurrentPage(int currentPage) {
			this.currentPage = currentPage;
		}
		
		public int getTotalPages() {
			return totalPages;
		}
		
		public void setTotalPages(int totalPages) {
			this.totalPages = totalPages;
		}
		
		public int getStartPage() {
			return startPage;
		}
		
		public void setStartPage(int startPage) {
			this.startPage = startPage;
		}
		
		public int getEndPage() {
			return endPage;
		}
		
		public void setEndPage(int endPage) {
			this.endPage = endPage;
		}
		
		public List<T> getContent() {
			return content;
		}
		
		public void setContent(List<T> content) {
			this.content = content;
		}
		
		public int getSize() {
			return size;
		}

		public void setSize(int size) {
			this.size = size;
		}

		// 데이터가 없는 경우: 전체 글의 수는 0 => TRUE 리턴
		public boolean hasNoArticles() {
			return total == 0;
		}
		
		// 데이터가 있는 경우: TRUE를 리턴
		public boolean hasArticles() {
			return total > 0;
		}

}
