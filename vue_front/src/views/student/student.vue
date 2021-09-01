<template>
  <div class="root">
    <el-form label-width="100px" style="width:1500px">
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
      </el-form>
      <el-form :inline="true" label-position="right" label-width="68px">
        <el-form-item label="学生年龄">
          <el-input v-model="student_age" placeholder="学生年龄" clearable></el-input>
        </el-form-item>
        <el-form-item label="注册日期">
          <el-date-picker type="date" placeholder="注册日期" v-model="student_date" style="width: 200px;" clearable></el-date-picker>
        </el-form-item>
        <el-form-item label="班级">
          <el-input v-model="student_class" placeholder="班级" clearable></el-input>
        </el-form-item>
        <el-button type="primary" @click="saveStudentInfo()">保存</el-button>
        <el-button type="primary" @click="">检索</el-button>
      </el-form>
    </el-form>
    <el-table :data="tableData" style="width: 100%">
      <el-table-column prop="url" v-if="false"></el-table-column>
      <el-table-column prop="student_id" v-if="false"></el-table-column>
      <el-table-column prop="student_no" label="编号" show-overflow-tooltip></el-table-column>
      <el-table-column prop="student_name" label="姓名" show-overflow-tooltip></el-table-column>
      <el-table-column prop="student_sex" label="性别" show-overflow-tooltip></el-table-column>
      <el-table-column prop="student_age" label="年龄" show-overflow-tooltip></el-table-column>
      <el-table-column prop="student_date" label="注册日期" show-overflow-tooltip></el-table-column>
      <el-table-column prop="student_class" label="班级" show-overflow-tooltip></el-table-column>
      <el-table-column label="操作" align="right">
        <div slot-scope="scope">
          <el-button type="primary" icon="el-icon-edit" @click="editStudentInfo(scope.row)"></el-button>
          <el-button type="primary" icon="el-icon-delete" @click="deleteStudentInfo(scope.row)"></el-button>
        </div>
      </el-table-column>
    </el-table>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'studentinfo',
  props: {},
  data() {
    return {
      base_url: 'http://127.0.0.1:8000/api/studentinfo/',
      url: '',
      student_id: '',
      student_no: '',
      student_name: '',
      student_sex: '',
      student_age: null,
      student_date: null,
      student_class: '',
      pageSize: 6,
      total: 6, // task总数
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
          this.student_id = '';
          this.student_no = '';
          this.student_name = '';
          this.student_sex = '';
          this.student_age = null;
          this.student_date = null;
          this.student_class = '';
        });
    },

    saveStudentInfo() {
      // 新建和更新
      // 通过url判断，为空是新建，获取到url为修改
      if (this.url == '') {
        axios.post(this.base_url, {examtype_no: this.examTypeNo, examtype_name: this.examTypeName})
          .then(() => {
            this.getAll();
          });
      } else {
        axios.put(this.url, {student_id: this.student_id, student_name: this.student_name, student_sex: this.student_sex,
          student_age: this.student_age, student_date: this.student_date, student_class: this.student_class})
          .then(() => {
            this.getAll();
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
    },
    deleteStudentInfo(row) {
      axios.delete(row.url)
        .then(() => {
          this.getAll();
        });
    },
  },
  mounted() {
    this.getAll();
  },
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>
