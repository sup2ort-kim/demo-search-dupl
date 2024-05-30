package com.demo.search.util;

public class IndexData {
    private String title;
    private String text;
    private String frst_regist_pnttm;
    private String author;
    private String call_number_permanent;
    private String clct_url;
    private String cover;
    private String dcc_major;
    private String dcc_middle;
    private String dcc_small;
    private String description;
    private String description2;
    private String doc_id;
    private String is_ebook;
    private String is_modified;
    private String is_paper_book;
    private String isbn;
    private String isbn2;
    private String issn;
    private String language_code;
    private String last_updt_pnttm;
    private String local_param_04;
    private String local_param_06;
    private String mms_id;
    private String publication_date;
    private String publisher;
    private String receiving_date;
    private String subjects;
    private String title_choseong;
    private String title_hantoeng;
    private String[] title_vector;
    private String toc;
    
    public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getCall_number_permanent() {
		return call_number_permanent;
	}

	public void setCall_number_permanent(String call_number_permanent) {
		this.call_number_permanent = call_number_permanent;
	}

	public String getClct_url() {
		return clct_url;
	}

	public void setClct_url(String clct_url) {
		this.clct_url = clct_url;
	}

	public String getCover() {
		return cover;
	}

	public void setCover(String cover) {
		this.cover = cover;
	}

	public String getDcc_major() {
		return dcc_major;
	}

	public void setDcc_major(String dcc_major) {
		this.dcc_major = dcc_major;
	}

	public String getDcc_middle() {
		return dcc_middle;
	}

	public void setDcc_middle(String dcc_middle) {
		this.dcc_middle = dcc_middle;
	}

	public String getDcc_small() {
		return dcc_small;
	}

	public void setDcc_small(String dcc_small) {
		this.dcc_small = dcc_small;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getDescription2() {
		return description2;
	}

	public void setDescription2(String description2) {
		this.description2 = description2;
	}

	public String getDoc_id() {
		return doc_id;
	}

	public void setDoc_id(String doc_id) {
		this.doc_id = doc_id;
	}

	public String getIs_ebook() {
		return is_ebook;
	}

	public void setIs_ebook(String is_ebook) {
		this.is_ebook = is_ebook;
	}

	public String getIs_modified() {
		return is_modified;
	}

	public void setIs_modified(String is_modified) {
		this.is_modified = is_modified;
	}

	public String getIs_paper_book() {
		return is_paper_book;
	}

	public void setIs_paper_book(String is_paper_book) {
		this.is_paper_book = is_paper_book;
	}

	public String getIsbn() {
		return isbn;
	}

	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}

	public String getIsbn2() {
		return isbn2;
	}

	public void setIsbn2(String isbn2) {
		this.isbn2 = isbn2;
	}

	public String getIssn() {
		return issn;
	}

	public void setIssn(String issn) {
		this.issn = issn;
	}

	public String getLanguage_code() {
		return language_code;
	}

	public void setLanguage_code(String language_code) {
		this.language_code = language_code;
	}

	public String getLast_updt_pnttm() {
		return last_updt_pnttm;
	}

	public void setLast_updt_pnttm(String last_updt_pnttm) {
		this.last_updt_pnttm = last_updt_pnttm;
	}

	public String getLocal_param_04() {
		return local_param_04;
	}

	public void setLocal_param_04(String local_param_04) {
		this.local_param_04 = local_param_04;
	}

	public String getLocal_param_06() {
		return local_param_06;
	}

	public void setLocal_param_06(String local_param_06) {
		this.local_param_06 = local_param_06;
	}

	public String getMms_id() {
		return mms_id;
	}

	public void setMms_id(String mms_id) {
		this.mms_id = mms_id;
	}

	public String getPublication_date() {
		return publication_date;
	}

	public void setPublication_date(String publication_date) {
		this.publication_date = publication_date;
	}

	public String getPublisher() {
		return publisher;
	}

	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}

	public String getReceiving_date() {
		return receiving_date;
	}

	public void setReceiving_date(String receiving_date) {
		this.receiving_date = receiving_date;
	}

	public String getSubjects() {
		return subjects;
	}

	public void setSubjects(String subjects) {
		this.subjects = subjects;
	}

	public String getTitle_choseong() {
		return title_choseong;
	}

	public void setTitle_choseong(String title_choseong) {
		this.title_choseong = title_choseong;
	}

	public String getTitle_hantoeng() {
		return title_hantoeng;
	}

	public void setTitle_hantoeng(String title_hantoeng) {
		this.title_hantoeng = title_hantoeng;
	}

	public String[] getTitle_vector() {
		return title_vector;
	}

	public void setTitle_vector(String[] title_vector) {
		this.title_vector = title_vector;
	}

	public String getToc() {
		return toc;
	}

	public void setToc(String toc) {
		this.toc = toc;
	}

	public IndexData() {}
    
    public IndexData(String title, String text) {
        this.title = title;
        this.text = text;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    @Override
    public String toString() {
        return String.format("IndexData{title='%s', text='%s'}", title, text);
    }

	public String getFrst_regist_pnttm() {
		return frst_regist_pnttm;
	}

	public void setFrst_regist_pnttm(String frst_regist_pnttm) {
		this.frst_regist_pnttm = frst_regist_pnttm;
	}
    
}
