<template>
  <div class="root">
    <el-form label-width="100px" style="width:1000px" inline>
      <input type="hidden" v-model="url">
      <el-form-item label="考试类型编号">
        <el-input v-model="examTypeNo" placeholder="考试类型编号" clearable></el-input>
      </el-form-item>
      <el-form-item label="考试类型名称">
        <el-input v-model="examTypeName" placeholder="考试类型名称" clearable></el-input>
      </el-form-item>
      <el-button type="primary" @click="saveExamType()">保存</el-button>
      <el-button type="primary" @click="searchExamType()">检索</el-button>
    </el-form>
    <el-table :data="tableData" style="width: 100%" :default-sort = "{prop: 'examtype_no', order: 'asc'}">
      <el-table-column prop="examtype_no" label="考试类型编号" show-overflow-tooltip></el-table-column>
      <el-table-column prop="examtype_name" label="考试类型名称" show-overflow-tooltip></el-table-column>
      <el-table-column prop="url" v-if="false"></el-table-column>
      <el-table-column label="操作" align="right">
        <div slot-scope="scope">
          <el-button type="primary" icon="el-icon-edit" @click="editExamType(scope.row)"></el-button>
          <el-button type="primary" icon="el-icon-delete" @click="deleteExamType(scope.row)"></el-button>
        </div>
      </el-table-column>
    </el-table>
    <el-pagination
      :hide-on-single-page="true"
      background
      layout="prev, pager, next"
      :total="total"
      :page-size="pageSize"
      :current-page="currentPage"
      @current-change="pageChange"
      @prev-click="pageChange"
      @next-click="pageChange"
    ></el-pagination>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'examtype',
  props: {},
  data() {
    return {
      base_url: 'http://127.0.0.1:8000/api/examtype/',
      url: '',
      examTypeNo: '',
      examTypeName: '',
      pageSize: 9, //每页数据条数
      total: 0, // 总数据条数
      currentPage: 1,//当前页数
      tableData: [],
      resp: {},
    }
  },
  methods: {
    getAll() {
      axios.get(this.base_url + '?page='+this.currentPage+'&page_size='+this.pageSize)
        .then(res => {
          this.resp = res;
          this.total = res.data.count;
          this.tableData = res.data.results;
          this.url = '';
          this.examTypeNo = '';
          this.examTypeName = '';
        });
    },

    pageChange(page){
      this.currentPage = page;
      this.searchExamType(page);
    },

    searchExamType(page){
      if(page == null){this.currentPage = 1};
      var search_url = this.base_url + '?page='+this.currentPage+'&page_size='+this.pageSize+
                        "&examtype_no=" + this.examTypeNo + "&examtype_name=" + this.examTypeName
      axios.get(search_url)
        .then(res => {
          this.total = res.data.count
          this.tableData = res.data.results;
          this.url = '';
        });
    },

    saveExamType() {
      // 新建和更新
      // 通过url判断，为空是新建，获取到url为修改
      if (this.url == '') {
        axios.post(this.base_url, {examtype_no: this.examTypeNo, examtype_name: this.examTypeName})
          .then(res => {
            this.examTypeNo = '';
            this.examTypeName = '';
            this.searchExamType();
          },
          err => {
              this.$message.error("主键冲突，新建失败")
            });
      } else {
        axios.put(this.url, {examtype_no: this.examTypeNo, examtype_name: this.examTypeName})
          .then(() => {
            this.examTypeNo = '';
            this.examTypeName = '';
            this.searchExamType(this.currentPage);
          });
      }
    },
    editExamType(row) {
      this.url = row.url;
      this.examTypeNo = row.examtype_no;
      this.examTypeName = row.examtype_name;
    },
    deleteExamType(row) {
      axios.delete(row.url)
        .then(() => {
          this.examTypeNo = '';
          this.examTypeName = '';
          if((this.total - 1)/this.pageSize <= (this.currentPage - 1)){
                this.currentPage = this.currentPage - 1;
              }
              this.searchExamType(this.currentPage);
        });
    },
  },
  mounted() {
    this.searchExamType();
  },
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>
