<template>
  <div class="root">
    <el-form label-width="100px" style="width:1500px" inline>
      <el-form-item label="学号">
        <el-select v-model="student_no" clearable placeholder="学号" filterable>
          <el-option
            v-for="item in studentinfo"
            :key="item.student_no"
            :label="item.student_no"
            :value="item.student_no">
            <span style="float: left">{{ item.student_no }}</span>
            <span style="float: right; color: #8492a6; font-size: 13px">{{ item.student_name }}</span>
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="课程号">
        <el-select v-model="course_no" clearable placeholder="课程号" filterable>
          <el-option
            v-for="item in course"
            :key="item.course_no"
            :label="item.course_no"
            :value="item.course_no">
            <span style="float: left">{{ item.course_no }}</span>
            <span style="float: right; color: #8492a6; font-size: 13px">{{ item.course_name }}</span>
          </el-option>
        </el-select>
      </el-form-item>
      <el-radio v-model="radio" label="0">全部</el-radio>
      <el-radio v-model="radio" label="1">已选课程</el-radio>
      <el-radio v-model="radio" label="2">未选课程</el-radio>
      <el-button type="primary" @click="saveStudentCourse()">保存</el-button>
      <el-button type="primary" @click="searchStudentCourse()">检索</el-button>
    </el-form>
    <el-table :data="tableData" style="width: 100%" :row-style="{height:'68px'}" :default-sort = "{prop: 'student_no', order: 'asc'}">
      <el-table-column prop="student_no" label="学号" show-overflow-tooltip></el-table-column>
      <el-table-column prop="student_name" label="姓名" show-overflow-tooltip></el-table-column>
      <el-table-column prop="course_no" label="课程号" show-overflow-tooltip></el-table-column>
      <el-table-column prop="course_name" label="课程名" show-overflow-tooltip></el-table-column>
      <el-table-column prop="select_course" label="已选课程" show-overflow-tooltip></el-table-column>
      <el-table-column prop="unselect_course" label="未选课程" show-overflow-tooltip></el-table-column>
      <el-table-column prop="student_id" v-if="false"></el-table-column>
      <el-table-column prop="course_id" v-if="false"></el-table-column>
      <el-table-column prop="url" v-if="false"></el-table-column>
      <el-table-column label="操作" align="right">
        <div slot-scope="scope">
          <el-button type="primary" icon="el-icon-delete" @click="deleteStudentCourse(scope.row)"
                     v-if="scope.row.unselect_course=='-'"></el-button>
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
  name: 'studentcourse',
  props: {},
  data() {
    return {
      base_url: 'http://127.0.0.1:8000/api/vstudentcourse/',
      studentinfo_url: 'http://127.0.0.1:8000/api/studentinfo/',
      course_url: 'http://127.0.0.1:8000/api/course/',
      student_url: 'http://127.0.0.1:8000/api/student/',
      studentcourse_url: 'http://127.0.0.1:8000/api/studentcourse/',
      student_no: '',
      course_no: '',
      pageSize: 9, //每页数据条数
      total: 0, // 总数据条数
      currentPage: 1,//当前页数
      tableData: [],
      radio: '0',
      studentinfo: [],
      course: [],
      course_id: '',
      student_id: '',
      resp: {},
      res:{},
    }
  },
  methods: {
    pageChange(page){
      this.currentPage = page;
      this.searchStudentCourse(page);
    },

    searchStudentCourse(page){
      if(page == null){this.currentPage = 1};

      var selected = '';
      var unselected = '';
      switch(this.radio){
        case '0':
          selected = '';
          unselected = '';
          break;
        case '1':
          selected = '';
          unselected = '-';
          break;
        case '2':
          selected = '-';
          unselected = '';
          break;
      }
      var search_url = this.base_url + '?page='+this.currentPage+'&page_size='+this.pageSize+
                        "&student_no=" + this.student_no + "&course_no=" + this.course_no+
                        "&select_course="+selected+"&unselect_course="+unselected
      axios.get(search_url)
        .then(res => {
          this.total = res.data.count
          this.tableData = res.data.results;
        });
    },

    getStudent(){
      axios.get(this.studentinfo_url + '?page=1&page_size=1000')
        .then(res => {
          this.studentinfo = res.data.results;
        });
    },

    getCourse(){
      axios.get(this.course_url + '?page=1&page_size=1000')
        .then(res => {
          this.course = res.data.results;
        });
    },

    async saveStudentCourse() {
      var res_student = await axios.get(this.student_url+'?page=1&page_size=10&student_no='+this.student_no)
      var res_course = await axios.get(this.course_url+'?page=1&page_size=10&course_no='+this.course_no)
      this.student_id = res_student.data[0].url
      this.course_id = res_course.data.results[0].url

      await axios.post(this.studentcourse_url, {student_id:this.student_id, course_id:this.course_id, })
        .then(res=>{
          this.student_no = '';
          this.course_no = '';
          this.student_id = '';
          this.course_id = '';
          this.radio = '0';
          this.searchStudentCourse();
        },
        err => {
          this.$message.error("主键冲突，更新失败")
        })
    },

    async deleteStudentCourse(row) {
      var res = await axios.get(this.studentcourse_url+'?course_id='+row.course_id+'&student_id='+row.student_id)
      var url = res.data[0].url
      await axios.delete(url)
        .then(() => {
          if((this.total - 1)/this.pageSize <= (this.currentPage - 1)){
                this.currentPage = this.currentPage - 1;
              }
              this.searchStudentCourse(this.currentPage);
        });
    },
  },
  mounted() {
    this.searchStudentCourse();
    this.getStudent();
    this.getCourse();
  },
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>
