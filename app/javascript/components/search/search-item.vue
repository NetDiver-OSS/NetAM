<script>
export default {
  props: {
    resource:{
      type: String,
      required: true
    },
    items: {
      type: Array,
      required: true
    }
  },
  computed: {
    fields() {
      return {
        resource: __(this.resource.replaceAll('_', ' '))
      }
    }
  },
  methods: {
    resourceURL(id) {
      return `/${this.resource}/${id}`
    }
  }
}
</script>

<template>
  <div class="divide-y divide-gray-200 dark:divide-gray-700">
    <a :href="resourceURL(item.document.id)" class="block px-4 py-2 text-sm text-gray-700 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-400" v-for="item in items">
      <div class="inline-flex divide-x divide-gray-200">
        <div class="pr-3 flex items-center capitalize">
          {{ fields.resource }}
        </div>
        <div class="pl-3">
          <h3 class="text-lg leading-6 font-medium text-gray-900 dark:text-gray-100 uppercase">
            {{ item.document.name }}
          </h3>
          <p class="mt-1 text-sm text-gray-500" v-if="item.document.description !== ''">
            {{ item.document.description }}
          </p>
        </div>
      </div>
    </a>
  </div>
</template>
