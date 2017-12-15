<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.5.2/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.5.2/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.5.2/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.5.2/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.5.2/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
	var url;
	
	function searchProductSmallType(){
		$("#dg").datagrid('load',{
			"s_productSmallType.name":$("#s_productSmallTypeName").val()
		});
	}
	
	function openProductSmallTypeAddDialog(){
		$("#dlg").dialog("open").dialog("setTitle","添加商品小类信息");
		url="productSmallType_save.action";
	}
	
	function saveProductSmallType(){
		$("#fm").form("submit",{
			url:url,
			onSubmit:function(){
				if($("#bName").combobox("getValue")==""){
					$.messager.alert("系统提示","请选择商品大类！");
					return false;
				}
				return $(this).form("validate");
			},
			success:function(result){
				var result=eval('('+result+')');
				if(result.success){
					$.messager.alert("系统提示","保存成功！");
					resetValue();
					$("#dlg").dialog("close");
					$("#dg").datagrid("reload");
				}else{
					$.messager.alert("系统提示","保存失败！");
					return;
				}
			}
		});
	}
	
	function openProductSmallTypeModifyDialog(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		$("#dlg").dialog("open").dialog("setTitle","编辑商品小类信息");
		$("#bName").combobox("setValue",row.bigType.id);
		$("#name").val(row.name);
		$("#remarks").val(row.remarks);
		url="productSmallType_save.action?productSmallType.id="+row.id;
	}
	
	function deleteProductSmallType(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要删除的数据！");
			return;
		}
		var strIds=[];
		for(var i=0;i<selectedRows.length;i++){
			strIds.push(selectedRows[i].id);
		}
		var ids=strIds.join(",");
		$.messager.confirm("系统提示","您确认要删除这<font color=red>"+selectedRows.length+"</font>个商品小类吗？",function(r){
			if(r){
				$.post("productSmallType_delete.action",{ids:ids},function(result){
					if(result.success){
						if(result.exist){
							$.messager.alert("系统提示",result.exist);
						}else{
							$.messager.alert("系统提示","商品小类已成功删除！");
						}
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert("系统提示","商品小类删除失败！");
					}
				},"json");
			}
		});
	}
	
	function resetValue(){
		$("#bName").combobox("setValue","");
		$("#name").val("");
		$("#remarks").val("");
	}
	
	function closeProductSmallTypeAddDialog(){
		$("#dlg").dialog("close");
		resetValue();
	}
	
	function formatBigTypeId(val,row){
		return row.bigType.id;
	}
	
	function formatBigTypeName(val,row){
		return row.bigType.name;
	}
</script>
</head>
<body style="margin:1px;">
	<table id="dg" title="商品小类管理" class="easyui-datagrid" fitColumns="true" pagination="true" rownumbers="true"
				url="productSmallType_list.action" fit="true" toolbar="#tb">
		<thead>
			<tr>
				<th field="cb" checkbox="true" align="center"></th>
				<th field="id" width="50" align="center">编号</th>
				<th field="name" width="100" align="center">商品小类名称</th>
				<th field="bigType.id" width="100" align="center" formatter="formatBigTypeId" hidden="true">商品大类id</th>
				<th field="bigType.name" width="100" align="center" formatter="formatBigTypeName">商品大类名称</th>
				<th field="remarks" width="200" align="center">备注</th>
			</tr>
		</thead>
	</table>
	
	<div id="tb">
		<div>
			<a href="javascript:openProductSmallTypeAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
			<a href="javascript:openProductSmallTypeModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
			<a href="javascript:deleteProductSmallType()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
		</div>
		<div>
			&nbsp;商品小类名称：&nbsp;<input type="text" id="s_productSmallTypeName" size="20" onkeydown="if(event.keyCode==13) searchProductSmallType()">
			<a href="javascript:searchProductSmallType()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
		</div>
	</div>
	
	<div id="dlg" class="easyui-dialog" style="width:500px;height:350px;padding:10px 20px;" closed="true" buttons="#dlg-buttons">
		<form id="fm" action="" method="post">
			<table style="border-collapse:separate; border-spacing:5px 15px;">
				<tr>
					<td>所属大类：</td>
					<td colspan="4"><input id="bName" name="productSmallType.bigType.id" class="easyui-combobox" data-options="panelHeight:'auto',editable:false,valueField:'id',textField:'name',url:'productBigType_comboList.action'"></td>
				</tr>
				<tr>
					<td>小类名称：</td>
					<td colspan="4"><input type="text" id="name" name="productSmallType.name" class="easyui-validatebox" required="true"></td>
				</tr>
				<tr>
					<td valign="top">备注</td>
					<td colspan="4">
						<textarea rows="7" cols="50" name="productSmallType.remarks" id="remarks"></textarea>
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	<div id="dlg-buttons">
		<a href="javascript:saveProductSmallType()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
		<a href="javascript:closeProductSmallTypeAddDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
</body>
</html>