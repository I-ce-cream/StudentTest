<template>
  <div class="row">
    <!--  左边编辑部分  -->
    <div class="col-md-4">
      <div class="form-group">
        <input type="hidden" v-model="url">
      </div>
      <div class="form-group">
        <input type="text" v-model="examTypeNo" class="form-control" placeholder="考试类型编号">
      </div>
      <div class="form-group">
        <textarea class="form-control" v-model="examTypeName" placeholder="考试类型名称"></textarea>
      </div>
      <div class="form-group">
        <el-button class="btn btn-block btn-success" @click="saveExamType()">保存</el-button>
      </div>
    </div>
    <!--  右边数据部分  -->
    <div class="col-md-8">
      <table class="table table-bordered table-hover">
        <thead>
          <th class="text-center">考试类型编号</th>
          <th class="text-center">考试类型名称</th>
          <th class="text-center">编辑</th>
          <th class="text-center">删除</th>
        </thead>
        <tbody>
          <tr v-for="item in examtype" :key="item.url">
            <td>{{ item.examtype_no }}</td>
            <td>{{ item.examtype_name }}</td>
            <td>
              <el-button class="btn btn-success" @click="editExamType(item)">
                <i class="fa fa-edit"></i>
              </el-button>
            </td>
            <td>
              <button class="btn btn-success" @click="deleteExamType(item)">
                <i class="fa fa-trash"></i>
              </button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
export default {
  name: 'Container',
  props: {
  },
  data(){
    return{
      base_url:'http://127.0.0.1:8000/api/examtype/',
      examtype:null,
      url:'',
      examTypeNo:'',
      examTypeName:'',
    }
  },
  methods:{
    getAll(){
      axios.get(this.base_url)
      .then(res=>{
        this.examtype=res.data;
        this.url='';
        this.examTypeNo='';
        this.examTypeName='';
      });
    },
    saveExamType(){
      // 新建和更新
      // 通过url判断，为空是新建，获取到url为修改
      if(this.url == ''){
        axios.post(this.base_url,{examtype_no:this.examTypeNo, examtype_name:this.examTypeName})
          .then(()=>{
            this.getAll();
          });
      }else{
        axios.put(this.url,{examtype_no:this.examTypeNo, examtype_name:this.examTypeName})
          .then(()=>{
            this.getAll();
          });
      }
    },
    editExamType(item){
      this.url = item.url;
      this.examTypeNo = item.examtype_no;
      this.examTypeName = item.examtype_name;
    },
    deleteExamType(item){
      axios.delete(item.url)
      .then(()=>{
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
