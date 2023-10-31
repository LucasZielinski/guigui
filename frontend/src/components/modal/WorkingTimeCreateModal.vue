<template>
  <div class="fixed top-0 left-0 w-full h-full flex items-center justify-center z-50 text-black">
    <div class="bg-white w-96 md:w-1/3 rounded-lg p-4">
      <h2 class="text-lg font-semibold mb-4">Create working time</h2>
      <hr>
      <div class="mb-4">
        <slot></slot>
      </div>
      <div class="flex justify-end">
        <button @click="create" class="bg-blue-500 hover:bg-blue-700 text-white font-semibold 
        py-2 px-4 rounded-md focus:outline-none focus:ring-2 focus:ring-pastel-blue m-1">
          Create
        </button>
        <button @click="close" class="bg-gray-500 hover:bg-gray-700 text-white font-semibold
         py-2 px-4 rounded-md focus:outline-none focus:ring-2 focus:ring-pastel-blue m-1">
          Close
        </button>
      </div>
    </div>
  </div>
</template>
  
<script setup lang="ts">
import { defineProps, ref, onMounted, onUnmounted, getCurrentInstance } from 'vue';

const { title } = defineProps(['title']);
const instance = getCurrentInstance();

const create = () => {
  instance.emit('create');
};

const close = () => {
  instance.emit('close');
};
</script>
