package org.ace.accounting.system.tlf.persistence;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.NoResultException;
import javax.persistence.PersistenceException;
import javax.persistence.Query;

import org.ace.accounting.common.VoucherType;
import org.ace.accounting.common.utils.BusinessUtil;
import org.ace.accounting.dto.EditVoucherDto;
import org.ace.accounting.dto.RateDTO;
import org.ace.accounting.system.chartaccount.ChartOfAccount;
import org.ace.accounting.system.tlf.TLF;
import org.ace.accounting.system.tlf.persistence.interfaces.ITLFDAO;
import org.ace.accounting.system.trantype.TranType;
import org.ace.java.component.persistence.BasicDAO;
import org.ace.java.component.persistence.exception.DAOException;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Repository("TLFDAO")
public class TLFDAO extends BasicDAO implements ITLFDAO {

	@SuppressWarnings("unchecked")
	@Transactional(propagation = Propagation.REQUIRED)
	public List<TLF> findAll() throws DAOException {
		List<TLF> result = null;
		try {
			Query q = em.createNamedQuery("TLF.findAll");
			result = q.getResultList();
			em.flush();
		} catch (PersistenceException pe) {
			throw translate("Failed to find all of TLF", pe);
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	@Transactional(propagation = Propagation.REQUIRED)
	public List<RateDTO> findRateList(RateDTO ratedto) throws DAOException {
		List<RateDTO> result = new ArrayList<RateDTO>();
		Map<String, String> param = new HashMap<String, String>();
		try {
			StringBuffer query = new StringBuffer();
			query.append("SELECT NEW " + RateDTO.class.getName());
			query.append("(c.acCode,c.acName,sum(t.homeAmount),sum(t.localAmount)*(case when (t.currency.isHomeCur=true) then 1.0000 else t.currency."
					+ BusinessUtil.getMonthlyRateFormula(ratedto.getReportMonth() + 1));
			query.append(" end),t.currency.currencyCode,t.branch.name)");
			query.append(" FROM TLF t left join t.ccoa a left join a.coa c where FUNC('MONTH', t.settlementDate)=:month");
			if (ratedto.getCurrencyId() != null) {
				query.append(" and t.currency.id=:currencyId");
			}
			if (ratedto.getBranchId() != null) {
				query.append(" and t.branch.id=:branchId");
			}
			if (ratedto.getCoaList().size() > 0) {
				int i = 0;
				for (ChartOfAccount coa : ratedto.getCoaList()) {
					i += 1;
					param.put("id" + i, coa.getId());
					if (ratedto.getCoaList().get(0).equals(coa)) {
						query.append(" and c.id=:id" + i);
					} else {
						query.append(" or c.id=:id" + i);
					}
				}
			}
			query.append(" group by c.acCode,c.acName,t.currency.currencyCode,t.branch.name,t.currency.isHomeCur");
			query.append(" ,t.currency." + BusinessUtil.getMonthlyRateFormula(ratedto.getReportMonth() + 1));
			Query q = em.createQuery(query.toString());
			q.setParameter("month", ratedto.getReportMonth() + 1);
			if (ratedto.getCurrencyId() != null) {
				q.setParameter("currencyId", ratedto.getCurrencyId());
			}
			if (ratedto.getBranchId() != null) {
				q.setParameter("branchId", ratedto.getBranchId());
			}
			if (ratedto.getCoaList().size() > 0) {
				for (String key : param.keySet()) {
					q.setParameter(key, param.get(key));
				}
			}
			result = q.getResultList();
			em.flush();
		} catch (NoResultException nre) {
			return null;
		} catch (PersistenceException pe) {
			throw translate("Failed to find tlf data: ", pe);
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	@Transactional(propagation = Propagation.REQUIRED)
	public List<String> findVoucherNoByBranchIdAndVoucherType(String branchId, VoucherType voucherType) throws DAOException {
		List<String> result = null;
		try {
			Query q = em.createNamedQuery("TLF.findVoucherNoByBranchId");
			q.setParameter("branchId", branchId);
			if (voucherType.equals(VoucherType.CASH)) {
				q.setParameter("status", "C%");
			} else {
				q.setParameter("status", "T%");
			}
			q.setParameter("eNo", "VOC%");
			result = q.getResultList();
			em.flush();
		} catch (PersistenceException pe) {
			throw translate("Failed to find all of Voucher No by " + branchId, pe);
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	@Transactional(propagation = Propagation.REQUIRED)
	public List<TLF> findVoucherListByReverseZero(String voucherNo) throws DAOException {
		List<TLF> result = null;
		try {
			Query q = em.createNamedQuery("TLF.findVoucherListByVoucherNo");
			q.setParameter("voucherNo", voucherNo);
			result = q.getResultList();
			em.flush();
		} catch (PersistenceException pe) {
			throw translate("Failed to find VoucherListByReverseZero", pe);
		}
		return result;
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public TranType findCashAccountByVoucherNo(String voucherNo) throws DAOException {
		TranType result = null;
		EditVoucherDto dto = null;
		try {
			Query q = em.createNamedQuery("TLF.findCashAccountByVoucherNo");
			q.setParameter("voucherNo", voucherNo);
			q.setMaxResults(1);
			dto = (EditVoucherDto) q.getSingleResult();
			em.flush();
			if (dto != null) {
				result = dto.getTranType();
			}
		} catch (NoResultException e) {
			return null;
		} catch (PersistenceException pe) {
			throw translate("Failed to find CashAccountByVoucherNo", pe);
		}
		return result;
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public void updateReverseByID(String id, boolean reverse) throws DAOException {
		try {
			Query q = em.createNamedQuery("TLF.updateReverseByID");
			q.setParameter("id", id);
			q.setParameter("reverse", reverse);
			q.executeUpdate();
		} catch (PersistenceException pe) {
			throw translate("Failed to update ReverseByID " + id, pe);
		}
	}

}
