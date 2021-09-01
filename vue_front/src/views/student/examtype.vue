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
      <el-button type="primary" @click="">检索</el-button>
    </el-form>
    <el-table :data="tableData" style="width: 100%">
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
          this.examTypeNo = '';
          this.examTypeName = '';
        });
    },

    saveExamType() {
      // 新建和更新
      // 通过url判断，为空是新建，获取到url为修改
      if (this.url == '') {
        axios.post(this.base_url, {examtype_no: this.examTypeNo, examtype_name: this.examTypeName})
          .then(() => {
            this.getAll();
          });
      } else {
        axios.put(this.url, {examtype_no: this.examTypeNo, examtype_name: this.examTypeName})
          .then(() => {
            this.getAll();
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
