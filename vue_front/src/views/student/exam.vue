<template>
  <div class="root">
    <el-form label-width="100px" style="width:2000px" inline>
      <input type="hidden" v-model="id">
      <input type="hidden" v-model="student_id">
      <input type="hidden" v-model="course_id">
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
      <el-form-item label="考试时间">
        <el-date-picker
          v-model="exam_date"
          type="datetime"
          value-format="yyyy-MM-dd HH:mm:ss"
          placeholder="考试时间">
        </el-date-picker>
      </el-form-item>
    </el-form>
    <el-form label-width="100px" style="width:1000px" inline>
      <el-form-item label="考试类型">
        <el-select v-model="examtype_no" clearable placeholder="考试类型" filterable>
          <el-option
            v-for="item in examtype"
            :key="item.examtype_no"
            :label="item.examtype_no"
            :value="item.examtype_no">
            <span style="float: left">{{ item.examtype_no }}</span>
            <span style="float: right; color: #8492a6; font-size: 13px">{{ item.examtype_name }}</span>
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="分数">
        <el-input v-model="exam_score" onkeyup="value=value.replace(/[^\d]/g,'')" placeholder="分数" clearable
                  maxlength="3"></el-input>
      </el-form-item>
      <el-form-item label=" ">
        <el-button type="primary" @click="saveExam()">保存</el-button>
        <el-button type="primary" @click="searchExam()">检索</el-button>
      </el-form-item>
    </el-form>
    <el-table :data="tableData" style="width: 100%" :default-sort = "{prop: 'student_no', order: 'asc'}">
      <el-table-column prop="id" v-if="false"></el-table-column>
      <el-table-column prop="student_id" v-if="false"></el-table-column>
      <el-table-column prop="course_id" v-if="false"></el-table-column>
      <el-table-column prop="examtype_no" v-if="false"></el-table-column>
      <el-table-column prop="student_no" label="学号" show-overflow-tooltip></el-table-column>
      <el-table-column prop="student_name" label="姓名" show-overflow-tooltip></el-table-column>
      <el-table-column prop="course_no" label="课程号" show-overflow-tooltip></el-table-column>
      <el-table-column prop="course_name" label="课程名" show-overflow-tooltip></el-table-column>
      <el-table-column prop="exam_date" label="考试时间" show-overflow-tooltip></el-table-column>
      <el-table-column prop="exam_score" label="分数" show-overflow-tooltip></el-table-column>
      <el-table-column prop="examtype_name" label="考试类型" show-overflow-tooltip></el-table-column>
      <el-table-column label="操作" align="right">
        <div slot-scope="scope">
          <el-button type="primary" icon="el-icon-edit" @click="editExam(scope.row)"></el-button>
          <el-button type="primary" icon="el-icon-delete" @click="deleteExam(scope.row)"></el-button>
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
  name: 'exam',
  props: {},
  data() {
    return {
      base_url: 'http://127.0.0.1:8000/api/vexam/',
      course_url: 'http://127.0.0.1:8000/api/course/',
      student_url: 'http://127.0.0.1:8000/api/student/',
      exam_url: 'http://127.0.0.1:8000/api/exam/',
      studentinfo_url: 'http://127.0.0.1:8000/api/studentinfo/',
      examtype_url: 'http://127.0.0.1:8000/api/examtype/',
      id: '',
      student_id: '',
      student_no: '',
      student_name: '',
      course_id: '',
      course_no: '',
      course_name: '',
      examtype_no: '',
      examtype_name: '',
      exam_date: '',
      exam_score: '',
      pageSize: 9, //每页数据条数
      total: 0, // 总数据条数
      currentPage: 1,//当前页数
      tableData: [],
      studentinfo: [],
      course: [],
      examtype: [],
      resp: {},
    }
  },
  methods: {
    pageChange(page){
      if(this.id != ''){
        this.id = '';
        this.student_id = '';
        this.course_id = '';
        this.student_no = '';
        this.course_no = '';
        this.examtype_no = '';
        this.exam_date = '';
        this.exam_score = '';
      }

      this.currentPage = page;
      this.searchExam(page);
    },

    searchExam(page){
      if(page == null){this.currentPage = 1};
      var search_url = this.base_url + '?page='+this.currentPage+'&page_size='+this.pageSize+
                        "&student_no=" + this.student_no + "&course_no=" + this.course_no+
                        "&exam_date=" +this.exam_date+"&examtype_no="+this.examtype_no
      axios.get(search_url)
        .then(res => {
          this.total = res.data.count
          this.tableData = res.data.results;
        });
    },

    async saveExam() {
      // 新建和更新
      // 通过url判断，为空是新建，获取到url为修改
      if (this.id == '') {
        var res_student = await axios.get(this.student_url+'?page=1&page_size=10&student_no='+this.student_no)
        var res_course = await axios.get(this.course_url+'?page=1&page_size=10&course_no='+this.course_no)
        var res_examtype = await axios.get(this.examtype_url+'?page=1&page_size=10&course_no='+this.examtype_no)
        this.student_id = res_student.data[0].url
        this.course_id = res_course.data.results[0].url
        var examtype_ForeignKey = res_examtype.data.results[0].url

        axios.post(this.exam_url, {exam_date: this.exam_date, exam_score: this.exam_score,
                                        examtype_no:examtype_ForeignKey, student_id:this.student_id,
                                        course_id:this.course_id, })
          .then(res => {
            this.id = '';
            this.student_id = '';
            this.course_id = '';
            this.student_no = '';
            this.course_no = '';
            this.examtype_no = '';
            this.exam_date = '';
            this.exam_score = '';
            this.searchExam();
          },
          err => {
              this.$message.error("主键冲突，新建失败")
            });
      } else {
        var examtype_ForeignKey=this.examtype_url+this.examtype_no+'/'
        var student_ForeignKey=this.student_url+this.student_id+'/'
        var course_ForeignKey=this.course_url+this.course_id+'/'
        axios.put(this.exam_url+this.id+'/', {exam_date: this.exam_date, exam_score: this.exam_score,
                                        examtype_no:examtype_ForeignKey, student_id:student_ForeignKey,
                                        course_id:course_ForeignKey, })
          .then(() => {
            this.id = '';
            this.student_id = '';
            this.course_id = '';
            this.student_no = '';
            this.course_no = '';
            this.examtype_no = '';
            this.exam_date = '';
            this.exam_score = '';
            this.searchExam(this.currentPage);
          });
      }
    },
    editExam(row) {
      this.id = row.id;
      this.student_id = row.student_id;
      this.course_id = row.course_id;
      this.student_no = row.student_no;
      this.course_no = row.course_no;
      this.examtype_no = row.examtype_no;
      this.exam_date = row.exam_date;
      this.exam_score = row.exam_score;
    },
    deleteExam(row) {
      axios.delete(this.exam_url + row.id)
        .then(() => {
          this.id = '';
          this.student_id = '';
          this.course_id = '';
          if((this.total - 1)/this.pageSize <= (this.currentPage - 1)){
                this.currentPage = this.currentPage - 1;
              }
              this.searchExam(this.currentPage);
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

    getExamtype(){
      axios.get(this.examtype_url + '?page=1&page_size=1000')
        .then(res => {
          this.examtype = res.data.results;
        });
    },
  },
  mounted() {
    this.searchExam();
    this.getStudent();
    this.getCourse();
    this.getExamtype();
  },
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>
p
