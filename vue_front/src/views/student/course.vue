<template>
  <div class="root">
    <el-form label-width="100px" style="width:1000px" inline>
      <input type="hidden" v-model="url">
      <el-form-item label="课程编号">
        <el-input v-model="course_no" placeholder="课程编号" clearable></el-input>
      </el-form-item>
      <el-form-item label="课程名称">
        <el-input v-model="course_name" placeholder="课程名称" clearable></el-input>
      </el-form-item>
      <el-button type="primary" @click="saveCourse()">保存</el-button>
      <el-button type="primary" @click="searchCourse()">检索</el-button>
    </el-form>
    <el-table :data="tableData" style="width: 100%" :default-sort = "{prop: 'course_no', order: 'asc'}">
      <el-table-column prop="course_no" label="课程编号" show-overflow-tooltip></el-table-column>
      <el-table-column prop="course_name" label="课程名称" show-overflow-tooltip></el-table-column>
      <el-table-column prop="url" v-if="false"></el-table-column>
      <el-table-column label="操作" align="right">
        <div slot-scope="scope">
          <el-button type="primary" icon="el-icon-edit" @click="editCourse(scope.row)"></el-button>
          <el-button type="primary" icon="el-icon-delete" @click="deleteCourse(scope.row)"></el-button>
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
  name: 'course',
  props: {},
  data() {
    return {
      base_url: 'http://127.0.0.1:8000/api/course/',
      url: '',
      course_no: '',
      course_name: '',
      pageSize: 9, //每页数据条数
      total: 0, // 总数据条数
      currentPage: 1,//当前页数
      tableData: [],
      resp: {},
    }
  },
  methods: {
    getAll() {
      axios.get(this.base_url)
        .then(res => {
          this.tableData = res.data;
          this.url = '';
          this.course_no = '';
          this.course_name = '';
        });
    },

    pageChange(page){
      this.currentPage = page;
      this.searchCourse(page);
    },

    searchCourse(page){
      if(page == null){this.currentPage = 1};
      var search_url = this.base_url + '?page='+this.currentPage+'&page_size='+this.pageSize+
                        "&course_no=" + this.course_no + "&course_name=" + this.course_name
      axios.get(search_url)
        .then(res => {
          this.total = res.data.count
          this.tableData = res.data.results;
          this.url = '';
        });
    },

    saveCourse() {
      // 新建和更新
      // 通过url判断，为空是新建，获取到url为修改
      if (this.url == '') {
        axios.post(this.base_url, {course_no: this.course_no, course_name: this.course_name})
          .then(res => {
            this.course_no = '';
            this.course_name = '';
            this.searchCourse();
          },
          err => {
              this.$message.error("主键冲突，新建失败")
            });
      } else {
        axios.put(this.url, {course_no: this.course_no, course_name: this.course_name})
          .then(() => {
            this.course_no = '';
            this.course_name = '';
            this.searchCourse(this.currentPage);
          });
      }
    },
    editCourse(row) {
      this.url = row.url;
      this.course_no = row.course_no;
      this.course_name = row.course_name;
    },
    deleteCourse(row) {
      axios.delete(row.url)
        .then(() => {
          this.course_no = '';
          this.course_name = '';
          if((this.total - 1)/this.pageSize <= (this.currentPage - 1)){
            this.currentPage = this.currentPage - 1;
          }
          this.searchCourse(this.currentPage);
        });
    },
  },
  mounted() {
    this.searchCourse();
  },
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>
