<script>
import SearchItem from "./search-item"
import { queryBuilder } from './search_query'
import axios from "axios";

export default {
  components: {SearchItem},
  data() {
    return {
      search: '',
      result: {},
    };
  },
  computed: {
    fields() {
      return {
        search: __('Search...')
      }
    }
  },
  methods: {
    typeSenseQuery() {
      axios.post('/api/v1/search', queryBuilder(this.search)).then((result) => {
        this.result = result.data.results.filter(i => i.hits !== undefined)
      })
    }
  }
}
</script>

<template>
  <div>
    <input type="search" @keyup="typeSenseQuery()" v-model="search" :placeholder="fields.search" class="block w-full h-full pl-8 pr-3 py-2 bg-white dark:bg-gray-700 border-transparent text-gray-900 dark:text-gray-300 placeholder-gray-500 focus:outline-none focus:placeholder-gray-400 focus:ring-0 focus:border-transparent sm:text-sm" />

    <div v-if="search !== '' && result !== []" class="relative top-4">
      <div class="absolute z-10 w-full bg-white dark:bg-gray-700 divide-y divide-gray-200 dark:divide-gray-700 shadow rounded-b">
        <search-item v-for="item in this.result" :resource="item.request_params.collection_name" :items="item.hits" />
      </div>
    </div>
  </div>
</template>
