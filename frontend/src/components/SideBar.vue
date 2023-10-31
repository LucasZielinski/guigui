<template>
  <div class="sidebar sidebar-width justify-between h-screen flex flex-col bg-white">
    <div class="mt-5">
      <div class="flex justify-center items-center">
        <img src="@/assets/logo.png" class="w-2/3 m-4 logo-container" alt="Logo" />
      </div>
      <div class="ml-5 mt-5 flex items-center color-link-sidebar">
        <ul>
          <li class="m-2 flex items-center">
            <font-awesome-icon :icon="['fas', 'house']" />
            <RouterLink class="ml-5" to="/home">Home</RouterLink>
          </li>
          <li class="m-2 mt-5 flex items-center">
            <font-awesome-icon :icon="['fas', 'chart-line']" />
            <RouterLink class="ml-5" :to="`/workingtime/${user_id}`">Workingtime</RouterLink>
          </li>
          <li class="m-2 mt-5 flex items-center">
            <font-awesome-icon :icon="['fas', 'chart-line']" />
            <RouterLink class="ml-5" :to="`/clock/${username}`">Clock</RouterLink>
          </li>
        </ul>
      </div>
    </div>
    <div>
      <div class="p-5 flex justify-between items-center border-t border-gray-300 text-black" v-if="userData">
        <p>{{ username }}</p>
        <button class="bg-transparent hover:bg-blue-500 text-blue-700 font-semibold hover:text-white 
        py-2 px-4 border border-blue-500 hover:border-transparent rounded" @click="close" style="display: flex; align-items: center;">
          <font-awesome-icon class="mr-4" :icon="['fas', 'right-from-bracket']"/>
        </button>
      </div>
      <div v-else>
        <RouterLink class="ml-5" to="/login">
          <button class="bg-blue-500 hover:bg-blue-700 text-white font-semibold 
          py-2 px-4 rounded-md focus:outline-none focus:ring-2 focus:ring-pastel-blue mb-3">
            Login
          </button>
        </RouterLink>
      </div>
    </div>
  </div>
</template>

<style scoped>

.color-link-sidebar {
  color: #8491a5;
}
</style>

<script setup lang="ts">

const userData = localStorage.getItem('userData');
let username = "Undefinied"
let user_id = ""

if (userData != null) {
  const data = JSON.parse(userData);
  username = data.username;
  user_id = data.id;
}

function close(){
  localStorage.clear()
  window.location.reload()
}

</script>
