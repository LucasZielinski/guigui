<script lang="ts">
import { Bar } from 'vue-chartjs'
import { Chart as ChartJS, Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale } from 'chart.js'

ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale)

export default {
  name: 'BarChart',
  components: { Bar },
  data() {
  return {
    chartData: {
      labels: ['January', 'February', 'March'],
      datasets: [{
        data: [40, 20, 12],
        backgroundColor: [
          'rgba(255, 99, 132, 0.2)', 
          'rgba(54, 162, 235, 0.2)',
          'rgba(255, 206, 86, 0.2)' 
        ],
        borderColor: [
          'rgba(255, 99, 132, 1)',  
          'rgba(54, 162, 235, 1)',  
          'rgba(255, 206, 86, 1)' 
        ],
        borderWidth: 1
      }]
    },
    chartOptions: {
      responsive: true
    }
  }
}

}
</script>

<template>
  <Bar
    id="my-chart-id"
    :options="chartOptions"
    :data="chartData"
  />
</template>

<style>
@media (min-width: 1024px) {
  .about {
    min-height: 100vh;
    display: flex;
    align-items: center;
  }
}

.black-font {
  color: black;
}
</style>
