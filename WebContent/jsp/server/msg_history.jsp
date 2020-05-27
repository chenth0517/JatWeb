<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="../include/common-rss.jsp"%>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>消息管理</title>
</head>
<st:jspId value="msg-history"></st:jspId>
<body>
<div id="msg-management">
    <sf-panel title="消息历史管理" v-cloak>
        <el-row>
            <div class="msg-div">
                <sf-toolbar>
                    <div slot="searcher">
	                     <el-date-picker
						      v-model="startDate"
						      type="datetime"
						      placeholder="选择开始时间"
						      style="width: 200px;"
						      >
		    			</el-date-picker>
		     		    <el-date-picker
						      v-model="endDate"
						      type="datetime"
						      placeholder="选择结束时间"
						      style="width: 200px;"
						      >
		   			    </el-date-picker>
                        <el-input placeholder="输入接收地址" v-model="recvAddress" icon="search" style="width: 200px;"></el-input>
                        <el-input placeholder="输入消息内容" v-model="content" icon="search" style="width: 200px;"></el-input>
                        <el-select v-model="status" placeholder="短信发送状态" style="width: 200px;">
						    <el-option
						      v-for="item in options"
						      :key="item.value"
						      :label="item.label"
						      :value="item.value">
						    </el-option>
						</el-select>
                        <el-button type="warning" icon="search" @click="resetSearchCondition">重置</el-button>
                        <el-button type="danger" icon="delete" @click="deletemsg" :disabled="!currentRow">删除</el-button>
                    </div>
                </sf-toolbar>
                <sf-table ref="msgTable"
                          highlight-current-row
                          :height="600"
                          :export-columns="msgTableColumns"
                          url="server/message/msgMng/list.do" 
                          :query-condition="queryCondition" 
                          @selection-change="onSelectionChange"
                          @current-change="onCurrentChange">
                    <el-table-column type="selection" width="50" align="center"></el-table-column>
                    <el-table-column label="id" prop="id" width="100" ></el-table-column>
                    <el-table-column label="接收地址" prop="recvAddress" width="200"></el-table-column>
                    <el-table-column label="消息内容" prop="content" width="300"></el-table-column>
                    <el-table-column label="创建时间" prop="createTime" width="300"></el-table-column>
                    <el-table-column label="发送时间" prop="senderTime" width="300"></el-table-column>
                    <el-table-column label="状态" align="center" prop="status">
	                     <template scope="scope">
	                     	<el-tag type="success" v-if="scope.row.status==1">成功</el-tag>
	                     	<el-tag type="danger" v-if="scope.row.status==0">失败</el-tag>
	                     </template>
                    </el-table-column>
                    <el-table-column label="操作" align="center" width="200">
                        <template scope="scope">
                            <el-button size="small" type="info" @click="reSend(scope.row)">重发</el-button>
                        </template>
                    </el-table-column>
                </sf-table>
            </div>
        </el-row>
    </sf-panel>
</div>
<script>

    var msgManagement = new Vue({
        el: '#msg-management',
        data: {
        	status:'',
        	name:'',
        	startDate:'',
        	endDate:'',
        	content:'',
        	recvAddress:'',
            currentRow: null,
            msgTableColumns: [
                  {
                       title: '模板编码',
                        key: 'id'
                  },
                  {
                       title: '接收地址',
                       key: 'recvAddress'
                  },
                  {
                   	  title: '消息内容',
                      key: 'content'
                  },
                  {
                      title: '创建时间',
                      key: 'createTime'
                 },
                 {
                      title: '发送时间',
                      key: 'sendTime'
                 },
                 {
                     title: '状态',
                     key: 'status'
                }
                  ],                
            options: [ 
                      {
                        value: '',
                        label: ''
                      },{
                        value: '0',
                        label: '失败'
                      }, {
                        value: '1',
                        label: '成功'
                      }
                     ],
            buttonLoading: false,
        },
        computed: {
      	  queryCondition: function () {
                return {
                        msgContent:this.content,
                        msgRecvAddress:this.recvAddress,
	          			msgStatus:this.status,
	          			startTime:new Date(this.startDate).getTime(),
	          			endTime:new Date(this.endDate).getTime()
                }
            }
      },
        methods: {
        	 resetSearchCondition: function () {
          		this.content='',
          		this.recvAddress='',
          		this.status='',
          		this.startDate='',
          		this.endDate='';
          	   },
        	reSend:function(row)
        	{
        		if(row.status==1){
        			this.$message.warning('短信已发送成功，无需重发！');
            		return;
            		};
        		   var self = this;
                   this.$confirm("确定发送短信？",'提示',{
                       callback: function(action){
                           if(action === 'confirm'){
                            			self.$post('server/message/msgMng/reSendMessage.do', {id: row.id}, function () {
                                            self.$message.success('短信发送成功！');
                                            self.$refs['msgTable'].reload();
                                        });
                           }
                       }
                   });
        	},
            onCurrentChange: function(currentRow){
                this.currentRow = currentRow;
            },
            onSelectionChange: function (selection) {
                this.selection = selection;
            },
            deletemsg: function () {
                var self = this;
                this.$confirm("确定删除消息历史？",'提示',{
                    type: 'warning',
                    callback: function(action){
                        if(action === 'confirm'){
                            self.$post('server/message/msgMng/deleteMessageHistory.do',{
                            		msgHistoryIds: self.selection.map(function (msgHistory) {
                               		return msgHistory.id;
                            })
                        }, function () {
                                self.$message.success('删除成功！');
                                self.$refs['msgTable'].reload();
                            });
                        }
                    }
                });
            }
        }
    })
</script>
</body>
</html>