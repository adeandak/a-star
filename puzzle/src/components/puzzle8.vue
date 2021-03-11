<template>
  <div class="hello">
    <h1>{{ msg }}</h1>

    <div class="table-container">
      <h4>Estado inicial: </h4> 
      <input v-model="message" placeholder="((1 2 3) (8 6 5) (7 0 4))" id="edoIni">
      <table id="table1">
        <tr>
          <th id=t1-11>1</th>
          <th id=t1-12>2</th>
          <th id=t1-13>3</th>
        </tr>
        <tr>
          <td>8</td>
          <td>6</td>
          <td>5</td>
        </tr>
        <tr>
          <th>7</th>
          <th>0</th>
          <th>4</th>
        </tr>
      </table>
    </div>

  
    <br>
          <h4>Estado Final: </h4> 
           <input v-model="message" placeholder="((1 2 3) (8 0 4) (7 6 5))" id="edoFin">
    <table id="table2">
      <tr>
        <th>0</th>
        <th>2</th>
        <th>4</th>
      </tr>
      <tr>
        <td>8</td>
        <td>1</td>
        <td>3</td>
      </tr>
      <tr>
        <th>7</th>
        <th>6</th>
        <th>5</th>
      </tr>
    </table>
  </div>
</template>

<script>
export default {
  name: 'HelloWorld',
  props: {
    msg: String
  }
}



</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}

table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
  height: 50px;
  width: 200px;
  justify-content: center;
}

.table-container {
  vertical-align: middle;
}
</style>
