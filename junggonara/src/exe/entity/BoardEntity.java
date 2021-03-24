package exe.entity;

import java.sql.Date;

public class BoardEntity {
	private int	br_num;
	private int	mb_id;
	private String br_title;
	private String bk_code;
	private String br_content;
	private int	br_price;
	private String sale_purchase;
	private String purchase_done;	//default 'X'
	private int	hit;				//default 0
	private Date write_date;
	private String upFile;
	private String dept_code;
	private String time;
	public int getBr_num() {
		return br_num;
	}
	public void setBr_num(int br_num) {
		this.br_num = br_num;
	}
	public int getMb_id() {
		return mb_id;
	}
	public void setMb_id(int mb_id) {
		this.mb_id = mb_id;
	}
	public String getBr_title() {
		return br_title;
	}
	public void setBr_title(String br_title) {
		this.br_title = br_title;
	}
	public String getBk_code() {
		return bk_code;
	}
	public void setBk_code(String bk_code) {
		this.bk_code = bk_code;
	}
	public String getBr_content() {
		return br_content;
	}
	public void setBr_content(String br_content) {
		this.br_content = br_content;
	}
	public int getBr_price() {
		return br_price;
	}
	public void setBr_price(int br_price) {
		this.br_price = br_price;
	}
	public String getSale_purchase() {
		return sale_purchase;
	}
	public void setSale_purchase(String sale_purchase) {
		this.sale_purchase = sale_purchase;
	}
	public String getPurchase_done() {
		return purchase_done;
	}
	public void setPurchase_done(String purchase_done) {
		this.purchase_done = purchase_done;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}

	public Date getWrite_date() {
		return write_date;
	}
	public void setWrite_date(Date write_date) {
		this.write_date = write_date;
	}
	public String getUpFile() {
		return upFile;
	}
	public void setUpFile(String upFile) {
		this.upFile = upFile;
	}
	public String getDept_code() {
		return dept_code;
	}
	public void setDept_code(String dept_code) {
		this.dept_code = dept_code;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	
}
