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
      <el-button type="primary" @click="">检索</el-button>
    </el-form>
    <el-table :data="tableData" style="width: 100%">
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
      pageSize: 6,
      total: 6, // task总数
      tableData: [],
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

    saveCourse() {
      // 新建和更新
      // 通过url判断，为空是新建，获取到url为修改
      if (this.url == '') {
        axios.post(this.base_url, {course_no: this.course_no, course_name: this.course_name})
          .then(() => {
            this.getAll();
          });
      } else {
        axios.put(this.url, {course_no: this.course_no, course_name: this.course_name})
          .then(() => {
            this.getAll();
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
