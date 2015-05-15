package com.fuwei.constant;

import java.util.Calendar;
import java.util.Date;

public class Holiday {
	public static final MyDate[] holidays = { new MyDate(2015, 1, 1),
			new MyDate(2015,2,19), new MyDate(2015,2,20),
			new MyDate(2015,2,21), new MyDate(2015,4,5),
			new MyDate(2015,5,1), new MyDate(2015,6,20),
			new MyDate(2015,9,3), new MyDate(2015,9,27),
			new MyDate(2015,10,1), new MyDate(2015,10,2),
			new MyDate(2015,10,3) };


	public static int getHoliday(int year , int month) {
		int count = 0 ;
		for(MyDate date : holidays){
			if(date.getYear() == year && date.getMonth() == month){
				count++;
			}
		}
		return count;
	}

	public static int getHoliday(int year ,int month , Date leave_at){
		if(leave_at == null){
			return getHoliday(year,month);
		}
		int count = 0 ;
		Calendar cal = Calendar.getInstance();
		cal.setTime(leave_at);
		int leave_year = cal.get(Calendar.YEAR); 
		int leave_month = cal.get(Calendar.MONTH) + 1; 
		int leave_day = cal.get(Calendar.DAY_OF_MONTH); 
		
		if(leave_year != year || leave_month!=month){
			return getHoliday(year,month);
		}
		for(MyDate date : holidays){
			if(date.getYear() == year && date.getMonth() == month && leave_day>=date.getDay()){
				count++;
			}
		}
		return count;
	}
}

class MyDate {
	private Integer year;
	private int month;
	private int day;

	public MyDate(Integer year, int month, int day) {
		this.year = year;
		this.month = month;
		this.day = day;
	}

	public Integer getYear() {
		return year;
	}

	public void setYear(Integer year) {
		this.year = year;
	}

	public int getMonth() {
		return month;
	}

	public void setMonth(int month) {
		this.month = month;
	}

	public int getDay() {
		return day;
	}

	public void setDay(int day) {
		this.day = day;
	}

}
