<%@ tag trimDirectiveWhitespaces="true"  pageEncoding="UTF-8"%>
<%@ taglib prefix="a" uri="/WEB-INF/app.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="w" uri="http://www.unidal.org/web/core"%>
<%@ taglib prefix="res" uri="http://www.unidal.org/webres"%>
<%@ attribute name="title"%>
<%@ attribute name="navUrlPrefix"%>
<%@ attribute name="timestamp"%>
<%@ attribute name="subtitle" fragment="true"%>

<a:body_with_nav>
<script>
	function buildHref(domain){
		var href = '<a href="?op=${payload.action.name}&domain='+domain+'&date=${model.date}">&nbsp;[&nbsp;'+domain+'&nbsp;]&nbsp;</a>';
		return href;
	}
	$(document).ready(function() {
		var domains= getcookie('CAT_DOMAINS');
		var domainArray =domains.split("|");
		var html = '';
		var length =domainArray.length;
		
		for(var i=0;i<length;i++){
			var href = buildHref(domainArray[i])
			html+= href;
		}
		$('#frequentNavbar').html(html);
		$("#search_go").bind("click",function(e){
			var newUrl = '${model.baseUri}?op=${payload.action.name}&domain='+$( "#search" ).val() +'&date=${model.date}';
			window.location.href = newUrl;
		});
		$('#wrap_search').submit(
			function(){
				var newUrl = '${model.baseUri}?op=${payload.action.name}&domain='+$( "#search" ).val() +'&date=${model.date}';
				window.location.href = newUrl;
				return false;
			}		
		);
	});
</script>
<div class="report">
	<div class="domainNavbar" style="display:none;font-size:small">
		<table border="1" rules="all" >
			<c:forEach var="item" items="${model.domainGroups}">
				<tr>
					<c:set var="detail" value="${item.value}" />
					<td class="department" rowspan="${w:size(detail.projectLines)}">${item.key}</td>
					<c:forEach var="productline" items="${detail.projectLines}" varStatus="index">
							<c:if test="${index.index != 0}">
								<tr>
							</c:if>
							<td class="department">${productline.key}</td>
							<td><div class="domain"><c:forEach var="domain" items="${productline.value.lineDomains}">&nbsp;<c:choose><c:when test="${model.domain eq domain}"><a class='domainItem'
													href="?op=${payload.action.name}&domain=${domain}&date=${model.date}&reportType=${payload.reportType}"
													class="current">[&nbsp;${domain}&nbsp;]</a></c:when>
													<c:otherwise><a class='domainItem'
													href="?op=${payload.action.name}&domain=${domain}&date=${model.date}&reportType=${payload.reportType}">[&nbsp;${domain}&nbsp;]</a>
											</c:otherwise></c:choose>&nbsp;
									</c:forEach>
								</div>
							</td><c:if test="${index.index != 0}"></tr></c:if>
					</c:forEach>
				</tr>
			</c:forEach>
		</table>
	</div>
	<div class="frequentNavbar" style="display:none;font-size:small">
		<table class="table table-striped table-hover table-bordered table-condensed" border="1" rules="all">
			<tr>
				<td class="domain"  style="word-break:break-all" id="frequentNavbar"></td>
			<tr>
		</table>
	</div>
	<div class="breadcrumbs" id="breadcrumbs">
		<script type="text/javascript">
			try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
		</script>
		<span class="text-danger title">【报表时间】</span><span class="text-success"><jsp:invoke fragment="subtitle"/></span>
		<!-- #section:basics/content.searchbox -->
		<div class="nav-search nav" id="nav-search">
			<span class="text-danger">【<a href="?domain=${model.domain}" class="switch"><span class="text-danger">切到小时模式</span></a>】</span>
					&nbsp;&nbsp;<c:forEach var="nav" items="${model.historyNavs}">
					<c:choose>
						<c:when test="${nav.title eq payload.reportType}">
								<span>&nbsp;[ <a href="?op=history&domain=${model.domain}&ip=${model.ipAddress}&date=${model.date}&reportType=${nav.title}" class="current">${nav.title}</a> ]</span>
						</c:when>
						<c:otherwise>
								<span>&nbsp;[ <a href="?op=history&domain=${model.domain}&ip=${model.ipAddress}&date=${model.date}&reportType=${nav.title}">${nav.title}</a> ]</span>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				&nbsp;[ <a href="?op=history&domain=${model.domain}&ip=${model.ipAddress}&date=${model.date}&reportType=${payload.reportType}&step=-1&${navUrlPrefix}">${model.currentNav.last}</a> ]
				&nbsp;[ <a href="?op=history&domain=${model.domain}&ip=${model.ipAddress}&date=${model.date}&reportType=${payload.reportType}&step=1&${navUrlPrefix}">${model.currentNav.next}</a> ]
				&nbsp;[ <a href="?op=history&domain=${model.domain}&ip=${model.ipAddress}&reportType=${payload.reportType}&nav=next&${navUrlPrefix}">now</a> ]
		</div><!-- /.nav-search -->
	</div>
	<jsp:doBody />
	</div>
</a:body_with_nav>
