<template lang="html">
  <div class="flex flex-wrap">
    <div class="w-full my-5">
      <div class="flex flex-col min-w-0 break-words bg-white dark:bg-gray-600 w-full shadow rounded">
        <div class='rounded-t mb-0 px-2 py-3 border-0'>
          <div class='flex flex-wrap items-center'>
            <div class='mb-1 relative w-full max-w-full flex-grow flex-1'>
            <span v-for='(tab, index) in tabs'
                  :key='tab.title'
                  @click='selectTab(index)'
                  class="m-1 p-2 bg-gray-100 dark:bg-gray-500 text-gray-600 dark:text-gray-300"
                  :class='{"bg-gray-200": (index === selectedIndex), "dark:bg-gray-700": (index === selectedIndex)}'>
              {{ tab.title }}
            </span>
            </div>
          </div>
        </div>
        <slot></slot>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data () {
    return {
      selectedIndex: 0, // the index of the selected tab,
      tabs: []         // all of the tabs
    }
  },
  created () {
    this.tabs = this.$children
  },
  mounted () {
    this.selectTab(0)
  },
  methods: {
    selectTab (i) {
      this.selectedIndex = i

      // loop over all the tabs
      this.tabs.forEach((tab, index) => {
        tab.isActive = (index === i)
      })
    }
  }
}
</script>
