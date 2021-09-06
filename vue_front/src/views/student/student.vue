<template>
  <div class="root">
    <el-form label-width="100px" style="width:2000px">
      <input type="hidden" v-model="url">
      <input type="hidden" v-model="student_id">
      <el-form :inline="true">
        <el-form-item label="学生编号">
          <el-input v-model="student_no" placeholder="学生编号" clearable></el-input>
        </el-form-item>
        <el-form-item label="学生姓名">
          <el-input v-model="student_name" placeholder="学生姓名" clearable></el-input>
        </el-form-item>
        <el-form-item label="学生性别">
          <el-select v-model="student_sex" placeholder="学生性别" clearable>
            <el-option label="男" value="男"></el-option>
            <el-option label="女" value="女"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="注册时间">
          <el-date-picker type="date" placeholder="注册时间" v-model="registration_date" style="width: 200px;" clearable
                          value-format="yyyy-MM-dd"></el-date-picker>
        </el-form-item>
      </el-form>
      <el-form :inline="true" label-position="right" label-width="68px">
        <el-form-item label="学生年龄">
          <el-input v-model="student_age" placeholder="学生年龄" clearable></el-input>
        </el-form-item>
        <el-form-item label="生日">
          <el-date-picker type="date" placeholder="生日" v-model="student_date" style="width: 200px;" clearable
                          value-format="yyyy-MM-dd"></el-date-picker>
        </el-form-item>
        <el-form-item label="班级">
          <el-input v-model="student_class" placeholder="班级" clearable></el-input>
        </el-form-item>
        <el-button type="primary" @click="saveStudentInfo()">保存</el-button>
        <el-button type="primary" @click="searchStudentInfo()">检索</el-button>
      </el-form>
    </el-form>
    <el-table :data="tableData" style="width: 100%" :default-sort = "{prop: 'student_no', order: 'asc'}">
      <el-table-column prop="url" v-if="false"></el-table-column>
      <el-table-column prop="student_id" v-if="false"></el-table-column>
      <el-table-column prop="student_no" label="编号" show-overflow-tooltip></el-table-column>
      <el-table-column prop="student_name" label="姓名" show-overflow-tooltip></el-table-column>
      <el-table-column prop="student_sex" label="性别" show-overflow-tooltip></el-table-column>
      <el-table-column prop="student_age" label="年龄" show-overflow-tooltip></el-table-column>
      <el-table-column prop="student_date" label="生日" show-overflow-tooltip></el-table-column>
      <el-table-column prop="student_class" label="班级" show-overflow-tooltip></el-table-column>
      <el-table-column prop="registration_date" label="注册日期" show-overflow-tooltip></el-table-column>
      <el-table-column label="操作" align="right">
        <div slot-scope="scope">
          <el-button type="primary" icon="el-icon-edit" @click="editStudentInfo(scope.row)"></el-button>
          <el-button type="primary" icon="el-icon-delete" @click="deleteStudentInfo(scope.row)"></el-button>
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
  name: 'studentinfo',
  props: {},
  data() {
    return {
      studentinfo_base_url: 'http://127.0.0.1:8000/api/studentinfo/',
      student_base_url: 'http://127.0.0.1:8000/api/student/',
      url: '',
      student_id: '',
      student_no: '',
      student_name: '',
      student_sex: '',
      student_age: '',
      student_date: '',
      student_class: '',
      registration_date: '',
      pageSize: 9, //每页数据条数
      total: 0, // 总数据条数
      currentPage: 1,//当前页数
      tableData: [],
      resp: {},
    }
  },
  methods: {
    getAll() {
      axios.get(this.studentinfo_base_url)
        .then(res => {
          this.tableData = res.data;
          this.url = '';
          this.student_id = '';
          this.student_no = '';
          this.student_name = '';
          this.student_sex = '';
          this.student_age = null;
          this.student_date = null;
          this.student_class = '';
        });
    },

    pageChange(page){
      this.currentPage = page;
      this.searchStudentInfo(page);
    },

    searchStudentInfo(page){
      var id = '';
      var age = '';
      var date = '';
      var reg_date = '';

      if(page == null){this.currentPage = 1};
      if(this.student_age == null){ age = ''}else{ age = this.student_age };
      if(this.student_date == null){ date = ''}else{ date = this.student_date };
      if(this.registration_date == null){ reg_date = ''}else{ reg_date = this.registration_date};

      if (this.student_no != ''){
        axios.get(this.student_base_url + "?student_no=" + this.student_no)
          .then(res => {
            this.resp = res;
            // if(this.resp == null){ id = ''}else{ id = this.resp.data[0].student_id };
            id = this.resp.data[0].student_id;

            var search_url = this.studentinfo_base_url + '?page='+this.currentPage+'&page_size='+this.pageSize+
                            "&student_id=" + id + "&student_name=" + this.student_name +
                            "&student_sex=" + this.student_sex + "&student_age=" + age + "&student_date=" +
                            date + "&student_class=" + this.student_class + "&registration_date=" + reg_date
            axios.get(search_url)
              .then(res => {
                this.total = res.data.count
                this.tableData = res.data.results;
                this.url = '';
              });
          })
      }else{
        var search_url = this.studentinfo_base_url + '?page='+this.currentPage+'&page_size='+this.pageSize+
                        "&student_id=" + id + "&student_name=" + this.student_name +
                        "&student_sex=" + this.student_sex + "&student_age=" + age + "&student_date=" +
                        date + "&student_class=" + this.student_class + "&registration_date=" + reg_date
        axios.get(search_url)
          .then(res => {
            this.total = res.data.count
            this.tableData = res.data.results;
            this.url = '';
          });
      }



    },

    saveStudentInfo() {
      // 新建和更新
      // 通过url判断，为空是新建，获取到url为修改
      if (this.url == '') {
        axios.post(this.student_base_url, {student_no: this.student_no})
          .then(res => {
              this.resp = res
              this.student_id = this.resp.data.url
              axios.post(this.studentinfo_base_url, {
                student_id: this.student_id, student_name: this.student_name, student_sex: this.student_sex,
                student_age: this.student_age, student_date: this.student_date, student_class: this.student_class,
                registration_date: this.registration_date,
              })
                .then(res => {
                  this.student_id = '';
                  this.student_no = '';
                  this.student_name = '';
                  this.student_sex = '';
                  this.student_age = null;
                  this.student_date = null;
                  this.registration_date = null;
                  this.student_class = '';
                  this.searchStudentInfo();
                });
            },
            err => {
              this.$message.error("学号已经存在，新建失败")
            });
      } else {
        axios.put(this.url, {
          student_id: this.student_id, student_name: this.student_name, student_sex: this.student_sex,
          student_age: this.student_age, student_date: this.student_date, student_class: this.student_class,
          registration_date: this.registration_date,
        })
          .then(res => {
              this.student_id = '';
              this.student_no = '';
              this.student_name = '';
              this.student_sex = '';
              this.student_age = null;
              this.student_date = null;
              this.registration_date = null;
              this.student_class = '';
              this.searchStudentInfo(this.currentPage);
            },
            err => {
              this.$message.error("更新失败")
            });
      }
    },
    editStudentInfo(row) {
      this.url = row.url;
      this.student_id = row.student_id;
      this.student_no = row.student_no;
      this.student_name = row.student_name;
      this.student_sex = row.student_sex;
      this.student_age = row.student_age;
      this.student_date = row.student_date;
      this.student_class = row.student_class;
      this.registration_date = row.registration_date;
    },
    deleteStudentInfo(row) {
      axios.delete(row.url)
        .then(() => {
          axios.delete(row.student_id)
            .then(() => {
              this.student_id = '';
              this.student_no = '';
              this.student_name = '';
              this.student_sex = '';
              this.student_age = null;
              this.student_date = null;
              this.registration_date = null;
              this.student_class = '';
              if((this.total - 1)/this.pageSize <= (this.currentPage - 1)){
                this.currentPage = this.currentPage - 1;
              }
              this.searchStudentInfo(this.currentPage);
            });
        });
    },
  },
  mounted() {
    this.searchStudentInfo();
  },
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>
