<template>
  <div class="fixed top-0 left-0 w-full h-full flex items-center justify-center z-50 text-black">
    <div class="bg-white w-96 md:w-1/3 rounded-lg p-4">
      <h2 class="text-lg font-semibold mb-4">Delete User: {{ title }}</h2>
      <hr>
      <div class="mb-4 mt-4">
        <p>Are you sure you want to delete this user?</p>
      </div>
      <div class="flex justify-end">
        <button @click="deleteModal" class="bg-red-500 hover:bg-red-700 text-white font-semibold 
        py-2 px-4 rounded-md focus:outline-none focus:ring-2 focus:ring-pastel-red m-1">
          Delete
        </button>
        <button @click="close" class="bg-blue-500 hover:bg-blue-700 text-white font-semibold 
        py-2 px-4 rounded-md focus:outline-none focus:ring-2 focus:ring-pastel-blue m-1">
          Cancel
        </button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { defineProps, ref, onMounted, onUnmounted, getCurrentInstance } from 'vue';

const { title } = defineProps(['title']);
const instance = getCurrentInstance();

const deleteModal = () => {
  instance.emit('delete');
};

const close = () => {
  instance.emit('close');
};
</script>