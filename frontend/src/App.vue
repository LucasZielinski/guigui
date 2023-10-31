<script setup lang="ts">
import { RouterLink, RouterView } from 'vue-router'
import SideBar from './components/SideBar.vue'
import User from './components/User.vue'
import Login from './components/Login.vue'

const userData = localStorage.getItem('userData');

</script>

<template>
  <div class="flex-container">
    <SideBar/>
    <div class="main-content" v-if="userData">
      <div class="user-container">
        <User />
      </div>
      <div class="router-view-container">
        <RouterView />
      </div>
    </div>
    <div v-else class="login-container">
      <Login/>
    </div>
  </div>
</template>

<style scoped>
.logo-container {
  height: 10%;
}
.sidebar-width {
  width: 300px;
}

body {
  width: 100%;
  height: 100%;
  font-family: 'Lato', sans-serif;
}

.color-comon-text {
  color: #000000;
}
.color-link-sidebar {
  color: #8491a5;
}
.flex-container {
  display: flex;
  align-items: flex-start; 
}

.main-content {
  width: 100%;
  display: flex;
  flex-direction: column;
}

.user-container {
  width: 100%;
  height: 25%;
  min-height: 30vh;
  max-height: 30vh;
  overflow-y: auto; 
  padding: 10px; 
  background-color: #fff;
  border: 1px solid #ddd; 
}

.router-view-container {
  width: 100%;
  padding: 10px;
  background-color: #f5f5f5;
  border: 1px solid #ddd;
  overflow-y: auto; 
  max-height: 70vh;
}

@media (max-width: 768px) {
  .main-content {
    flex-direction: column;
  }

  .login-container,
  .router-view-container {
    width: 100%; 
  }
}

.login-container{
  width: 100%;
}
.center-content {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 150vh;
  height: 100vh;
}

</style>
