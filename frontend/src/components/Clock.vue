<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import axios from 'axios'
import EditModal from './modal/WorkingTimeEditModal.vue'
import CreateModal from './modal/WorkingTimeCreateModal.vue'
import NoWorkResult from 'postcss/lib/no-work-result'

const apiLink = 'http://localhost:4000/api/'

const data = ref([])
const createWorkingTimeModalOpen = ref(false)
const selectedWorkingTimeToEdit = ref(null)
const route = useRoute()
const username = route.params.username

const current_clock = ref({
  time: null,
  status: false
});

const userData = localStorage.getItem('userData');
let userId = ""
if (userData != null) {
  const data = JSON.parse(userData);
  userId = data.id;
}

async function clockIn(userId: string, currentClockId: string) {

  deleteUser(currentClockId)

  let clock = {
    clock : {
      time : new Date(),
      status : true
    }
  }
  try {
    const response = await axios.post(apiLink + `clocks/` + userId, clock)
    if (response.status === 201) {
      console.log(response.data.data)
      setCurrentClock(response.data.data)
    } else {
      alert('Failed to create user.')
    }
  } catch (error) {
    console.log(error)
  }
}

async function clockOut(userId: string, currentClockId: string) {

  deleteUser(currentClockId)

  let clock = {
    clock : {
      time : new Date(),
      status : false
    }
  }

  try {
    const response = await axios.post(apiLink + `clocks/` + userId, clock)
    if (response.status === 201) {
      console.log(response.data.data)
      setCurrentClock(response.data.data)
    } else {
      alert('Failed to create user.')
    }
  } catch (error) {
    console.log(error)
  }
}

async function getCurrentClock(userId: string) {
  try {
    const response = await axios.get(apiLink + '/clocks/' + userId);
    if (response.status === 200) {
      current_clock.value = response.data.data[0];
    } else {
      alert('Failed to fetch users.');
    }
  } catch (error) {
    console.error(error);
  }
}

function setCurrentClock(clock: any) {
      current_clock.value = clock;
}

async function deleteUser(currentClockId: String) {
  try {
    const response = await axios.delete(apiLink + `/clocks/${currentClockId}`);
    if (response.status === 204) {
    } else {
      alert('Failed to delete clock.');
    }
  } catch (error) {
    console.log(error);
  }
}

onMounted(() => {
  getCurrentClock(userId)
})
</script>

<template>
  <main class="color-comon-text inline-block mt-5 bg-white border rounded-lg">
    <div class="m-5">
      <div class="flex mb-5 items-center text-black" v-if="current_clock.status === true">
        <h1 class="font-bold text-black">Clock out</h1>
        <button
          @click="clockOut(userId, current_clock.id)"
          type="button"
          class="bg-red-800 text-white px-4 py-2 rounded-md ml-4"
        >
          <font-awesome-icon :icon="['fas', 'plus']" />
        </button>
      </div>
      <div v-else class="text-black">
        <h1 class="font-bold text-black">Clock in</h1>
        <button
          @click="clockIn(userId, current_clock.id)"
          type="button"
          class="bg-green-800 text-white px-4 py-2 rounded-md ml-4"
        >
          <font-awesome-icon :icon="['fas', 'plus']" />
        </button>
      </div>
      
    </div>
  </main>
</template>
