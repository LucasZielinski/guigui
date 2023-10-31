<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import axios from 'axios'
import EditModal from './modal/WorkingTimeEditModal.vue'
import CreateModal from './modal/WorkingTimeCreateModal.vue'

const apiLink = 'http://localhost:4000/api/'

const data = ref([])
const createWorkingTimeModalOpen = ref(false)
const selectedWorkingTimeToEdit = ref(null)
const route = useRoute()
const userId = route.params.userId
const newWorkingTime = ref({
  start: '',
  end: ''
})

async function fetchData() {
  try {
    const response = await axios.get(
      apiLink + 'workingtimes/' + userId
    )
    if (response.status === 200) {
      data.value = response.data
      console.log(data.value)
    } else {
      alert('Failed to fetch users.')
    }
  } catch (error) {
    console.error(error)
  }
}

async function editWorkingTimeById(workingTimeData: any) {
  let workingtimeDataJson = {
    workingtime: workingTimeData
  }
  try {
    console.log(workingTimeData.id)
    const response = await axios.put(apiLink + `/workingtimes/${workingTimeData.id}`, workingtimeDataJson)
    if (response.status === 200) {
      fetchData()
    } else {
      alert('Failed to update user.')
    }
  } catch (error) {
    console.log(error)
  }
}

async function deleteWorkingTime(index) {
  const workingTimeId = data.value.data[index].id
  try {
    axios
      .delete(apiLink + 'workingtimes/' + workingTimeId)
      .then((response) => {
        fetchData()
      })
      .catch((error) => {
        console.log(error)
      })
  } catch (error) {
    console.error(error)
  }
}

function createWorkingTimeModal() {
  if (newWorkingTime.value != null) {
    createWorkingTime(newWorkingTime.value)
  }
  closeCreateWorkingTimeModal()
}

function openCreateWorkingTimeModal() {
  createWorkingTimeModalOpen.value = true
}

function closeCreateWorkingTimeModal() {
  createWorkingTimeModalOpen.value = false
}

function openEditModal(user: null) {
  selectedWorkingTimeToEdit.value = user;
}

function closeUpdateWorkingTimeModal() {
  selectedWorkingTimeToEdit.value = null
}


function editWorkingTime() {
  if (selectedWorkingTimeToEdit.value != null) {
    editWorkingTimeById(selectedWorkingTimeToEdit.value)
  }
  closeUpdateWorkingTimeModal()
}

async function createWorkingTime(workingTimeData: any) {
  let workingTimeJson = {
    workingtime: workingTimeData
  }
  try {
    const response = await axios.post(apiLink + `workingtimes/` + userId, workingTimeJson)
    if (response.status === 201) {
      fetchData()
    } else {
      alert('Failed to create user.')
    }
  } catch (error) {
    console.log(error)
  }
}

onMounted(() => {
  fetchData()
})
</script>

<template>
  <main class="color-comon-text inline-block mt-5 bg-white border rounded-lg">
    <div class="m-5">
      <div class="flex mb-5 items-center">
        <h1 class="font-bold text-black">Working time</h1>
        <button
          @click="openCreateWorkingTimeModal"
          type="button"
          class="bg-green-800 text-white px-4 py-2 rounded-md ml-4"
        >
          <font-awesome-icon :icon="['fas', 'plus']" />
        </button>
      </div>
      <div v-if="data">
        <div class="flex" v-for="(item, index) in data.data" :key="index">
          <div class="flex mb-5 items-center">
            <label class="block w-24 text-gray-700 text-sm" for="username">Start date:</label>
            <input
              class="shadow ml-5 w-64 appearance-none border rounded py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
              placeholder="Start date"
              type="datetime-local"
              :value="item?.start"
              :id="'start-date' + index"
            />
          </div>

          <div class="flex ml-5 mb-5 items-center">
            <label class="block w-24 text-gray-700 text-sm" for="username">End date:</label>
            <input
              class="shadow appearance-none border rounded w-64 ml-5 py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
              placeholder="End date"
              type="datetime-local"
              :value="item?.end"
              :id="'end-date' + index"
            />
            <button
              type="button"
              class="bg-red-500 text-white px-4 py-2 rounded-md ml-4"
              @click="deleteWorkingTime(index)"
            >
              <font-awesome-icon :icon="['fas', 'trash']" />
            </button>
            <button
              type="button"
              class="bg-orange-500 text-white px-4 py-2 rounded-md ml-4"
              @click="openEditModal(item)"
            >
              <font-awesome-icon :icon="['fas', 'pencil']" />
            </button>
          </div>
        </div>
      </div>
      <div v-else><p>Chargement en cours...</p></div>
    </div>
  </main>

  <CreateModal
    v-if="createWorkingTimeModalOpen"
    :title="'Create new working time'"
    @close="closeCreateWorkingTimeModal"
    @create="createWorkingTimeModal"
  >
    <div>
      <div class="mb-4 flex flex-col items-center mt-4">
        <input
          v-model="newWorkingTime.start"
          type="datetime-local"
          placeholder="Start date"
          class="mb-2 p-2 rounded border border-gray-300 mt-2"
        />
        <input
          v-model="newWorkingTime.end"
          type="datetime-local"
          placeholder="End date"
          class="p-2 rounded border border-gray-300"
        />
      </div>
    </div>
  </CreateModal>

  <EditModal
    v-if="selectedWorkingTimeToEdit"
    title="Edit WorkingTime"
    @close="closeUpdateWorkingTimeModal"
    @validate="editWorkingTime"
  >
    <div>
      <div class="mb-4 flex flex-col items-center">
        <input
          v-model="selectedWorkingTimeToEdit.start"
          type="datetime-local"
          placeholder="Start"
          class="mb-2 p-2 rounded border border-gray-300 mt-5"
        />
        <input
          v-model="selectedWorkingTimeToEdit.end"
          type="datetime-local"
          placeholder="End"
          class="p-2 rounded border border-gray-300"
        />
      </div>
      <input v-model="selectedWorkingTimeToEdit.id" type="hidden" />
    </div>
  </EditModal>
</template>
