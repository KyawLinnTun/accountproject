package org.ace.accounting.web.system;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.EnumSet;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Stream;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;

import org.ace.accounting.common.CurrencyType;
import org.ace.accounting.common.MonthNames;
import org.ace.accounting.common.PropertiesManager;
import org.ace.accounting.common.utils.DateUtils;
import org.ace.accounting.common.validation.MessageId;
import org.ace.accounting.dto.MonthlyRateDto;
import org.ace.accounting.dto.RateDTO;
import org.ace.accounting.dto.VoucherDTO;
import org.ace.accounting.process.interfaces.IUserProcessService;
import org.ace.accounting.system.branch.Branch;
import org.ace.accounting.system.branch.service.interfaces.IBranchService;
import org.ace.accounting.system.chartaccount.ChartOfAccount;
import org.ace.accounting.system.chartaccount.service.interfaces.ICoaService;
import org.ace.accounting.system.currency.Currency;
import org.ace.accounting.system.currency.service.interfaces.ICurrencyService;
import org.ace.accounting.system.tlf.service.interfaces.ITLFService;
import org.ace.java.component.SystemException;
import org.ace.java.component.service.interfaces.IDataRepService;
import org.ace.java.web.common.BaseBean;
import org.apache.commons.io.FileUtils;
import org.primefaces.model.DefaultStreamedContent;
import org.primefaces.model.DefaultTreeNode;
import org.primefaces.model.StreamedContent;
import org.primefaces.model.TreeNode;

import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.engine.xml.JRXmlLoader;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.export.SimpleXlsReportConfiguration;

@ManagedBean(name = "RateMonthlyCurActionBean")
@ViewScoped
public class RateMonthlyCurActionBean extends BaseBean {

	@ManagedProperty(value = "#{CurrencyService}")
	private ICurrencyService currencyService;

	public void setCurrencyService(ICurrencyService currencyService) {
		this.currencyService = currencyService;
	}

	@ManagedProperty(value = "#{TLFService}")
	private ITLFService tlfService;

	public void setTlfService(ITLFService tlfService) {
		this.tlfService = tlfService;
	}

	@ManagedProperty(value = "#{DataRepService}")
	private IDataRepService<Currency> dataRepService;

	public void setDataRepService(IDataRepService<Currency> dataRepService) {
		this.dataRepService = dataRepService;
	}

	@ManagedProperty(value = "#{UserProcessService}")
	private IUserProcessService userProcessService;

	public void setUserProcessService(IUserProcessService userProcessService) {
		this.userProcessService = userProcessService;
	}

	@ManagedProperty(value = "#{PropertiesManager}")
	private PropertiesManager propertiesManager;

	public void setPropertiesManager(PropertiesManager propertiesManager) {
		this.propertiesManager = propertiesManager;
	}

	@ManagedProperty(value = "#{CoaService}")
	private ICoaService coaService;

	public void setCoaService(ICoaService coaService) {
		this.coaService = coaService;
	}

	@ManagedProperty(value = "#{BranchService}")
	private IBranchService branchService;

	public void setBranchService(IBranchService branchService) {
		this.branchService = branchService;
	}

	private MonthlyRateDto currency;
	private List<MonthlyRateDto> currencyList;
	private VoucherDTO voucherDto;
	private RateDTO ratedto;
	private List<RateDTO> rateList;
	private EnumSet<MonthNames> monthSet;
	private List<Currency> currencyListValue;

	private List<ChartOfAccount> coaList;
	private TreeNode root;
	private TreeNode[] selectedNodes;
	private final String reportName = "rateDifferentReport";
	private final String pdfDirPath = "/pdf-report/" + reportName + "/" + System.currentTimeMillis() + "/";
	private final String dirPath = getWebRootPath() + pdfDirPath;
	private final String fileName = reportName;

	@PostConstruct
	public void init() {
		ratedto = new RateDTO();
		rateList = new ArrayList<>();
		currencyListValue = new ArrayList<>();
		monthSet = EnumSet.allOf(MonthNames.class);
		root = new DefaultTreeNode("Root", null);
		selectedNodes = null;
		rebindData();
	}

	private void rebindData() {
		currencyList = currencyService.findForeignCurrencyDto();
		currencyListValue = currencyService.findAllCurrency();
		coaList = coaService.findAllCoaByAccountCodeType();
		TreeNode node = new DefaultTreeNode("ChartOfAccount", root);
		coaList.forEach(coa -> {
			node.getChildren().add(new DefaultTreeNode(coa, root));
		});
	}

	public void deleteCurrency(MonthlyRateDto currency) {
		currency.setAllZero();
	}

	public void deleteAllCurrency() {
		for (MonthlyRateDto cur : currencyList) {
			cur.setAllZero();
		}
	}

	public void search() {
		ratedto.setCoaList(new ArrayList<>());
		if (selectedNodes != null) {
			selectedNodes = Stream.of(selectedNodes).filter(node -> !node.getData().equals("ChartOfAccount")).toArray(TreeNode[]::new);
			for (TreeNode node : selectedNodes) {
				ratedto.getCoaList().add((ChartOfAccount) node.getData());
			}
		}
		rateList = tlfService.findRateTLF(ratedto);
	}

