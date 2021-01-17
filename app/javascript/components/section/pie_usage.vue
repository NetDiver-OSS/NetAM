<script>
import DoughnutChart from '../charts/pieChart'
import axios from "axios";

export default {
  props: {
    id: {
      type: String,
      required: true
    }
  },
  components: { DoughnutChart },
  data: () => ({
    loaded: false,
    chartdata: null,
    options: {
      legend: {
        labels: {
          fontColor: "#6B7280"
        },
        align: "end",
        position: "bottom"
      },
      tooltips: {
        mode: "index",
        intersect: false
      },
      hover: {
        mode: "nearest",
        intersect: true
      }
    }
  }),
  async mounted () {
    axios.get('/admin/api/sections/' + this.id).then((response) => {
      this.chartdata = response.data
      this.loaded = true
    }).catch((e) => {
      console.error(e)
    })
  }
}
</script>

<template>
  <doughnut-chart v-if="loaded" :chartdata="chartdata" :options="options" />
</template>
