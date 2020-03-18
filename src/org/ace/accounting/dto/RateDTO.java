package org.ace.accounting.dto;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.ace.accounting.system.chartaccount.ChartOfAccount;

public class RateDTO {
	private String accCode;

	private String accName;

	private BigDecimal homeAmount;

	private BigDecimal monthlyAmount;

	private BigDecimal difference;

	private int reportMonth;

	private String currencyId;

	private String branchId;

	private String currencyCode;

	private String branchName;

	private List<ChartOfAccount> coaList;

	public RateDTO() {
		super();
	}

	public RateDTO(String accCode, String accName, BigDecimal homeAmount, double monthlyAmount, String currencyCode, String branchName) {
		super();
		this.accCode = accCode;
		this.accName = accName;
		this.homeAmount = homeAmount;
		this.monthlyAmount = BigDecimal.valueOf(monthlyAmount);
		this.difference = homeAmount.subtract(BigDecimal.valueOf(monthlyAmount));
		this.currencyCode = currencyCode;
		this.branchName = branchName;
	}

	public BigDecimal getHomeAmount() {
		return homeAmount;
	}

	public void setHomeAmount(BigDecimal homeAmount) {
		this.homeAmount = homeAmount;
	}

	public BigDecimal getMonthlyAmount() {
		return monthlyAmount;
	}

	public void setMonthlyAmount(BigDecimal monthlyAmount) {
		this.monthlyAmount = monthlyAmount;
	}

	public BigDecimal getDifference() {
		return difference;
	}

	public void setDifference(BigDecimal difference) {
		this.difference = difference;
	}

	public int getReportMonth() {
		return reportMonth;
	}

	public void setReportMonth(int reportMonth) {
		this.reportMonth = reportMonth;
	}

	public List<ChartOfAccount> getCoaList() {
		if (coaList == null) {
			coaList = new ArrayList<ChartOfAccount>();
		}
		return coaList;
	}

	public void setCoaList(List<ChartOfAccount> coaList) {
		this.coaList = coaList;
	}

	public String getCurrencyId() {
		return currencyId;
	}

	public void setCurrencyId(String currencyId) {
		this.currencyId = currencyId;
	}

	public String getBranchId() {
		return branchId;
	}

	public void setBranchId(String branchId) {
		this.branchId = branchId;
	}

	public String getCurrencyCode() {
		return currencyCode;
	}

	public void setCurrencyCode(String currencyCode) {
		this.currencyCode = currencyCode;
	}

	public String getBranchName() {
		return branchName;
	}

	public void setBranchName(String branchName) {
		this.branchName = branchName;
	}

	public String getAccCode() {
		return accCode;
	}

	public void setAccCode(String accCode) {
		this.accCode = accCode;
	}

	public String getAccName() {
		return accName;
	}

	public void setAccName(String accName) {
		this.accName = accName;
	}

}
