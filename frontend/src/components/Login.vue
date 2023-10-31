<template>
  <div class="flex justify-center items-center mt-52">
    <div class="w-full max-w-xs">
      <form class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4" @submit.prevent="login">
        <div class="identity-input mb-4">
          <label for="identity" class="block text-gray-700 text-sm font-bold mb-2">
            Username
          </label>

          <input
            id="identity"
            class="shadow appearance-none borderrounded w-full py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none focus:shadow-outline"
            type="text" placeholder="lucas" v-model="username"/>
          <span class="text-xs text-red-700" id="usernameHelp"></span>
        </div>

        <div class="email-input mb-6">
          <label for="identity"  class="block text-gray-700 text-sm font-bold mb-2">
            email
         </label>
          <input
            v-model="email"
            class="shadow appearance-none borderrounded w-full py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none focus:shadow-outline"
            id="email" type="email" placeholder="lucas@gmail.com"/>
          <span class="text-xs text-red-700" id="emailHelp"></span>
        </div>

        <div class="flex items-center justify-between">
          <button
            class="bg-blue-600 hover:bg-black text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline text-black" type="submit">
            Login
          </button>
        </div>
      </form>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useRoute, useRouter } from 'vue-router'
import axios from 'axios'
import { ref, onMounted } from 'vue'

const apiLink = 'http://localhost:4000/api';
const username = ref('')
const email = ref('')

async function login() {
  try {
      const response = await axios.get(apiLink + `/users?email=${email.value}&username=${username.value}`)
      if (response.status === 200 && response.data.data.length > 0) {

        const userData = response.data.data[0]; 
        const userDataSubset = {
        id: userData.id,
        username: userData.username,
        email: userData.email};

        localStorage.setItem('userData', JSON.stringify(userDataSubset));
        window.location.reload();
      } else {
          alert('Identifiants incorrects.')
      }
    } catch (error) {
        console.error(error)
    }
}

</script>