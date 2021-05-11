<script>
import * as echarts from 'echarts/core';
import { TooltipComponent, LegendComponent } from 'echarts/components';
import { PieChart } from 'echarts/charts';
import { CanvasRenderer } from 'echarts/renderers';

echarts.use(
  [TooltipComponent, LegendComponent, PieChart, CanvasRenderer]
);

import axios from "axios";
import Cookies from "js-cookie";

export default {
  props: {
    id: {
      type: String,
      required: true
    }
  },
  mounted() {
    axios.get(`/admin/api/sections/${this.id}`).then((response) => {
      const option = {
        darkMode: Cookies.get('theme') === 'dark',
        tooltip: {
          trigger: 'item'
        },
        legend: {
          top: '5%',
          left: 'center',
          textStyle: {
            color: Cookies.get('theme') === 'dark' ? '#B9B8CE' : '#737382'
          }
        },
        series: [
          {
            name: `Section ${this.id}`,
            type: 'pie',
            radius: ['40%', '70%'],
            avoidLabelOverlap: false,
            itemStyle: {
              borderRadius: 10,
              borderWidth: 2
            },
            label: {
              show: false,
              position: 'center'
            },
            emphasis: {
              label: {
                show: true,
                fontSize: '26'
              }
            },
            labelLine: {
              show: false
            },
            data: response.data.data
          }
        ]
      };

      const myChart = echarts.init(this.$refs.chart);
      myChart.setOption(option);

    }).catch((e) => {
      console.error(e)
    })
  }
}
</script>

<template>
  <div ref="chart" style="height: 350px; width: 350px" />
</template>