	public void generateReport() {
		try {
			InputStream inputStream = Thread.currentThread().getContextClassLoader().getResourceAsStream("rateDifferentReport.jrxml");
			Map<String, Object> parameters = new HashMap<String, Object>();
			parameters.put("reportDate", DateUtils.formatDateToString(new Date()));
			String image = FacesContext.getCurrentInstance().getExternalContext().getRealPath(propertiesManager.getProperties("LOGO"));
			parameters.put("logoPath", image);
			parameters.put("records", rateList.size());
			parameters.put("RATELIST", new JRBeanCollectionDataSource(rateList));
			JasperDesign jasperDesign = JRXmlLoader.load(inputStream);
			JasperReport jasperReport = JasperCompileManager.compileReport(jasperDesign);
			JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, new JREmptyDataSource());
			FileUtils.forceMkdir(new File(dirPath));
			JasperExportManager.exportReportToPdfFile(jasperPrint, dirPath + fileName.concat(".pdf"));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public StreamedContent getDownloadValue() {
		try {
			InputStream inputStream = Thread.currentThread().getContextClassLoader().getResourceAsStream("rateDifferentReport.jrxml");
			Map<String, Object> parameters = new HashMap<String, Object>();
			parameters.put("reportDate", DateUtils.formatDateToString(new Date()));
			String image = FacesContext.getCurrentInstance().getExternalContext().getRealPath(propertiesManager.getProperties("LOGO"));
			parameters.put("logoPath", image);
			parameters.put("RATELIST", new JRBeanCollectionDataSource(rateList));

			JasperDesign jasperDesign = JRXmlLoader.load(inputStream);
			JasperReport jasperReport = JasperCompileManager.compileReport(jasperDesign);

			JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, new JRBeanCollectionDataSource(rateList));

			FileUtils.forceMkdir(new File(dirPath));

			File destFile = new File(dirPath + fileName.concat(".xls"));

			JRXlsExporter exporter = new JRXlsExporter();

			exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
			exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(destFile));
			SimpleXlsReportConfiguration configuration = new SimpleXlsReportConfiguration();
			configuration.setOnePagePerSheet(false);
			configuration.setAutoFitPageHeight(true);
			configuration.setDetectCellType(true);
			configuration.setPrintPageWidth(200);
			configuration.setIgnoreCellBorder(false);
			configuration.setAutoFitPageHeight(true);
			configuration.setCollapseRowSpan(true);

			exporter.setConfiguration(configuration);

			exporter.exportReport();

			StreamedContent download = new DefaultStreamedContent();
			File file = new File(dirPath + fileName.concat(".xls"));
			InputStream input = new FileInputStream(file);
			ExternalContext externalContext = FacesContext.getCurrentInstance().getExternalContext();
			download = new DefaultStreamedContent(input, externalContext.getMimeType(file.getName()), file.getName());
			return download;

		} catch (Exception e) {
			e.printStackTrace();
			addErrorMessage(null, MessageId.REPORT_ERROR);
			return null;
		}

	}

	public String getStream() {
		String fullFilePath = pdfDirPath + fileName.concat(".pdf");
		return fullFilePath;

	}

	public void saveMonthlyCurrencyRate() {
		try {
			currencyService.updateAllMonthlyRate(currencyList);
			addInfoMessage(null, MessageId.UPDATE_SUCCESS, "Rate Monthly Currency");
			rebindData();
		} catch (SystemException ex) {
			handleSysException(ex);
		}
	}

	public RateDTO getRatedto() {
		return ratedto;
	}

	public VoucherDTO getVoucherDto() {
		return voucherDto;
	}

	public CurrencyType[] getCurrencyTypes() {
		return CurrencyType.values();
	}

	public List<Branch> getBranchList() {
		return branchService.findAllBranch();
	}

	public void setCurrency(MonthlyRateDto currency) {
		this.currency = currency;
	}

	public MonthlyRateDto getCurrency() {
		return currency;
	}

	public List<Currency> getCurrencyListValue() {
		return currencyListValue;
	}

	public List<MonthlyRateDto> getCurrencyList() {
		return currencyList;
	}

	public void setCurrencyList(List<MonthlyRateDto> currencyList) {
		this.currencyList = currencyList;
	}

	public List<RateDTO> getRateList() {
		return rateList;
	}

	public void setRateList(List<RateDTO> rateList) {
		this.rateList = rateList;
	}

	public EnumSet<MonthNames> getMonthSet() {
		return monthSet;
	}

	public List<ChartOfAccount> getCoaList() {
		return coaList;
	}

	public TreeNode getRoot() {
		return root;
	}

	public void setRoot(TreeNode root) {
		this.root = root;
	}

	public TreeNode[] getSelectedNodes() {
		return selectedNodes;
	}

	public void setSelectedNodes(TreeNode[] selectedNodes) {
		this.selectedNodes = selectedNodes;
	}

}
